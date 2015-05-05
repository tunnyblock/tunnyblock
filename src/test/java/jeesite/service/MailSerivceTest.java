package jeesite.service;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;

import com.thinkgem.jeesite.modules.process.service.mail.MailService;
import com.thinkgem.jeesite.modules.process.service.mail.MailTemplate;
import com.thinkgem.jeesite.modules.sys.entity.User;

import jeesite.BaseTestCase;

public class MailSerivceTest extends BaseTestCase{

	@Resource
	private MailService mailService;
	
	@Test
	public void sendMailTest(){
		User user = new User();
		user.setEmail("tunny_880105@163.com");
		user.setEmailPassword("******");
		MailTemplate mailTemplate = new MailTemplate();
		mailTemplate.setSubject("Template");
		mailTemplate.setContentId("Template.html");
		mailTemplate.setTo(new String[]{"chaochaoyuyu@126.com"});
		File[] affixFiles = new File[]{new File("C:\\新建文本文档.txt")};
		mailTemplate.setAffixFiles(affixFiles);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userIip", "俞超");
		map.put("name", "俞超");
		mailTemplate.setContentData(map);
		mailService.sendMail(user, mailTemplate);
	}
}
