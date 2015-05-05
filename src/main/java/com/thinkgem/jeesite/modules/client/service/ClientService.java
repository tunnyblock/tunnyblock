package com.thinkgem.jeesite.modules.client.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.modules.client.dao.ClientDao;
import com.thinkgem.jeesite.modules.client.entity.Client;

/**
 * 客户管理Service
 * @author 俞超
 * @version 2014-11-25
 */
@Service
@Transactional
public class ClientService extends BaseService {

	@Autowired
	private ClientDao clientDao;
	
	public Client get(String id) {
		return clientDao.get(id);
	}
	
	public Page<Client> find(Page<Client> page, Client client) {
		DetachedCriteria dc = clientDao.createDetachedCriteria();
		if(!StringUtils.isEmpty(client.getCompanyShortName())){
			dc.add(Restrictions.or(
					Restrictions.like("companyChineseName", "%"+client.getCompanyShortName()+"%"),
					Restrictions.like("companyEnglishName", "%"+client.getCompanyShortName()+"%"),
					Restrictions.like("companyShortName", "%"+client.getCompanyShortName()+"%")
			));
		}
		dc.add(Restrictions.eq(Client.FIELD_DEL_FLAG, Client.DEL_FLAG_NORMAL));
		dc.addOrder(Order.desc("id"));
		return clientDao.find(page, dc);
	}
	
	public List<Client> listAllClients(){
		DetachedCriteria dc = clientDao.createDetachedCriteria();
		dc.add(Restrictions.eq("delFlag", Client.DEL_FLAG_NORMAL));
		return clientDao.find(dc);
	}
	
	public void save(Client client) {
		clientDao.save(client);
	}
	
	public void delete(String id) {
		clientDao.deleteById(id);
	}
	
}
