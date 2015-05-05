package com.thinkgem.jeesite.modules.sys.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.CompanyChargeInfo;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.WashInfo;
import com.thinkgem.jeesite.modules.sys.dao.CompanyChargeInfoDao;

/**
 * 公司收费Service
 * @author 俞超
 * @version 2014-12-17
 */
@Service
@Transactional(readOnly=true)
public class CompanyChargeInfoService extends BaseService {

	@Autowired
	private CompanyChargeInfoDao companyChargeInfoDao;
	
	public CompanyChargeInfo get(String id) {
		return companyChargeInfoDao.get(id);
	}
	
	public Page<CompanyChargeInfo> find(Page<CompanyChargeInfo> page, CompanyChargeInfo companyChargeInfo) {
		DetachedCriteria dc = companyChargeInfoDao.createDetachedCriteria();
		if(!StringUtils.isBlank(companyChargeInfo.getChargeName())){
		dc.add(Restrictions.like("charge_name", "%"+companyChargeInfo.getChargeName()+"%"));
		}
		dc.add(Restrictions.eq(WashInfo.FIELD_DEL_FLAG, WashInfo.DEL_FLAG_NORMAL));
		dc.addOrder(Order.desc("id"));
		return companyChargeInfoDao.find(page, dc);
	}
	
	@Transactional(readOnly=false)
	public void save(CompanyChargeInfo companyChargeInfo) {
		companyChargeInfoDao.clear();
		companyChargeInfoDao.save(companyChargeInfo);
	}
	
	@Transactional(readOnly=false)
	public void delete(String id) {
		companyChargeInfoDao.deleteById(id);
	}

	public List<CompanyChargeInfo> findAll() {
		return companyChargeInfoDao.findAll();
	}
	
}
