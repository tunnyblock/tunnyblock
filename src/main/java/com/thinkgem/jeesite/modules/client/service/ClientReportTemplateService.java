package com.thinkgem.jeesite.modules.client.service;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.modules.client.entity.ClientReportTemplate;
import com.thinkgem.jeesite.modules.client.dao.ClientReportTemplateDao;

/**
 * 客户公司报表Service
 * @author 俞超
 * @version 2014-12-17
 */
@Service
@Transactional(readOnly=true)
public class ClientReportTemplateService extends BaseService {

	@Autowired
	private ClientReportTemplateDao clientReportTemplateDao;
	
	public ClientReportTemplate get(String id) {
		return clientReportTemplateDao.get(id);
	}
	
	public Page<ClientReportTemplate> find(Page<ClientReportTemplate> page, ClientReportTemplate clientReportTemplate) {
		DetachedCriteria dc = clientReportTemplateDao.createDetachedCriteria();
		dc.addOrder(Order.desc("id"));
		return clientReportTemplateDao.find(page, dc);
	}
	
	@Transactional(readOnly=false)
	public void save(ClientReportTemplate clientReportTemplate) {
		clientReportTemplateDao.save(clientReportTemplate);
	}
	
	@Transactional(readOnly=false)
	public void delete(String id) {
		clientReportTemplateDao.deleteById(id);
	}
	
}
