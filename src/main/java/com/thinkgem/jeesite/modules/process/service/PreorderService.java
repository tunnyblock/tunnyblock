/**
 * There are <a href="https://github.com/thinkgem/jeesite">JeeSite</a> code generation
 */
package com.thinkgem.jeesite.modules.process.service;

import java.util.Date;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.persistence.Parameter;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.modules.process.dao.PreorderDao;
import com.thinkgem.jeesite.modules.process.entity.Preorder;

/**
 * 预录单Service
 * @author 俞超
 * @version 2014-12-08
 */
@Service
@Transactional(readOnly=true)
public class PreorderService extends BaseService {

	@Autowired
	private PreorderDao preorderDao;
	
	public Preorder get(String id) {
		return preorderDao.get(id);
	}
	
	public Page<Preorder> find(Page<Preorder> page, Preorder preorder) {
		DetachedCriteria dc = preorderDao.createDetachedCriteria();
		dc.add(Restrictions.eqOrIsNull("delFlag", Preorder.DEL_FLAG_NORMAL));
		dc.addOrder(Order.desc("id"));
		return preorderDao.find(page, dc);
	}
	
	public Page<Preorder> findUnApproachOrders(Page<Preorder> page, Preorder preorder){
		DetachedCriteria dc = preorderDao.createDetachedCriteria();
		dc.add(Restrictions.eqOrIsNull("delFlag", Preorder.DEL_FLAG_NORMAL));
		dc.add(Restrictions.isNull("approachTime"));
		dc.addOrder(Order.desc("id"));
		return preorderDao.find(page, dc);
	}
	
	@Transactional(readOnly=false)
	public void save(Preorder preorder) {
		preorderDao.save(preorder);
	}
	
	@Transactional(readOnly=false)
	public void delete(String id) {
		preorderDao.deleteById(id);
	}
	
	@Transactional(readOnly=false)
	public void updateAppraochTime(Preorder preorder){
		preorderDao.update("update "+Preorder.class.getSimpleName()+" set approachTime = :p1 where id = :p2",new Parameter(new Date(), preorder.getId()));
	}
}
