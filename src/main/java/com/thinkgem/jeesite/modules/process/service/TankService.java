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
import com.thinkgem.jeesite.modules.process.dao.TankDao;
import com.thinkgem.jeesite.modules.process.entity.Tank;

/**
 * 罐箱Service
 * @author 俞超
 * @version 2014-12-08
 */
@Service
@Transactional(readOnly=true)
public class TankService extends BaseService {

	@Autowired
	private TankDao tankDao;
	
	public Tank get(String id) {
		return tankDao.get(id);
	}
	
	public Page<Tank> find(Page<Tank> page, Tank tank) {
		DetachedCriteria dc = tankDao.createDetachedCriteria();
		dc.addOrder(Order.desc("id"));
		return tankDao.find(page, dc);
	}
	
	@Transactional(readOnly=false)
	public void save(Tank tank) {
		tankDao.save(tank);
	}
	
	@Transactional(readOnly=false)
	public void delete(String id) {
		tankDao.deleteById(id);
	}
	
	public Tank findTankByCode(String tankCode){
		DetachedCriteria dc = tankDao.createDetachedCriteria();
		dc.add(Restrictions.eq("tankCode", tankCode));
		List<Tank> tankList = tankDao.find(dc);
		return (tankList==null||tankList.size()==0)?null:tankList.get(0);
	}
	
	/**
	 * 强制同步数据库
	 */
	public void flush(){
		tankDao.flush();
	}
	
}
