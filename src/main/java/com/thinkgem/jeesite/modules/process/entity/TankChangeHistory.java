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

import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.modules.sys.entity.User;


/**
 * 箱子变更历史Entity
 * @author 俞超
 * @version 2015-01-24
 */
@Entity
@Table(name = "tank_change_history")
public class TankChangeHistory extends BaseEntity<TankChangeHistory> implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	
	private Tank oldTank;//原来的箱子
	
	private Tank newTank;//更新后的箱子
	
	private User updateUser;//更新用户

	private Date updateTime;//更新时间

	private String remarks;//备注

	@Id
	public String getId() {
		return id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="NEW_TANK_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public Tank getNewTank() {
		return newTank;
	}

	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="OLD_TANK_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public Tank getOldTank() {
		return oldTank;
	}

	public String getRemarks() {
		return remarks;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="UPDATE_USER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public User getUpdateUser() {
		return updateUser;
	}

	@PrePersist
	public void prePersist(){
		this.id = IdGen.uuid();
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public void setNewTank(Tank newTank) {
		this.newTank = newTank;
	}
	
	public void setOldTank(Tank oldTank) {
		this.oldTank = oldTank;
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
	
}


