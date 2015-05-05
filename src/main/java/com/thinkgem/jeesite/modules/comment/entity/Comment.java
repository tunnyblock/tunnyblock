package com.thinkgem.jeesite.modules.comment.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.modules.process.entity.Process;
import com.thinkgem.jeesite.modules.sys.entity.User;


/**
 * 评论Entity
 * @author 俞超
 * @version 2015-02-05
 */
@Entity
@Table(name = "comment")
public class Comment extends BaseEntity<Comment> implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String id; 		// 编号
	
	private Process process;//流程
	
	private String content;//评论内容
	
	private User generateUser;//评论者
	
	private Date generateTime;//评论时间
	
	private String remarks;//备注
	
	private List<Affix> affixList = Lists.newArrayList();//附件列表
	
	public String getContent() {
		return content;
	}

	public Date getGenerateTime() {
		return generateTime;
	}

	@ManyToOne
	@JoinColumn(name="GENERATE_USER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	@JsonIgnore
	public User getGenerateUser() {
		return generateUser;
	}

	@Id
	public String getId() {
		return id;
	}

	@ManyToOne
	@JoinColumn(name="PROCESS_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	@JsonIgnore
	public Process getProcess() {
		return process;
	}

	public String getRemarks() {
		return remarks;
	}

	@PrePersist
	public void prePersist(){
		this.id = IdGen.uuid();
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setGenerateTime(Date generateTime) {
		this.generateTime = generateTime;
	}

	public void setGenerateUser(User generateUser) {
		this.generateUser = generateUser;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public void setProcess(Process process) {
		this.process = process;
	}
	
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	@OneToMany(mappedBy = "comment", fetch=FetchType.LAZY)
	@Fetch(FetchMode.SUBSELECT)
	@NotFound(action = NotFoundAction.IGNORE)
	@JsonIgnore
	public List<Affix> getAffixList() {
		return affixList;
	}

	public void setAffixList(List<Affix> affixList) {
		this.affixList = affixList;
	}
	
}


