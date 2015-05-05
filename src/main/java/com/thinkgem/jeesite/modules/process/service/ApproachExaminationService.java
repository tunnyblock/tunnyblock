package com.thinkgem.jeesite.modules.process.service;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.modules.process.dao.ApproachExaminationDao;
import com.thinkgem.jeesite.modules.process.entity.ApproachExamination;

/**
 * 进场箱检Service
 * @author 俞超
 * @version 2014-12-17
 */
@Service
@Transactional(readOnly=true)
public class ApproachExaminationService extends BaseService {

	@Autowired
	private ApproachExaminationDao approachExaminationDao;
	
	public ApproachExamination get(String id) {
		return approachExaminationDao.get(id);
	}
	
	public Page<ApproachExamination> find(Page<ApproachExamination> page, ApproachExamination approachExamination) {
		DetachedCriteria dc = approachExaminationDao.createDetachedCriteria();
		dc.createAlias("tank", "tank"); 
		if(approachExamination.getTank()!=null){
			dc.add(Restrictions.eq("tank.tankCode", approachExamination.getTank().getTankCode()));
		}
		dc.add(Restrictions.eq("isProcessSetted", ApproachExamination.NO));
		dc.addOrder(Order.asc("createdTime"));
		return approachExaminationDao.find(page, dc);
	}
	
	@Transactional(readOnly=false)
	public void save(ApproachExamination approachExamination) {
		approachExaminationDao.save(approachExamination);
	}
	
	@Transactional(readOnly=false)
	public void delete(String id) {
		approachExaminationDao.deleteById(id);
	}
	
}
