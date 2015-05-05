package com.thinkgem.jeesite.modules.process.entity;

import java.io.Serializable;
import java.util.Date;

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
import com.thinkgem.jeesite.modules.sys.entity.User;


/**
 * 进场箱检Entity
 * @author 俞超
 * @version 2014-12-17
 */
@Entity
@Table(name = "approach_examination")
public class ApproachExamination extends BaseEntity<ApproachExamination> implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String id; 		// 编号
	
	private Preorder preorder;//进场预录单

	private Tank tank; //罐箱

	private String airValveType;//空气阀类型

	private String topValveType;//顶阀类型

	private String haveSafetyValve;//是否有安全阀

	private String haveElectricHeat;//是否有电加热

	private String havePressureGauge;//是否有压力表

	private String haveThermomter;//是否有温度表

	private String accessoriesComments;//配件信息备注

	private String tankLeftPicture;//箱子左边照片

	private String tankRightPicture;//箱子右边照片

	private String tankTopPicture;//箱子顶部照片

	private String tankBottomPicture;//箱子底部照片
	
	private String tankFrontPicture;//箱子前部照片
	
	private String tankBackPicture;//箱子后部照片
	
	private String tankEntryHolePicture;//入孔阀照片
	
	private String tankAirValvePicture;//空气阀舱照片
	
	private String tankBottomValvePicture;//底阀照片
	
	private String deliveryPicture;//设备交接单照片
	
	private String damagePicturePackage;//进场时损坏照片组
	
	private String pictureComments;//箱子照片备注
	
	private Date createdTime;//创建时间
	
	private User createUser;//创建员工
	
	private String examineResult;//箱检结果
	
	private String isDamaged;//是否有损坏0未损1损坏
	
	private String haveNotifiedClient;//是否已通知客户 0未通知 1已通知
	
	private Date notifiedClientTime;//通知客户时间
	
	private String clientComments;//客户反馈意见
	
	private String isProcessSetted = ApproachExamination.NO;//流程是否设定
	
	private Date processSettedTime;//流程设定时间
	
	public String getIsProcessSetted() {
		return isProcessSetted;
	}
	public void setIsProcessSetted(String isProcessSetted) {
		this.isProcessSetted = isProcessSetted;
	}
	public Date getProcessSettedTime() {
		return processSettedTime;
	}
	public void setProcessSettedTime(Date processSettedTime) {
		this.processSettedTime = processSettedTime;
	}

	private String remarks;//备注信息
	
	public String getAccessoriesComments() {
		return accessoriesComments;
	}
	public String getAirValveType() {
		return airValveType;
	}
	public String getClientComments() {
		return clientComments;
	}
	public Date getCreatedTime() {
		return createdTime;
	}
	@OneToOne
	@JoinColumn(name="SYS_USER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public User getCreateUser() {
		return createUser;
	}
	public String getDamagePicturePackage() {
		return damagePicturePackage;
	}
	public String getDeliveryPicture() {
		return deliveryPicture;
	}
	public String getExamineResult() {
		return examineResult;
	}
	public String getHaveElectricHeat() {
		return haveElectricHeat;
	}
	public String getHaveNotifiedClient() {
		return haveNotifiedClient;
	}
	public String getHavePressureGauge() {
		return havePressureGauge;
	}
	public String getHaveSafetyValve() {
		return haveSafetyValve;
	}
	
	
	public String getHaveThermomter() {
		return haveThermomter;
	}

	@Id
	public String getId() {
		return id;
	}

	public String getIsDamaged() {
		return isDamaged;
	}

	public Date getNotifiedClientTime() {
		return notifiedClientTime;
	}

	public String getPictureComments() {
		return pictureComments;
	}

	@OneToOne
	@JoinColumn(name="PRO_ORDER_RECORDER_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public Preorder getPreorder() {
		return preorder;
	}

	public String getRemarks() {
		return remarks;
	}

	@OneToOne
	@JoinColumn(name="TANK_ID")
	@NotFound(action = NotFoundAction.IGNORE)
	public Tank getTank() {
		return tank;
	}

	public String getTankAirValvePicture() {
		return tankAirValvePicture;
	}

	public String getTankBackPicture() {
		return tankBackPicture;
	}

	public String getTankBottomPicture() {
		return tankBottomPicture;
	}

	public String getTankBottomValvePicture() {
		return tankBottomValvePicture;
	}

	public String getTankEntryHolePicture() {
		return tankEntryHolePicture;
	}

	public String getTankFrontPicture() {
		return tankFrontPicture;
	}

	public String getTankLeftPicture() {
		return tankLeftPicture;
	}

	public String getTankRightPicture() {
		return tankRightPicture;
	}

	public String getTankTopPicture() {
		return tankTopPicture;
	}

	public String getTopValveType() {
		return topValveType;
	}

	@PrePersist
	public void prePersist(){
		this.id = IdGen.uuid();
	}

	public void setAccessoriesComments(String accessoriesComments) {
		this.accessoriesComments = accessoriesComments;
	}

	public void setAirValveType(String airValveType) {
		this.airValveType = airValveType;
	}

	public void setClientComments(String clientComments) {
		this.clientComments = clientComments;
	}

	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}

	public void setCreateUser(User createUser) {
		this.createUser = createUser;
	}

	public void setDamagePicturePackage(String damagePicturePackage) {
		this.damagePicturePackage = damagePicturePackage;
	}

	public void setDeliveryPicture(String deliveryPicture) {
		this.deliveryPicture = deliveryPicture;
	}

	public void setExamineResult(String examineResult) {
		this.examineResult = examineResult;
	}

	public void setHaveElectricHeat(String haveElectricHeat) {
		this.haveElectricHeat = haveElectricHeat;
	}

	public void setHaveNotifiedClient(String haveNotifiedClient) {
		this.haveNotifiedClient = haveNotifiedClient;
	}

	public void setHavePressureGauge(String havePressureGauge) {
		this.havePressureGauge = havePressureGauge;
	}

	public void setHaveSafetyValve(String haveSafetyValve) {
		this.haveSafetyValve = haveSafetyValve;
	}

	public void setHaveThermomter(String haveThermomter) {
		this.haveThermomter = haveThermomter;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setIsDamaged(String isDamaged) {
		this.isDamaged = isDamaged;
	}

	public void setNotifiedClientTime(Date notifiedClientTime) {
		this.notifiedClientTime = notifiedClientTime;
	}

	public void setPictureComments(String pictureComments) {
		this.pictureComments = pictureComments;
	}

	public void setPreorder(Preorder preorder) {
		this.preorder = preorder;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public void setTank(Tank tank) {
		this.tank = tank;
	}

	public void setTankAirValvePicture(String tankAirValvePicture) {
		this.tankAirValvePicture = tankAirValvePicture;
	}


	public void setTankBackPicture(String tankBackPicture) {
		this.tankBackPicture = tankBackPicture;
	}

	public void setTankBottomPicture(String tankBottomPicture) {
		this.tankBottomPicture = tankBottomPicture;
	}

	public void setTankBottomValvePicture(String tankBottomValvePicture) {
		this.tankBottomValvePicture = tankBottomValvePicture;
	}

	public void setTankEntryHolePicture(String tankEntryHolePicture) {
		this.tankEntryHolePicture = tankEntryHolePicture;
	}

	public void setTankFrontPicture(String tankFrontPicture) {
		this.tankFrontPicture = tankFrontPicture;
	}

	public void setTankLeftPicture(String tankLeftPicture) {
		this.tankLeftPicture = tankLeftPicture;
	}

	public void setTankRightPicture(String tankRightPicture) {
		this.tankRightPicture = tankRightPicture;
	}
	
	public void setTankTopPicture(String tankTopPicture) {
		this.tankTopPicture = tankTopPicture;
	}
	
	public void setTopValveType(String topValveType) {
		this.topValveType = topValveType;
	}

}


