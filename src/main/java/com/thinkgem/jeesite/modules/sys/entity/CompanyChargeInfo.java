package com.thinkgem.jeesite.modules.sys.entity;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.hibernate.validator.constraints.Length;

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.IdEntity;
import com.thinkgem.jeesite.modules.process.entity.Task;

/**
 * 公司收费标准
 * @author ThinkGem
 * @version 2013-5-15
 */
@Entity
@Table(name = "company_charge_info")
@DynamicInsert @DynamicUpdate
public class CompanyChargeInfo extends IdEntity<CompanyChargeInfo> {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	private Office company	;	//公司编号 外键
	
	private String chargeName	;	//100	收费名称
	
	private String chargeShortName;	// varchar	32	收费名称缩写
	
	private List<Task> taskList = Lists.newArrayList();  //  任务编号 外键
	
	private Integer unitPrice	;		//单价
	
	private String chargeUnit	;	//32	计价单位
	
	private String description	;	//255	描述信息
	
	@SuppressWarnings("unused")
	private List<String> taskIdList;//设置任务列表
	
	@ManyToOne
	@JoinColumn(name="company_id")
	@NotFound(action = NotFoundAction.IGNORE)
	public Office getCompany() {
		return company;
	}
	
	public void setCompany(Office company) {
		this.company = company;
	}
	
	
	@Length(min=1, max=100)
	public String getChargeName() {
		return chargeName;
	}

	public void setChargeName(String chargeName) {
		this.chargeName = chargeName;
	}

	@Length(min=1, max=32)
	public String getChargeShortName() {
		return chargeShortName;
	}
	public void setChargeShortName(String chargeShortName) {
		this.chargeShortName = chargeShortName;
	}


	@OneToMany(fetch=FetchType.LAZY,targetEntity=Task.class)
	@JoinColumn(name="company_charge_info_id")
	@OrderBy(value="id") @Fetch(FetchMode.SUBSELECT)
	/*@NotFound(action = NotFoundAction.IGNORE)*/
	@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
	public List<Task> getTaskList() {
		return taskList;
	}

	public void setTaskList(List<Task> taskList) {
		this.taskList = taskList;
	}

	public Integer getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(Integer unitPrice) {
		this.unitPrice = unitPrice;
	}
	@Length(min=1, max=32)
	public String getChargeUnit() {
		return chargeUnit;
	}
	public void setChargeUnit(String chargeUnit) {
		this.chargeUnit = chargeUnit;
	}
	
	@Length(min=1, max=255)
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	

	@Transient
	public List<String> getTaskIdList() {
		List<String> taskIdList = Lists.newArrayList();
		for (Task task : taskList) {
			taskIdList.add(task.getId());
		}
		return taskIdList;
	}

	@Transient
	public void setTaskIdList(List<String> taskIdList) {
		taskList = Lists.newArrayList();
		for (String taskId : taskIdList) {
			Task task = new Task();
			task.setId(taskId);
			taskList.add(task);
		}
	}
	
	
}