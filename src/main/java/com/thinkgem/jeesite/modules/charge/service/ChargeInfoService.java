package com.thinkgem.jeesite.modules.charge.service;

import java.util.Date;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.modules.charge.entity.ChargeDetail;
import com.thinkgem.jeesite.modules.charge.entity.ChargeInfo;
import com.thinkgem.jeesite.modules.charge.dao.ChargeDetailDao;
import com.thinkgem.jeesite.modules.charge.dao.ChargeInfoDao;
import com.thinkgem.jeesite.modules.emergency.entity.EmergencyMaintenance;
import com.thinkgem.jeesite.modules.process.dao.ProcessIventoryDao;
import com.thinkgem.jeesite.modules.process.entity.Preorder;
import com.thinkgem.jeesite.modules.process.entity.ProcessIventory;
import com.thinkgem.jeesite.modules.process.entity.Tank;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 费用Service
 * @author 俞超
 * @version 2014-12-17
 */
@Service
@Transactional(readOnly=true)
public class ChargeInfoService extends BaseService {

	@Autowired
	private ChargeInfoDao chargeInfoDao;
	
	@Autowired
	private ChargeDetailDao chargeDetailDao;
	
	@Autowired
	private ProcessIventoryDao processIventoryDao;
	
	public ChargeInfo get(String id) {
		return chargeInfoDao.get(id);
	}
	
	public Page<ChargeInfo> find(Page<ChargeInfo> page, ChargeInfo chargeInfo) {
		DetachedCriteria dc = chargeInfoDao.createDetachedCriteria();
		dc.addOrder(Order.desc("id"));
		return chargeInfoDao.find(page, dc);
	}
	
	@Transactional(readOnly=false)
	public void save(ChargeInfo chargeInfo) {
		chargeInfoDao.save(chargeInfo);
	}
	
	@Transactional(readOnly=false)
	public void delete(String id) {
		chargeInfoDao.deleteById(id);
	}
	
	/**
	 * 保存费用详情及明细
	 * @param chargeInfo
	 */
	@Transactional(readOnly=false)
	public void saveChargeInfo(ChargeInfo chargeInfo){
		ProcessIventory processIventory = processIventoryDao.get(chargeInfo.getProcessIventory().getId());
		Tank tank = processIventory.getTank();
		Preorder preorder = processIventory.getPreorder();
		EmergencyMaintenance emergencyMaintenance = processIventory.getEmergencyMaintenance();
		if(preorder!=null){
			chargeInfo.setClient(preorder.getClient());
			chargeInfo.setPreorder(preorder);
		}
		
		if(emergencyMaintenance!=null){
			chargeInfo.setClient(emergencyMaintenance.getClient());
		}
		chargeInfo.setTank(tank);
		chargeInfoDao.save(chargeInfo);
		
		int totalRMBPrice=0;
		int totalUSDPrice=0;
		int totalPrice = 0;
		
		if(chargeInfo.getChargeDeatilList()!=null){
			for(ChargeDetail chargeDetail:chargeInfo.getChargeDeatilList()){
				chargeDetail.setChargeInfo(chargeInfo);
				chargeDetail.setRecordUser(UserUtils.getUser());
				chargeDetail.setRecordTime(new Date());
				chargeDetailDao.save(chargeDetail);
				if("0".equals(chargeDetail.getCurrencyType())){
					totalRMBPrice = totalRMBPrice + chargeDetail.getChargePrice();
					totalPrice = totalPrice+chargeDetail.getChargePrice();
				}
				
				if("1".equals(chargeDetail.getCurrencyType())){
					totalUSDPrice = totalUSDPrice+chargeDetail.getChargePrice();
					totalPrice = totalPrice+Integer.parseInt(Global.getDefaultExchangeRate()* chargeDetail.getChargePrice()+"");
				}
			}
		}
		
		chargeInfo.setTotalRmbPrice(totalRMBPrice);
		chargeInfo.setTotalUsdPrice(totalUSDPrice);
		chargeInfo.setTotalPrice(totalPrice);
		chargeInfoDao.save(chargeInfo);
	}
	
}
