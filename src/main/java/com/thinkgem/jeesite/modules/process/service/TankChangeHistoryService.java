package com.thinkgem.jeesite.modules.process.service;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.modules.process.entity.TankChangeHistory;
import com.thinkgem.jeesite.modules.process.dao.TankChangeHistoryDao;

/**
 * 箱子变更历史Service
 * @author 俞超
 * @version 2015-01-24
 */
@Service
@Transactional(readOnly=true)
public class TankChangeHistoryService extends BaseService {

	@Autowired
	private TankChangeHistoryDao tankChangeHistoryDao;
	
	public TankChangeHistory get(String id) {
		return tankChangeHistoryDao.get(id);
	}
	
	public Page<TankChangeHistory> find(Page<TankChangeHistory> page, TankChangeHistory tankChangeHistory) {
		DetachedCriteria dc = tankChangeHistoryDao.createDetachedCriteria();
		dc.addOrder(Order.desc("id"));
		return tankChangeHistoryDao.find(page, dc);
	}
	
	@Transactional(readOnly=false)
	public void save(TankChangeHistory tankChangeHistory) {
		tankChangeHistoryDao.save(tankChangeHistory);
	}
	
	@Transactional(readOnly=false)
	public void delete(String id) {
		tankChangeHistoryDao.deleteById(id);
	}
	
}
