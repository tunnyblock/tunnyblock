package com.thinkgem.jeesite.modules.process.entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OrderBy;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.utils.IdGen;


/**
 * 进场目的Entity
 * @author 俞超
 * @version 2014-12-11
 */
@Entity
@Table(name = "approach_aim")
public class ApproachAim extends BaseEntity<ApproachAim> implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String id; 		// 编号
	
	private String name;//名称
	
	private String remarks;//备注
	
	private List<Task> taskList = Lists.newArrayList();//对应的任务列表
	
	@Id
	public String getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public String getRemarks() {
		return remarks;
	}

	@PrePersist
	public void prePersist(){
		this.id = IdGen.uuid();
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(name = "approach_aim_task", joinColumns = { @JoinColumn(name = "approach_aim_id") }, inverseJoinColumns = { @JoinColumn(name = "task_id") })
	@OrderBy("id") @Fetch(FetchMode.SUBSELECT)
	@NotFound(action = NotFoundAction.IGNORE)
	public List<Task> getTaskList() {
		return taskList;
	}

	public void setTaskList(List<Task> taskList) {
		this.taskList = taskList;
	}
	
}


