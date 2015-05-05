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

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.modules.client.entity.Client;
import com.thinkgem.jeesite.modules.sys.entity.User;


/**
 * 罐箱Entity
 * @author 俞超
 * @version 2014-12-08
 */
@Entity
@Table(name = "tank")
public class Tank extends BaseEntity<Tank> implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	
	@JsonIgnore
	private Tank parentTank;//父罐箱，变更前罐箱
	
	private String parentIds;//所有父编号
	
	private Client client;//客户公司
	
	private String tankCode;//箱号
	
	private Integer tankCapacity;//箱子容量

	private Integer tankWeight;//箱子重量

	private String tankType;//箱子类型 0气体、1食品 2化工

	private Date manufacturedTime;//制造时间

	private Date lastAnnualInspectTime;//上次年检时间

	private Date nextAnnualInspectTime;//下次年检时间

	private String annualInspectComments;//年检描述
	
	private Date changeDate;//变更时间
	
	private User changeUser;//变更用户

	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="PARENT_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public Tank getParentTank() {
		return parentTank;
	}

	public void setParentTank(Tank parentTank) {
		this.parentTank = parentTank;
	}

	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}

	public Date getChangeDate() {
		return changeDate;
	}

	public void setChangeDate(Date changeDate) {
		this.changeDate = changeDate;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="CHANGE_USER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public User getChangeUser() {
		return changeUser;
	}

	public void setChangeUser(User changeUser) {
		this.changeUser = changeUser;
	}

	private String remarks;//备注信息

	public String getAnnualInspectComments() {
		return annualInspectComments;
	}

	@ManyToOne
	@JoinColumn(name="client_id")
	@NotFound(action = NotFoundAction.IGNORE)
	public Client getClient() {
		return client;
	}

	@Id
	public String getId() {
		return id;
	}

	public Date getLastAnnualInspectTime() {
		return lastAnnualInspectTime;
	}

	public Date getManufacturedTime() {
		return manufacturedTime;
	}

	public Date getNextAnnualInspectTime() {
		return nextAnnualInspectTime;
	}

	public String getRemarks() {
		return remarks;
	}

	public Integer getTankCapacity() {
		return tankCapacity;
	}

	public String getTankCode() {
		return tankCode;
	}

	public String getTankType() {
		return tankType;
	}

	public Integer getTankWeight() {
		return tankWeight;
	}

	@PrePersist
	public void prePersist(){
		this.id = IdGen.uuid();
	}

	public void setAnnualInspectComments(String annualInspectComments) {
		this.annualInspectComments = annualInspectComments;
	}
	
	public void setClient(Client client) {
		this.client = client;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public void setLastAnnualInspectTime(Date lastAnnualInspectTime) {
		this.lastAnnualInspectTime = lastAnnualInspectTime;
	}
	
	public void setManufacturedTime(Date manufacturedTime) {
		this.manufacturedTime = manufacturedTime;
	}
	
	public void setNextAnnualInspectTime(Date nextAnnualInspectTime) {
		this.nextAnnualInspectTime = nextAnnualInspectTime;
	}
	
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public void setTankCapacity(Integer tankCapacity) {
		this.tankCapacity = tankCapacity;
	}
	
	public void setTankCode(String tankCode) {
		this.tankCode = tankCode;
	}
	
	public void setTankType(String tankType) {
		this.tankType = tankType;
	}
	
	public void setTankWeight(Integer tankWeight) {
		this.tankWeight = tankWeight;
	}
	
}


