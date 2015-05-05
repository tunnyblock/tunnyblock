package com.thinkgem.jeesite.modules.process.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.modules.sys.entity.User;


/**
 * 动态消息Entity
 * @author 俞超
 * @version 2015-01-24
 */
@Entity
@Table(name = "dynamic_message")
public class DynamicMessage extends BaseEntity<DynamicMessage> implements Serializable{
	
	public static String PROCESS_MESSAGE="0";
	public static String COMMENT_MESSAGE="1";
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	
	private User fromUser;//消息发送者
	
	private User toUser;//消息接收者
	
	private String bussinessId;//业务逻辑编号（根据Type来确定是流程 评论 出场 进场等）,后续根据用户需要自行关联查找
	
	private String type;//0 流程消息 ；1 评论消息；2 进场消息；3 出场消息
	
	private String icon;//图标
	
	private String messageContent;//消息内容

	private Date generateTime;//消息产生时间

	private String isReaded= DynamicMessage.NO;//消息是否已读

	private Date readedTime;//消息被读时间

	private String remarks;//备注
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="FROM_USER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public User getFromUser() {
		return fromUser;
	}

	public Date getGenerateTime() {
		return generateTime;
	}

	@Id
	public String getId() {
		return id;
	}

	public String getIsReaded() {
		return isReaded;
	}

	public String getMessageContent() {
		return messageContent;
	}

	public Date getReadedTime() {
		return readedTime;
	}

	public String getRemarks() {
		return remarks;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="TO_USER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public User getToUser() {
		return toUser;
	}

	@PrePersist
	public void prePersist(){
		this.id = IdGen.uuid();
	}

	public void setFromUser(User fromUser) {
		this.fromUser = fromUser;
	}

	public void setGenerateTime(Date generateTime) {
		this.generateTime = generateTime;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public void setIsReaded(String isReaded) {
		this.isReaded = isReaded;
	}
	
	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}
	
	
	public void setReadedTime(Date readedTime) {
		this.readedTime = readedTime;
	}
	
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public void setToUser(User toUser) {
		this.toUser = toUser;
	}

	public String getBussinessId() {
		return bussinessId;
	}

	public void setBussinessId(String bussinessId) {
		this.bussinessId = bussinessId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}
	
}


