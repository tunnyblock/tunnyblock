package com.thinkgem.jeesite.modules.sys.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.utils.IdGen;

@Entity
@Table(name = "company_finance_info")
public class CompanyFinanceInfo extends BaseEntity<CompanyFinanceInfo>  implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String id;		// 编号
	
	private Office office;//公司
	
	private String rmbAccount;//人民币账户
	
	private String rmbDepositBank;//人民币开户行
	
	private String usdAccount;//美元账户
	
	private String usdDepositBank;//美元开户行
	
	private String taxNum;//税号
	
	private String organizationCode;//组织机构代码证
	
	private User finaceContacter;
	
	@PrePersist
	public void prePersist(){
		this.id = IdGen.uuid();
	}

	@OneToOne
	@JoinColumn(name="COMPANY_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}

	public String getRmbAccount() {
		return rmbAccount;
	}

	public void setRmbAccount(String rmbAccount) {
		this.rmbAccount = rmbAccount;
	}

	public String getRmbDepositBank() {
		return rmbDepositBank;
	}

	public void setRmbDepositBank(String rmbDepositBank) {
		this.rmbDepositBank = rmbDepositBank;
	}

	public String getUsdAccount() {
		return usdAccount;
	}

	public void setUsdAccount(String usdAccount) {
		this.usdAccount = usdAccount;
	}

	public String getUsdDepositBank() {
		return usdDepositBank;
	}

	public void setUsdDepositBank(String usdDepositBank) {
		this.usdDepositBank = usdDepositBank;
	}

	public String getTaxNum() {
		return taxNum;
	}

	public void setTaxNum(String taxNum) {
		this.taxNum = taxNum;
	}

	public String getOrganizationCode() {
		return organizationCode;
	}

	public void setOrganizationCode(String organizationCode) {
		this.organizationCode = organizationCode;
	}

	@OneToOne
	@JoinColumn(name="FINANCE_CONTACT_USER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public User getFinaceContacter() {
		return finaceContacter;
	}

	public void setFinaceContacter(User finaceContacter) {
		this.finaceContacter = finaceContacter;
	}

	@Id
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	

}
