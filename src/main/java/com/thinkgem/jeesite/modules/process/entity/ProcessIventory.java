package com.thinkgem.jeesite.modules.process.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.OrderBy;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.modules.charge.entity.ChargeInfo;
import com.thinkgem.jeesite.modules.emergency.entity.EmergencyMaintenance;
import com.thinkgem.jeesite.modules.sys.entity.User;


/**
 * 流程清单Entity
 * @author 俞超
 * @version 2014-12-17
 */
@Entity
@Table(name = "process_iventory")
public class ProcessIventory extends BaseEntity<ProcessIventory> implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String id; 		// 编号
	
	private Preorder preorder;//订单编号
	
	private ApproachExamination approachExamination;//进场箱检
	
	private EmergencyMaintenance emergencyMaintenance;//应急维修
	
	private Tank tank;//罐箱
	
	@JsonIgnore
	private Process currentProcess;//当前流程
	
	private String name;//流程清单名称

	private Date createTime;//创建时间

	private Date plannedDepartTime;//预设出场时间
	
	private String isEnded;//是否结束
	
	private String isChargeSubmitted = NO;//账单是否确认
	
	private Date endTime;//结束时间
	
	private String remarks;//备注信息
	
	private User operator;//内部流程创建者
	
	private List<Process> processList = Lists.newArrayList();//流程列表
	
	private ChargeInfo chargeInfo;//收费信息
	
	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="APPROACH_EXAMINE_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public ApproachExamination getApproachExamination() {
		return approachExamination;
	}
	public Date getCreateTime() {
		return createTime;
	}
	
	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="CURRENT_PROCESS_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public Process getCurrentProcess() {
		return currentProcess;
	}

	public Date getEndTime() {
		return endTime;
	}

	@Id
	public String getId() {
		return id;
	}

	public String getIsEnded() {
		return isEnded;
	}

	public String getName() {
		return name;
	}

	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="SYS_USER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public User getOperator() {
		return operator;
	}

	public Date getPlannedDepartTime() {
		return plannedDepartTime;
	}
	
	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="PRO_ORDER_RECORDER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public Preorder getPreorder() {
		return preorder;
	}
	
	@OneToMany(cascade=CascadeType.ALL,fetch=FetchType.LAZY,mappedBy="processIventory")
	@OrderBy("sort")
	public List<Process> getProcessList() {
		return processList;
	}

	public String getRemarks() {
		return remarks;
	}

	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="TANK_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public Tank getTank() {
		return tank;
	}

	@PrePersist
	public void prePersist(){
		this.id = IdGen.uuid();
	}

	public void setApproachExamination(ApproachExamination approachExamination) {
		this.approachExamination = approachExamination;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public void setCurrentProcess(Process currentProcess) {
		this.currentProcess = currentProcess;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setIsEnded(String isEnded) {
		this.isEnded = isEnded;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setOperator(User operator) {
		this.operator = operator;
	}

	public void setPlannedDepartTime(Date plannedDepartTime) {
		this.plannedDepartTime = plannedDepartTime;
	}

	public void setPreorder(Preorder preorder) {
		this.preorder = preorder;
	}

	public void setProcessList(List<Process> processList) {
		this.processList = processList;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public void setTank(Tank tank) {
		this.tank = tank;
	}
	
	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="EMERGENCY_MAINTENANCE_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public EmergencyMaintenance getEmergencyMaintenance() {
		return emergencyMaintenance;
	}
	
	public void setEmergencyMaintenance(EmergencyMaintenance emergencyMaintenance) {
		this.emergencyMaintenance = emergencyMaintenance;
	}
	public String getIsChargeSubmitted() {
		return isChargeSubmitted;
	}
	public void setIsChargeSubmitted(String isChargeSubmitted) {
		this.isChargeSubmitted = isChargeSubmitted;
	}
	
	@OneToOne(mappedBy = "processIventory", fetch=FetchType.LAZY)
	@NotFound(action = NotFoundAction.IGNORE)
	@JsonIgnore
	public ChargeInfo getChargeInfo() {
		return chargeInfo;
	}
	public void setChargeInfo(ChargeInfo chargeInfo) {
		this.chargeInfo = chargeInfo;
	}
	
}


