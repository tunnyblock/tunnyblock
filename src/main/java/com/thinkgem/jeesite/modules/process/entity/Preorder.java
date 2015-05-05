package com.thinkgem.jeesite.modules.process.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OrderBy;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.modules.client.entity.Client;
import com.thinkgem.jeesite.modules.client.entity.ClientEmployee;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.WashInfo;


/**
 * 预录单Entity
 * @author 俞超
 * @version 2014-12-08
 */
@Entity
@Table(name = "pre_order_record")
public class Preorder extends BaseEntity<Preorder> implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String id; 		// 编号
	
	private String orderCode;//订单编号 按日期 201412081951
	
	///各种对象关联
	private Tank tank;

	private Client client;

	private ClientEmployee clientContacter;
	
	private WashInfo cleanGoods;

	private Date expectedApproachTime;//预计进场时间

	private Date expectedDepartTime;//预计出场时间

	private Date approachTime;//实际进场时间
	
	private String isApproachExamined = Preorder.NO;//是否已进场箱检

	private Date departTime;//实际出场时间

	private Date createTime;//预录单创建时间

	private User createUser; //创建人
	
	private Date updateTime;//更新时间
	
	private User updateUser;//更新人
	
	private String remarks;//备注信息
	
	private String delFlag = Preorder.DEL_FLAG_NORMAL; // 删除标记（0：正常；1：删除；2：审核）
	
	private List<ApproachAim> approachAimList = Lists.newArrayList();//进场目的
	
	
	@Transient
	@JsonIgnore
	public List<String> getApproachAimIdList(){
		List<String> approachAimIdList = Lists.newArrayList();
		for (ApproachAim approachAim : approachAimList) {
			approachAimIdList.add(approachAim.getId());
		}
		return approachAimIdList;
	}
	
	@Transient
	public void setApproachAimIdList(List<String> approachAimIdList) {
		approachAimList = Lists.newArrayList();
		for (String approachAimId : approachAimIdList) {
			ApproachAim approachAim = new ApproachAim();
			approachAim.setId(approachAimId);
			approachAimList.add(approachAim);
		}
	}
	
	public Date getApproachTime() {
		return approachTime;
	}
	
	@ManyToOne
	@JoinColumn(name="CLIENT_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public Client getClient() {
		return client;
	}

	@ManyToOne
	@JoinColumn(name="CLIENT_CONTACTER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public ClientEmployee getClientContacter() {
		return clientContacter;
	}

	public Date getCreateTime() {
		return createTime;
	}

	@ManyToOne
	@JoinColumn(name="create_user_id")
	@NotFound(action = NotFoundAction.IGNORE)
	public User getCreateUser() {
		return createUser;
	}


	public Date getExpectedApproachTime() {
		return expectedApproachTime;
	}


	@Id
	public String getId() {
		return id;
	}

	public String getOrderCode() {
		return orderCode;
	}

	public String getRemarks() {
		return remarks;
	}

	@ManyToOne
	@JoinColumn(name="tank_id")
	@NotFound(action = NotFoundAction.IGNORE)
	public Tank getTank() {
		return tank;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	@ManyToOne
	@JoinColumn(name="update_user_id")
	@NotFound(action = NotFoundAction.IGNORE)
	public User getUpdateUser() {
		return updateUser;
	}

	@PrePersist
	public void prePersist(){
		this.id = IdGen.uuid();
		this.orderCode = DateUtils.formatDate(new Date(), "yyyyMMddHHmmss");
	}

	public void setApproachTime(Date approachTime) {
		this.approachTime = approachTime;
	}

	public void setClient(Client client) {
		this.client = client;
	}

	public void setClientContacter(ClientEmployee clientContacter) {
		this.clientContacter = clientContacter;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public void setCreateUser(User createUser) {
		this.createUser = createUser;
	}

	
	public void setExpectedApproachTime(Date expectedApproachTime) {
		this.expectedApproachTime = expectedApproachTime;
	}
	
	
	public void setId(String id) {
		this.id = id;
	}
	
	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}
	
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	
	
	public void setTank(Tank tank) {
		this.tank = tank;
	}
	
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	
	public void setUpdateUser(User updateUser) {
		this.updateUser = updateUser;
	}

	public Date getDepartTime() {
		return departTime;
	}

	public void setDepartTime(Date departTime) {
		this.departTime = departTime;
	}

	public Date getExpectedDepartTime() {
		return expectedDepartTime;
	}

	public void setExpectedDepartTime(Date expectedDepartTime) {
		this.expectedDepartTime = expectedDepartTime;
	}

	@ManyToOne
	@JoinColumn(name="CLEAN_GOODS_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public WashInfo getCleanGoods() {
		return cleanGoods;
	}

	public void setCleanGoods(WashInfo cleanGoods) {
		this.cleanGoods = cleanGoods;
	}

	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(name = "PRE_ORDER_AIM", joinColumns = { @JoinColumn(name = "PRE_ORDER_RECORD_ID") }, inverseJoinColumns = { @JoinColumn(name = "APPROACH_AIM_ID") })
	@OrderBy("id") @Fetch(FetchMode.SUBSELECT)
	@NotFound(action = NotFoundAction.IGNORE)
	public List<ApproachAim> getApproachAimList() {
		return approachAimList;
	}

	public void setApproachAimList(List<ApproachAim> approachAimList) {
		this.approachAimList = approachAimList;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	public String getIsApproachExamined() {
		return isApproachExamined;
	}

	public void setIsApproachExamined(String isApproachExamined) {
		this.isApproachExamined = isApproachExamined;
	}
	
}


