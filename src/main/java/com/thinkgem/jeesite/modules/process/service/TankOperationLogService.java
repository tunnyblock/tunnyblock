package com.thinkgem.jeesite.modules.process.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.modules.process.dao.TankOperationLogDao;
import com.thinkgem.jeesite.modules.process.entity.TankOperationLog;

/**
 * 罐箱操作日志Service
 * @author 俞超
 * @version 2014-12-17
 */
@Service
@Transactional(readOnly=true)
public class TankOperationLogService extends BaseService {

	@Autowired
	private TankOperationLogDao tankOperationLogDao;
	
	public TankOperationLog get(String id) {
		return tankOperationLogDao.get(id);
	}
	
	public Page<TankOperationLog> find(Page<TankOperationLog> page, TankOperationLog tankOperationLog) {
		DetachedCriteria dc = tankOperationLogDao.createDetachedCriteria();
		dc.addOrder(Order.desc("id"));
		return tankOperationLogDao.find(page, dc);
	}
	
	@Transactional(readOnly=false)
	public void save(TankOperationLog tankOperationLog) {
		tankOperationLogDao.save(tankOperationLog);
	}
	
	@Transactional(readOnly=false)
	public void delete(String id) {
		tankOperationLogDao.deleteById(id);
	}
	
	public List<TankOperationLog> findTankOperationLogByProcessIventoryId(String processIventoryId){
		DetachedCriteria dc = tankOperationLogDao.createDetachedCriteria();
		dc.createAlias("processIventory", "processIventory");
		dc.add(Restrictions.eq("processIventory.id", processIventoryId));
		dc.addOrder(Order.asc("operationTime"));
		return tankOperationLogDao.find(dc);
	}
	
}
