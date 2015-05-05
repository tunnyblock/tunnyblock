package com.thinkgem.jeesite.modules.sys.entity;

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

import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.utils.IdGen;

/**
 * 用户Entity
 * 
 * @author ThinkGem
 * @version 2013-5-15
 */
@Entity
@Table(name = "sys_wash_info")
public class WashInfo extends BaseEntity<WashInfo>  implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6080201832751833362L;
	
	private String id; 		// 编号
	
	private Office office;//公司
	
	private String goodsChineseName;//货物中文名
	
	private String goodsEnglishName;//货物英文名
	
	private String goodsShortName;//货物英文名
	
	private String type;//危险品类别 0 一般化工品 1危险品
	
	private String dangerousGoodsCode;//危险品编码
	
	private Integer referenceCleanPrice;//参考清洗费用
	
	private Integer additionalCleanPrice;//额外清洗费用
	
	private String delFlag;//删除标记
	
	private String remarks;//备注信息
	
	@SuppressWarnings("unused")
	private String name;
	
	public Integer getAdditionalCleanPrice() {
		return additionalCleanPrice;
	}

	public String getDangerousGoodsCode() {
		return dangerousGoodsCode;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public String getGoodsChineseName() {
		return goodsChineseName;
	}

	public String getGoodsEnglishName() {
		return goodsEnglishName;
	}

	public String getGoodsShortName() {
		return goodsShortName;
	}

	@Id
	public String getId() {
		return id;
	}

	@OneToOne
	@JoinColumn(name="COMPANY_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public Office getOffice() {
		return office;
	}

	public Integer getReferenceCleanPrice() {
		return referenceCleanPrice;
	}

	public String getRemarks() {
		return remarks;
	}

	public String getType() {
		return type;
	}

	@PrePersist
	public void prePersist(){
		this.id = IdGen.uuid();
	}

	public void setAdditionalCleanPrice(Integer additionalCleanPrice) {
		this.additionalCleanPrice = additionalCleanPrice;
	}

	public void setDangerousGoodsCode(String dangerousGoodsCode) {
		this.dangerousGoodsCode = dangerousGoodsCode;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	public void setGoodsChineseName(String goodsChineseName) {
		this.goodsChineseName = goodsChineseName;
	}

	public void setGoodsEnglishName(String goodsEnglishName) {
		this.goodsEnglishName = goodsEnglishName;
	}

	public void setGoodsShortName(String goodsShortName) {
		this.goodsShortName = goodsShortName;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setOffice(Office office) {
		this.office = office;
	}

	public void setReferenceCleanPrice(Integer referenceCleanPrice) {
		this.referenceCleanPrice = referenceCleanPrice;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Transient
	public String getName() {
		return this.goodsEnglishName+"/"+this.goodsChineseName;
	}

	public void setName(String name) {
		this.name = name;
	}

}