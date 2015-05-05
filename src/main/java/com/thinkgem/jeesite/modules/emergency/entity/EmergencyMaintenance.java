package com.thinkgem.jeesite.modules.emergency.entity;

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
import com.thinkgem.jeesite.modules.client.entity.Client;
import com.thinkgem.jeesite.modules.client.entity.ClientEmployee;
import com.thinkgem.jeesite.modules.process.entity.Tank;
import com.thinkgem.jeesite.modules.sys.entity.User;


/**
 * 应急维修Entity
 * @author 俞超
 * @version 2015-02-07
 */
@Entity
@Table(name = "emergency_maintenance")
public class EmergencyMaintenance extends BaseEntity<EmergencyMaintenance> implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String id; 		// 编号
	
	private Tank tank;//箱子

	private Client client;//客户
	
	private ClientEmployee clientContacter;//客户联系人
	
	private String tankCode;//箱号
	
	private User generateUser;//产生用户
	
	private User assignToUser;//出勤用户
	
	private Date generateTime;//产生日期
	
	private String delFlag = EmergencyMaintenance.DEL_FLAG_NORMAL ;//删除标记
	
	private String remarks;//备注
	
	@ManyToOne
	@JoinColumn(name="CLIENT_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public Client getClient() {
		return client;
	}

	public String getDelFlag() {
		return delFlag;
	}

	@ManyToOne
	@JoinColumn(name="GENERATE_USER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public User getGenerateUser() {
		return generateUser;
	}

	@Id
	public String getId() {
		return id;
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

	public String getTankCode() {
		return tankCode;
	}

	@PrePersist
	public void prePersist(){
		this.id = IdGen.uuid();
	}

	public void setClient(Client client) {
		this.client = client;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	public void setGenerateUser(User generateUser) {
		this.generateUser = generateUser;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public void setTank(Tank tank) {
		this.tank = tank;
	}
	
	public void setTankCode(String tankCode) {
		this.tankCode = tankCode;
	}

	@ManyToOne
	@JoinColumn(name="ASSIGN_TO")
	@NotFound(action = NotFoundAction.IGNORE)
	public User getAssignToUser() {
		return assignToUser;
	}

	public void setAssignToUser(User assignToUser) {
		this.assignToUser = assignToUser;
	}

	public Date getGenerateTime() {
		return generateTime;
	}

	public void setGenerateTime(Date generateTime) {
		this.generateTime = generateTime;
	}

	@ManyToOne
	@JoinColumn(name="CLIENT_CONTACTER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public ClientEmployee getClientContacter() {
		return clientContacter;
	}

	public void setClientContacter(ClientEmployee clientContacter) {
		this.clientContacter = clientContacter;
	}
	
}


