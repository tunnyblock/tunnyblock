package com.thinkgem.jeesite.modules.client.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.utils.IdGen;

/**
 * 客户管理Entity
 * @author 俞超
 * @version 2014-11-25
 */
@Entity
@Table(name = "client_base_info")
public class Client extends BaseEntity<Client>  implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	@PrePersist
	public void prePersist(){
		this.id = IdGen.uuid();
	}
	
	private String id; 		// 编号
	
	private String companyChineseName;//公司中文名
	
	private String companyEnglishName;//公司英文名
	
	private String companyShortName;//公司名缩写
	
	private String telephone;//公司电话
	
	private String fax;//公司传真
	
	private String address;//公司地址
	
	private String email;//公司邮箱
	
	private String website;//公司网址
	
	private String logoUrl;//公司Logo
	
	private String delFlag; // 删除标记（0：正常；1：删除）
	
	//TODO：公司联系人
	 private ClientEmployee contacter;
	 
	 @SuppressWarnings("unused")
	private String name;//自动填充使用字段

	@Id
	public String getId() {
		return id;
	}

	public String getCompanyChineseName() {
		return companyChineseName;
	}

	public void setCompanyChineseName(String companyChineseName) {
		this.companyChineseName = companyChineseName;
	}

	public String getCompanyEnglishName() {
		return companyEnglishName;
	}

	public void setCompanyEnglishName(String companyEnglishName) {
		this.companyEnglishName = companyEnglishName;
	}

	public String getCompanyShortName() {
		return companyShortName;
	}

	public void setCompanyShortName(String companyShortName) {
		this.companyShortName = companyShortName;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public String getLogoUrl() {
		return logoUrl;
	}

	public void setLogoUrl(String logoUrl) {
		this.logoUrl = logoUrl;
	}

	public void setId(String id) {
		this.id = id;
	}

	@OneToOne
	@JoinColumn(name="contact_person_id")
	@NotFound(action = NotFoundAction.IGNORE)
	@JsonIgnore
	public ClientEmployee getContacter() {
		return contacter;
	}

	public void setContacter(ClientEmployee contacter) {
		this.contacter = contacter;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	@Transient
	public String getName() {
		return this.companyChineseName+"-"+this.companyEnglishName;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}


