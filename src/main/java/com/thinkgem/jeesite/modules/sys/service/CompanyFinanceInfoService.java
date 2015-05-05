package com.thinkgem.jeesite.modules.sys.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.modules.sys.dao.CompanyFinanceInfoDao;
import com.thinkgem.jeesite.modules.sys.entity.CompanyFinanceInfo;

@Service
@Transactional
public class CompanyFinanceInfoService extends BaseService {

	@Autowired
	private CompanyFinanceInfoDao companyFinanceInfoDao;

	public void save(CompanyFinanceInfo companyFinanceInfo) {
		companyFinanceInfoDao.save(companyFinanceInfo);
	}

	public List<CompanyFinanceInfo> findAll() {
		return companyFinanceInfoDao.findAll();
	}

	public CompanyFinanceInfo get(String id) {
		return companyFinanceInfoDao.get(id);
	}

	public CompanyFinanceInfo findTopOne() {
		DetachedCriteria dc = companyFinanceInfoDao.createDetachedCriteria();
		dc.addOrder(Order.desc("id"));
		List<CompanyFinanceInfo> companyFinanceInfos = companyFinanceInfoDao
				.find(dc);
		if (companyFinanceInfos != null && companyFinanceInfos.size() > 0) {

			return companyFinanceInfos.get(0);

		}

		return new CompanyFinanceInfo();
	}
}
