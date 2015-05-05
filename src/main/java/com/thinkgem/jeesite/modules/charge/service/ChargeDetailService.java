package com.thinkgem.jeesite.modules.charge.service;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.modules.charge.entity.ChargeDetail;
import com.thinkgem.jeesite.modules.charge.dao.ChargeDetailDao;

/**
 * 费用明细Service
 * @author 俞超
 * @version 2014-12-17
 */
@Service
@Transactional(readOnly=true)
public class ChargeDetailService extends BaseService {

	@Autowired
	private ChargeDetailDao chargeDetailDao;
	
	public ChargeDetail get(String id) {
		return chargeDetailDao.get(id);
	}
	
	public Page<ChargeDetail> find(Page<ChargeDetail> page, ChargeDetail chargeDetail) {
		DetachedCriteria dc = chargeDetailDao.createDetachedCriteria();
		dc.addOrder(Order.desc("id"));
		return chargeDetailDao.find(page, dc);
	}
	
	@Transactional(readOnly=false)
	public void save(ChargeDetail chargeDetail) {
		chargeDetailDao.save(chargeDetail);
	}
	
	@Transactional(readOnly=false)
	public void delete(String id) {
		chargeDetailDao.deleteById(id);
	}
	
}
