package com.thinkgem.jeesite.modules.process.entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OrderBy;
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
import com.thinkgem.jeesite.modules.sys.entity.CompanyChargeInfo;


/**
 * 任务Entity
 * @author 俞超
 * @version 2014-12-11
 */
@SuppressWarnings("rawtypes")
@Entity
@Table(name = "task")
public class Task extends BaseEntity<Task> implements Serializable,Comparable{
	
	private static final long serialVersionUID = 1L;
	
	private String id; 		// 编号
	
	private String taskName;//任务名称
	
	private Integer sort;//排序
	
	private String isShow;//是否显示

	private String remarks;//备注
	
	private List<ApproachAim> approachAimList = Lists.newArrayList();
	
	private CompanyChargeInfo companyChargeInfo;

	@ManyToOne
	@JoinColumn(name="company_charge_info_id")
	@NotFound(action = NotFoundAction.IGNORE)
	public CompanyChargeInfo getCompanyChargeInfo() {
		return companyChargeInfo;
	}

	public void setCompanyChargeInfo(CompanyChargeInfo companyChargeInfo) {
		this.companyChargeInfo = companyChargeInfo;
	}

	@Id
	public String getId() {
		return id;
	}

	public String getRemarks() {
		return remarks;
	}

	public String getTaskName() {
		return taskName;
	}
	
	@PrePersist
	public void prePersist(){
		this.id = IdGen.uuid();
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	@ManyToMany(mappedBy = "taskList", fetch=FetchType.LAZY)
	@OrderBy("id") @Fetch(FetchMode.SUBSELECT)
	@NotFound(action = NotFoundAction.IGNORE)
	@JsonIgnore
	public List<ApproachAim> getApproachAimList() {
		return approachAimList;
	}

	public void setApproachAimList(List<ApproachAim> approachAimList) {
		this.approachAimList = approachAimList;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	@Override
	public int compareTo(Object arg0) {
		Task target = (Task) arg0;
		return this.sort.compareTo(target.getSort());
	}

	public String getIsShow() {
		return isShow;
	}

	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}
	
}


