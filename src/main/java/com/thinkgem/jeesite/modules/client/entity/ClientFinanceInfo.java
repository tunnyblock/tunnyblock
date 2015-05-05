package com.thinkgem.jeesite.modules.client.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.utils.IdGen;


/**
 * 客户财务信息Entity
 * @author 俞超
 * @version 2014-12-08
 */
@Entity
@Table(name = "client_finance_info")
public class ClientFinanceInfo extends BaseEntity<ClientFinanceInfo> implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String id; 		// 编号
	
	private Client client;//客户公司

	private String domesticInvoiceTitle;//国内发票抬头

	private String domesticTaxNum;//国内税务编号

	private String domesticAddress;//国内快递地址

	private ClientEmployee domesticClientEmployee;//国内收件人编号

	private String domesticOrganiztionCode;//组织机构代码证

	private String domesticBussinessLicence;//营业执照

	private String domesticTaxRegisterLicence;//税务登记证

	private String overseaInvoiceTitle;//海外发票抬头

	private String proformaInvoiceTitle;//形式发票抬头

	private String proformaInvoiceAddress;//形式发票快递地址

	private ClientEmployee proformaClientEmployee;//形式发票收件人

	private String delFlag; // 删除标记（0：正常；1：删除）

	private String remarks;

	@ManyToOne
	@JoinColumn(name="client_id")
	@NotFound(action = NotFoundAction.IGNORE)
	public Client getClient() {
		return client;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public String getDomesticAddress() {
		return domesticAddress;
	}

	public String getDomesticBussinessLicence() {
		return domesticBussinessLicence;
	}

	@OneToOne
	@JoinColumn(name="domestic_receipt_id")
	@NotFound(action = NotFoundAction.IGNORE)
	public ClientEmployee getDomesticClientEmployee() {
		return domesticClientEmployee;
	}

	public String getDomesticInvoiceTitle() {
		return domesticInvoiceTitle;
	}

	public String getDomesticOrganiztionCode() {
		return domesticOrganiztionCode;
	}

	public String getDomesticTaxNum() {
		return domesticTaxNum;
	}

	public String getDomesticTaxRegisterLicence() {
		return domesticTaxRegisterLicence;
	}

	@Id
	public String getId() {
		return id;
	}

	public String getOverseaInvoiceTitle() {
		return overseaInvoiceTitle;
	}

	@OneToOne
	@JoinColumn(name="proforma_invoice_receipt_id")
	@NotFound(action = NotFoundAction.IGNORE)
	public ClientEmployee getProformaClientEmployee() {
		return proformaClientEmployee;
	}

	public String getProformaInvoiceAddress() {
		return proformaInvoiceAddress;
	}

	public String getProformaInvoiceTitle() {
		return proformaInvoiceTitle;
	}

	public String getRemarks() {
		return remarks;
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
	
	public void setDomesticAddress(String domesticAddress) {
		this.domesticAddress = domesticAddress;
	}
	
	public void setDomesticBussinessLicence(String domesticBussinessLicence) {
		this.domesticBussinessLicence = domesticBussinessLicence;
	}
	
	public void setDomesticClientEmployee(ClientEmployee domesticClientEmployee) {
		this.domesticClientEmployee = domesticClientEmployee;
	}
	
	public void setDomesticInvoiceTitle(String domesticInvoiceTitle) {
		this.domesticInvoiceTitle = domesticInvoiceTitle;
	}
	
	public void setDomesticOrganiztionCode(String domesticOrganiztionCode) {
		this.domesticOrganiztionCode = domesticOrganiztionCode;
	}
	
	public void setDomesticTaxNum(String domesticTaxNum) {
		this.domesticTaxNum = domesticTaxNum;
	}
	
	public void setDomesticTaxRegisterLicence(String domesticTaxRegisterLicence) {
		this.domesticTaxRegisterLicence = domesticTaxRegisterLicence;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public void setOverseaInvoiceTitle(String overseaInvoiceTitle) {
		this.overseaInvoiceTitle = overseaInvoiceTitle;
	}
	
	public void setProformaClientEmployee(ClientEmployee proformaClientEmployee) {
		this.proformaClientEmployee = proformaClientEmployee;
	}
	
	
	public void setProformaInvoiceAddress(String proformaInvoiceAddress) {
		this.proformaInvoiceAddress = proformaInvoiceAddress;
	}
	
	public void setProformaInvoiceTitle(String proformaInvoiceTitle) {
		this.proformaInvoiceTitle = proformaInvoiceTitle;
	}
	
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
}


