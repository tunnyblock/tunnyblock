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
import com.thinkgem.jeesite.modules.process.dao.ApproachAimDao;
import com.thinkgem.jeesite.modules.process.entity.ApproachAim;

/**
 * 进场目的Service
 * @author 俞超
 * @version 2014-12-11
 */
@Service
@Transactional(readOnly=true)
public class ApproachAimService extends BaseService {

	@Autowired
	private ApproachAimDao approachAimDao;
	
	public ApproachAim get(String id) {
		return approachAimDao.get(id);
	}
	
	public Page<ApproachAim> find(Page<ApproachAim> page, ApproachAim approachAim) {
		DetachedCriteria dc = approachAimDao.createDetachedCriteria();
		dc.addOrder(Order.desc("id"));
		return approachAimDao.find(page, dc);
	}
	
	public List<ApproachAim> listAll(){
		return approachAimDao.findAll();
	}
	
	/**
	 * 只显示暂存和清洗
	 * @return
	 */
	public List<ApproachAim> listForPreOrder(){
		DetachedCriteria dc = approachAimDao.createDetachedCriteria();
		dc.add(Restrictions.in("name", new String[]{"暂存","清洗"}));
		return approachAimDao.find(dc);
	}
	
	@Transactional(readOnly=false)
	public void save(ApproachAim approachAim) {
		approachAimDao.save(approachAim);
	}
	
	@Transactional(readOnly=false)
	public void delete(String id) {
		approachAimDao.deleteById(id);
	}
	
}
