package com.thinkgem.jeesite.modules.comment.service;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.modules.comment.entity.Affix;
import com.thinkgem.jeesite.modules.comment.dao.AffixDao;

/**
 * 评论附件Service
 * @author 俞超
 * @version 2015-02-05
 */
@Service
@Transactional(readOnly=true)
public class AffixService extends BaseService {

	@Autowired
	private AffixDao affixDao;
	
	public Affix get(String id) {
		return affixDao.get(id);
	}
	
	public Page<Affix> find(Page<Affix> page, Affix affix) {
		DetachedCriteria dc = affixDao.createDetachedCriteria();
		dc.addOrder(Order.desc("id"));
		return affixDao.find(page, dc);
	}
	
	@Transactional(readOnly=false)
	public void save(Affix affix) {
		affixDao.save(affix);
	}
	
	@Transactional(readOnly=false)
	public void delete(String id) {
		affixDao.deleteById(id);
	}
	
}
