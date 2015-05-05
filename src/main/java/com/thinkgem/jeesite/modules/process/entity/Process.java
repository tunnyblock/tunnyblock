package com.thinkgem.jeesite.modules.process.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.modules.charge.entity.ChargeDetail;
import com.thinkgem.jeesite.modules.sys.entity.CompanyChargeInfo;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 流程Entity
 * 
 * @author 俞超
 * @version 2014-12-17
 */
@Entity
@Table(name = "process")
public class Process extends BaseEntity<Process> implements Serializable {

	private static final long serialVersionUID = 1L;

	public static final String STATE_NOTSTART = "0";
	public static final String STATE_PROCESSING = "1";
	public static final String STATE_END = "2";
	public static final String STATE_WAITING_DEPART_EXAMINE="3";
	public static final String IS_VIRTUAL_NO = "0";
	public static final String IS_VIRTUAL_YES = "1";

	private String id; // 编号
	
	private ProcessIventory processIventory;// 流程清单
	
	private Process nextProcess;//下一个流程
	
	private String name;// 流程名称
	
	private Integer sort;//流程排序
	
	private CompanyChargeInfo companyChargeInfo;// 收费明细
	
	private Integer goodsCleanCharge;// 货物清洗费用
	
	private Integer otherAdditionalCharge;// 其他额外费用
	
	private String state = STATE_NOTSTART;// 流程状态 0未开始 1进行中 2已结束
	
	private Task task;// 任务

	private String isVirtual;// 是否虚拟标记 0 否 1 是

	private Date startTime;// 开始时间

	private Date updateTime;// 状态更新时间

	private Date endTime;// 结束时间
	
	private User startUser;//流程启动者
	
	private User endUser;//流程结束者，目前流程只有一对一的模式，即由客户发起，其他组别的用户完成
	
	private Date deadline;//截止日期
	
	private String affixFiles;//附件

	private String remarks;// 备注

	private Date plannedDepartTime;//预计出场时间，不存在入数据库，供出场单使用
	
	private ChargeDetail chargeDetail;//真实费用明细


	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="CHARGE_INFO_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public CompanyChargeInfo getCompanyChargeInfo() {
		return companyChargeInfo;
	}


	public Date getEndTime() {
		return endTime;
	}


	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="END_USER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public User getEndUser() {
		return endUser;
	}
	
	public Integer getGoodsCleanCharge() {
		return goodsCleanCharge;
	}


	@Id
	public String getId() {
		return id;
	}


	public String getIsVirtual() {
		return isVirtual;
	}

	public String getName() {
		return name;
	}


	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="NEXT_PROCESS_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public Process getNextProcess() {
		return nextProcess;
	}



	public Integer getOtherAdditionalCharge() {
		return otherAdditionalCharge;
	}

	@Transient
	public Date getPlannedDepartTime() {
		return plannedDepartTime;
	}

	@ManyToOne
	@JoinColumn(name="PROCESS_IVENTORY_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	@JsonIgnore
	public ProcessIventory getProcessIventory() {
		return processIventory;
	}

	public String getRemarks() {
		return remarks;
	}


	public Integer getSort() {
		return sort;
	}


	public Date getStartTime() {
		return startTime;
	}

	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="START_USER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public User getStartUser() {
		return startUser;
	}


	public String getState() {
		return state;
	}


	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="TASK_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public Task getTask() {
		return task;
	}

	public Date getUpdateTime() {
		return updateTime;
	}


	@PrePersist
	public void prePersist() {
		this.id = IdGen.uuid();
	}

	public void setCompanyChargeInfo(CompanyChargeInfo companyChargeInfo) {
		this.companyChargeInfo = companyChargeInfo;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public void setEndUser(User endUser) {
		this.endUser = endUser;
	}

	public void setGoodsCleanCharge(Integer goodsCleanCharge) {
		this.goodsCleanCharge = goodsCleanCharge;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setIsVirtual(String isVirtual) {
		this.isVirtual = isVirtual;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setNextProcess(Process nextProcess) {
		this.nextProcess = nextProcess;
	}


	public void setOtherAdditionalCharge(Integer otherAdditionalCharge) {
		this.otherAdditionalCharge = otherAdditionalCharge;
	}

	public void setPlannedDepartTime(Date plannedDepartTime) {
		this.plannedDepartTime = plannedDepartTime;
	}

	public void setProcessIventory(ProcessIventory processIventory) {
		this.processIventory = processIventory;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public void setStartUser(User startUser) {
		this.startUser = startUser;
	}

	public void setState(String state) {
		this.state = state;
	}


	public void setTask(Task task) {
		this.task = task;
	}


	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}


	public String getAffixFiles() {
		return affixFiles;
	}


	public void setAffixFiles(String affixFiles) {
		this.affixFiles = affixFiles;
	}


	public Date getDeadline() {
		return deadline;
	}


	public void setDeadline(Date deadline) {
		this.deadline = deadline;
	}


	@OneToOne(mappedBy = "process", fetch=FetchType.LAZY)
	@NotFound(action = NotFoundAction.IGNORE)
	@JsonIgnore
	public ChargeDetail getChargeDetail() {
		return chargeDetail;
	}


	public void setChargeDetail(ChargeDetail chargeDetail) {
		this.chargeDetail = chargeDetail;
	}

}
