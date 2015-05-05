package com.thinkgem.jeesite.modules.process.service;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.modules.process.entity.DepartExamination;
import com.thinkgem.jeesite.modules.process.dao.DepartExaminationDao;

/**
 * 出场箱检Service
 * @author 俞超
 * @version 2014-12-17
 */
@Service
@Transactional(readOnly=true)
public class DepartExaminationService extends BaseService {

	@Autowired
	private DepartExaminationDao departExaminationDao;
	
	public DepartExamination get(String id) {
		return departExaminationDao.get(id);
	}
	
	public Page<DepartExamination> find(Page<DepartExamination> page, DepartExamination departExamination) {
		DetachedCriteria dc = departExaminationDao.createDetachedCriteria();
		dc.addOrder(Order.desc("id"));
		return departExaminationDao.find(page, dc);
	}
	
	@Transactional(readOnly=false)
	public void save(DepartExamination departExamination) {
		departExaminationDao.save(departExamination);
	}
	
	@Transactional(readOnly=false)
	public void delete(String id) {
		departExaminationDao.deleteById(id);
	}
	
	@Transactional(readOnly=false)
	public void fulfillDepartExamine(DepartExamination departExamination){
		//更新出场流程状态
		
	}
	
}
