package com.thinkgem.jeesite.modules.comment.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.modules.sys.entity.User;


/**
 * 评论附件Entity
 * @author 俞超
 * @version 2015-02-05
 */
@Entity
@Table(name = "comment_affix")
public class Affix extends BaseEntity<Affix> implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	
	private Comment comment;//评论
	
	private String affixName;//附件名称
	
	private String affixUrl;//附件地址
	
	private String type;//附件类型
	
	private String icon;//显示图标
	
	private Date generateTime;//上传时间

	private User generateUser;//上传用户

	private String remarks;//备注
	
	@SuppressWarnings("unused")
	private Boolean isImageType;//是不是图片

	public String getAffixName() {
		return affixName;
	}

	public String getAffixUrl() {
		return affixUrl;
	}

	@ManyToOne
	@JoinColumn(name="COMMENT_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	@JsonIgnore
	public Comment getComment() {
		return comment;
	}

	public Date getGenerateTime() {
		return generateTime;
	}

	@ManyToOne
	@JoinColumn(name="SYS_USER__ID")
	@NotFound(action = NotFoundAction.IGNORE)
	@JsonIgnore
	public User getGenerateUser() {
		return generateUser;
	}

	public String getIcon() {
		return icon;
	}

	@Id
	public String getId() {
		return id;
	}

	public String getRemarks() {
		return remarks;
	}

	public String getType() {
		return type;
	}

	@PrePersist
	public void prePersist(){
		this.id = IdGen.uuid();
	}

	public void setAffixName(String affixName) {
		this.affixName = affixName;
	}

	public void setAffixUrl(String affixUrl) {
		this.affixUrl = affixUrl;
	}

	public void setComment(Comment comment) {
		this.comment = comment;
	}

	public void setGenerateTime(Date generateTime) {
		this.generateTime = generateTime;
	}
	
	public void setGenerateUser(User generateUser) {
		this.generateUser = generateUser;
	}
	
	public void setIcon(String icon) {
		this.icon = icon;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public void setType(String type) {
		this.type = type;
	}

	@Transient
	public Boolean getIsImageType() {
		return ("gif".equalsIgnoreCase(this.type)||"png".equalsIgnoreCase(this.type)||"jpg".equalsIgnoreCase(this.type)||"jpeg".equalsIgnoreCase(this.type)||"bmp".equalsIgnoreCase(this.type));
	}

	public void setIsImageType(Boolean isImageType) {
		this.isImageType=isImageType;
	}
	
}


