package com.thinkgem.jeesite.modules.process.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
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
 * 罐箱操作日志Entity
 * @author 俞超
 * @version 2014-12-17
 */
@Entity
@Table(name = "tank_operation_log")
public class TankOperationLog extends BaseEntity<TankOperationLog> implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String id; 		// 编号
	
	private ProcessIventory processIventory;//流程清单
	
	private Tank tank;//箱子

	private String operationLog;//操作日志

	private User operator;//操作人

	private Date operationTime;//操作时间

	private String remarks;//备注

	@Id
	public String getId() {
		return id;
	}

	public String getOperationLog() {
		return operationLog;
	}

	public Date getOperationTime() {
		return operationTime;
	}

	@ManyToOne
	@JoinColumn(name="SYS_USER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public User getOperator() {
		return operator;
	}

	@ManyToOne
	@JoinColumn(name="PROCESS_IVENTORY_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public ProcessIventory getProcessIventory() {
		return processIventory;
	}

	public String getRemarks() {
		return remarks;
	}

	@ManyToOne
	@JoinColumn(name="TANK_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public Tank getTank() {
		return tank;
	}

	@PrePersist
	public void prePersist(){
		this.id = IdGen.uuid();
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public void setOperationLog(String operationLog) {
		this.operationLog = operationLog;
	}
	
	public void setOperationTime(Date operationTime) {
		this.operationTime = operationTime;
	}
	
	public void setOperator(User operator) {
		this.operator = operator;
	}
	
	public void setProcessIventory(ProcessIventory processIventory) {
		this.processIventory = processIventory;
	}
	
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public void setTank(Tank tank) {
		this.tank = tank;
	}
	
}


