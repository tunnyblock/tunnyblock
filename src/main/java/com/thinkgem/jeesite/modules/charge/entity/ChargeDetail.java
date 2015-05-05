package com.thinkgem.jeesite.modules.charge.entity;

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

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.modules.process.entity.Process;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 费用明细Entity
 * @author 俞超
 * @version 2014-12-17
 */
@Entity
@Table(name = "charge_detail")
public class ChargeDetail extends BaseEntity<ChargeDetail> implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	private ChargeInfo chargeInfo;//费用清单
	private Process process;//流程名称
	private String chargeName;//费用明细名称
	private Integer chargePrice;//费用值
	private String currencyType;//币种 0 RMB 1 USD
	private User recordUser;//记录用户
	private Date recordTime;//记录时间
	private User updateUser;//更新用户
	private Date updateTime;//更新时间
	private String remarks;//备注

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="CHARGE_INFO_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public ChargeInfo getChargeInfo() {
		return chargeInfo;
	}

	public String getChargeName() {
		return chargeName;
	}

	public Integer getChargePrice() {
		return chargePrice;
	}

	@Id
	public String getId() {
		return id;
	}

	public Date getRecordTime() {
		return recordTime;
	}

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="RECORD_USER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public User getRecordUser() {
		return recordUser;
	}

	public String getRemarks() {
		return remarks;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="UPDATE_USER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public User getUpdateUser() {
		return updateUser;
	}

	@PrePersist
	public void prePersist(){
		this.id = IdGen.uuid();
	}

	public void setChargeInfo(ChargeInfo chargeInfo) {
		this.chargeInfo = chargeInfo;
	}
	public void setChargeName(String chargeName) {
		this.chargeName = chargeName;
	}
	public void setChargePrice(Integer chargePrice) {
		this.chargePrice = chargePrice;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setRecordTime(Date recordTime) {
		this.recordTime = recordTime;
	}
	public void setRecordUser(User recordUser) {
		this.recordUser = recordUser;
	}
	
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	
	public void setUpdateUser(User updateUser) {
		this.updateUser = updateUser;
	}

	public String getCurrencyType() {
		return currencyType;
	}

	public void setCurrencyType(String currencyType) {
		this.currencyType = currencyType;
	}

	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="PROCESS_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public Process getProcess() {
		return process;
	}

	public void setProcess(Process process) {
		this.process = process;
	}
	
}


