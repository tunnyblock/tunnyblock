package com.thinkgem.jeesite.modules.charge.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.OrderBy;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.modules.client.entity.Client;
import com.thinkgem.jeesite.modules.process.entity.Preorder;
import com.thinkgem.jeesite.modules.process.entity.ProcessIventory;
import com.thinkgem.jeesite.modules.process.entity.Tank;
import com.thinkgem.jeesite.modules.sys.entity.User;


/**
 * 费用Entity
 * @author 俞超
 * @version 2014-12-17
 */
@Entity
@Table(name = "charge_info")
public class ChargeInfo extends BaseEntity<ChargeInfo> implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	private Client client;//客户公司
	private Preorder preorder;//预录单
	private ProcessIventory processIventory;//任务清单
	private Tank tank;//罐箱
	private Integer totalRmbPrice;//总人民币金额额
	private Integer totalUsdPrice;//总美元金额
	private Integer totalPrice;//总金额
	private String isSubmitted = ChargeInfo.NO;//是否提交
	private Date submitTime;//提交时间
	private User submitUser;//提交用户
	private List<ChargeDetail> chargeDeatilList = Lists.newArrayList();//费用详情列表

	private String remarks;//备注
	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="CLIENT_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public Client getClient() {
		return client;
	}
	@Id
	public String getId() {
		return id;
	}
	public String getIsSubmitted() {
		return isSubmitted;
	}
	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="PRO_ORDER_RECORDER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public Preorder getPreorder() {
		return preorder;
	}
	
	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="PROCESS_IVENTORY_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public ProcessIventory getProcessIventory() {
		return processIventory;
	}

	public String getRemarks() {
		return remarks;
	}

	public Date getSubmitTime() {
		return submitTime;
	}

	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="SUBMIT_USER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public User getSubmitUser() {
		return submitUser;
	}

	@ManyToOne
	@JoinColumn(name="TANK_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public Tank getTank() {
		return tank;
	}

	public Integer getTotalPrice() {
		return totalPrice;
	}

	public Integer getTotalRmbPrice() {
		return totalRmbPrice;
	}

	public Integer getTotalUsdPrice() {
		return totalUsdPrice;
	}

	@PrePersist
	public void prePersist(){
		this.id = IdGen.uuid();
	}

	public void setClient(Client client) {
		this.client = client;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setIsSubmitted(String isSubmitted) {
		this.isSubmitted = isSubmitted;
	}

	public void setPreorder(Preorder preorder) {
		this.preorder = preorder;
	}

	public void setProcessIventory(ProcessIventory processIventory) {
		this.processIventory = processIventory;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public void setSubmitTime(Date submitTime) {
		this.submitTime = submitTime;
	}
	
	public void setSubmitUser(User submitUser) {
		this.submitUser = submitUser;
	}

	public void setTank(Tank tank) {
		this.tank = tank;
	}

	public void setTotalPrice(Integer totalPrice) {
		this.totalPrice = totalPrice;
	}

	public void setTotalRmbPrice(Integer totalRmbPrice) {
		this.totalRmbPrice = totalRmbPrice;
	}

	public void setTotalUsdPrice(Integer totalUsdPrice) {
		this.totalUsdPrice = totalUsdPrice;
	}
	
	@OneToMany(mappedBy = "chargeInfo", fetch=FetchType.LAZY)
	@OrderBy("id") @Fetch(FetchMode.SUBSELECT)
	@NotFound(action = NotFoundAction.IGNORE)
	@JsonIgnore
	public List<ChargeDetail> getChargeDeatilList() {
		return chargeDeatilList;
	}
	public void setChargeDeatilList(List<ChargeDetail> chargeDeatilList) {
		this.chargeDeatilList = chargeDeatilList;
	}
	
}


