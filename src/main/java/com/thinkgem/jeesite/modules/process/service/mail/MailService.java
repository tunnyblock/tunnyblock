package com.thinkgem.jeesite.modules.process.service.mail;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.apache.commons.lang3.StringUtils;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.modules.sys.entity.User;

@Service
public class MailService {
	
	public static final String MAIL_EL_EXPRESSION = "\\$\\{([a-zA-z0-9_.]*)\\s*\\}";
	
	public static final String BASE_TEMPLATE_PATH = "/com/thinkgem/jeesite/modules/process/service/mail/template/";
	
	/**
	 * 发送邮件功能 需要设置-Djava.net.preferIPv4Stack=true
	 * 
	 * @param userName
	 * @param password
	 * @param smtpServer
	 * @param sendUser
	 * @param toUsers
	 * @param subject
	 * @param content
	 * @param contentType
	 * @param attachFiles
	 */
	public void sendMail(String userName, String password, String smtpServer,String[] toUsers, String subject, String content,File[] attachFiles) {
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		mailSender.setHost(smtpServer);
		mailSender.setUsername(userName);
		mailSender.setPassword(password);
		mailSender.setJavaMailProperties(props);
		MimeMessage mime = mailSender.createMimeMessage();
		MimeMessageHelper helper;
		try {
			helper = new MimeMessageHelper(mime, true, "utf-8");
			helper.setFrom(userName);
			helper.setTo(toUsers);
			helper.setSubject(subject);
			helper.setText(content, true);
			if(attachFiles!=null){
				for(File file:attachFiles){
					helper.addAttachment(file.getName(), file);
				}
			}
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		mailSender.send(mime);
	}
	
	/**
	 * 发送邮件模板
	 * @param user
	 * @param mailTemplate
	 */
	public void sendMail(User user,MailTemplate mailTemplate){
		try {
			String subject = fillData(mailTemplate.getSubject(),mailTemplate.getSubjectData());
			String content = fillData(getMailHtml(mailTemplate.getContentId()),mailTemplate.getContentData());
			String smtpHost = Global.getSMTPServerHost();
			if(StringUtils.isEmpty(smtpHost)){
				smtpHost = "smtp."+user.getEmail().split("@")[1];
			}
			this.sendMail(user.getEmail(), user.getEmailPassword(), smtpHost, mailTemplate.getTo(), subject, content, mailTemplate.getAffixFiles());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private String getMailHtml(String fileName) throws IOException {
		InputStream is = getClass().getResourceAsStream(BASE_TEMPLATE_PATH + fileName);
		BufferedReader br = new BufferedReader(new InputStreamReader(is));
		StringBuffer sb = new StringBuffer();
		String line = null;
		while ((line = br.readLine()) != null)
			sb.append(line);
		return sb.toString();
	}
	
	private String fillData(String text, Map<String, Object> data) {
		if (data == null)
			return text;
		Pattern pattern = Pattern.compile(MAIL_EL_EXPRESSION);
		Matcher matcher = pattern.matcher(text);

		StringBuffer sb = new StringBuffer();
		while (matcher.find()) {
			String key = matcher.group(1);
			Object value = data.get(key);
			matcher.appendReplacement(sb, formatValue(value));
		}
		matcher.appendTail(sb);
		return sb.toString();
	}
	
	private String formatValue(Object obj) {
		if (obj == null) {
			return "";
		} else if (obj instanceof String) {
			return (String) obj;
		} else if (obj instanceof String[]) {
			String[] array = (String[]) obj;
			if (array.length > 0) {
				String data = "";
				for (int i = 0; i < array.length - 1; i++) {
					data += array[i] + ", ";
				}
				data += array[array.length - 1];
				return data;
			} else {
				return "";
			}
		} else if (obj instanceof Date) {
			Date date = (Date) obj;
			return new SimpleDateFormat("yyyy-MM-dd").format(date);
		}
		return obj.toString();
	}

}
