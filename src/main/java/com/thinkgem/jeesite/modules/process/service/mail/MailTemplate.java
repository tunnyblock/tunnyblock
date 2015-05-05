package com.thinkgem.jeesite.modules.process.service.mail;

import java.io.File;
import java.util.Map;

public class MailTemplate {
	
	/**
	 * 发送自
	 */
	private String from;
	
	/**
	 * 发送给
	 */
	private String[] to;
	
	/**
	 * CC给
	 */
	private String[] cc;
	
	/**
	 * BCC给
	 */
	private String[] bcc;
	
	/**
	 * 主题
	 */
	private String subject;
	
	/**
	 * 主题的HtmlID
	 */
	private String contentId;
	
	/**
	 * 主题内容Map
	 */
	private Map<String, Object> subjectData;
	
	/**
	 * 内容Map
	 */
	private Map<String, Object> contentData;
	
	/**
	 * 附件
	 */
	private File[] affixFiles;

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String[] getTo() {
		return to;
	}

	public void setTo(String[] to) {
		this.to = to;
	}

	public String[] getCc() {
		return cc;
	}

	public void setCc(String[] cc) {
		this.cc = cc;
	}

	public String[] getBcc() {
		return bcc;
	}

	public void setBcc(String[] bcc) {
		this.bcc = bcc;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContentId() {
		return contentId;
	}

	public void setContentId(String contentId) {
		this.contentId = contentId;
	}

	public Map<String, Object> getSubjectData() {
		return subjectData;
	}

	public void setSubjectData(Map<String, Object> subjectData) {
		this.subjectData = subjectData;
	}

	public Map<String, Object> getContentData() {
		return contentData;
	}

	public void setContentData(Map<String, Object> contentData) {
		this.contentData = contentData;
	}

	public File[] getAffixFiles() {
		return affixFiles;
	}

	public void setAffixFiles(File[] affixFiles) {
		this.affixFiles = affixFiles;
	}

}
