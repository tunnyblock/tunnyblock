package com.thinkgem.jeesite.modules.client.entity;

import java.io.Serializable;

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

/**
 * 客户员工管理Entity
 * @author 俞超
 * @version 2014-11-26
 */
@Entity
@Table(name = "client_employee")
public class ClientEmployee extends BaseEntity<ClientEmployee> implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	
	private Client client;//客户公司
	
	private String chineseName;//中文名
	
	private String englishName;//英文名
	
	private String position;//岗位
	
	private String email;//邮箱
	
	private String telephone;//电话
	
	private String fax;//传真
	
	private String mobilephone;//手机
	
	private String qqNum;//QQ号

	private String photoUrl;//头像图片地址

	private String description;//备注
	
	private String delFlag; // 删除标记（0：正常；1：删除）

	public String getChineseName() {
		return chineseName;
	}

	@ManyToOne
	@JoinColumn(name="client_id")
	@NotFound(action = NotFoundAction.IGNORE)
	public Client getClient() {
		return client;
	}

	public String getDescription() {
		return description;
	}

	public String getEmail() {
		return email;
	}

	public String getEnglishName() {
		return englishName;
	}

	public String getFax() {
		return fax;
	}

	@Id
	public String getId() {
		return id;
	}

	public String getMobilephone() {
		return mobilephone;
	}

	public String getPhotoUrl() {
		return photoUrl;
	}

	public String getPosition() {
		return position;
	}

	public String getQqNum() {
		return qqNum;
	}

	public String getTelephone() {
		return telephone;
	}

	@PrePersist
	public void prePersist(){
		this.id = IdGen.uuid();
	}

	public void setChineseName(String chineseName) {
		this.chineseName = chineseName;
	}

	public void setClient(Client client) {
		this.client = client;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setEnglishName(String englishName) {
		this.englishName = englishName;
	}
	
	public void setFax(String fax) {
		this.fax = fax;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public void setMobilephone(String mobilephone) {
		this.mobilephone = mobilephone;
	}
	
	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}
	
	public void setPosition(String position) {
		this.position = position;
	}

	public void setQqNum(String qqNum) {
		this.qqNum = qqNum;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}
	
}


