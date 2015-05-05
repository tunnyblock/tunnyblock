/**
 * There are <a href="https://github.com/thinkgem/jeesite">JeeSite</a> code generation
 */
package com.thinkgem.jeesite.modules.client.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.modules.client.dao.ClientEmployeeDao;
import com.thinkgem.jeesite.modules.client.entity.ClientEmployee;

/**
 * 客户员工管理Service
 * @author 俞超
 * @version 2014-11-26
 */
@Service
@Transactional
public class ClientEmployeeService extends BaseService {

	@Autowired
	private ClientEmployeeDao clientEmployeeDao;
	
	public ClientEmployee get(String id) {
		return clientEmployeeDao.get(id);
	}
	
	public List<ClientEmployee> findByClientId(String clientId){
		DetachedCriteria dc = clientEmployeeDao.createDetachedCriteria();
		dc.add(Restrictions.eq("client.id", clientId));
		return clientEmployeeDao.find(dc);
	}
	
	public Page<ClientEmployee> find(Page<ClientEmployee> page, ClientEmployee clientEmployee) {
		DetachedCriteria dc = clientEmployeeDao.createDetachedCriteria();
		if(clientEmployee.getClient()!=null){
			dc.add(Restrictions.eq("client.id", clientEmployee.getClient().getId()));
		}
		dc.addOrder(Order.desc("id"));
		return clientEmployeeDao.find(page, dc);
	}
	
	public void save(ClientEmployee clientEmployee) {
		clientEmployeeDao.save(clientEmployee);
	}
	
	public void delete(String id) {
		clientEmployeeDao.deleteById(id);
	}
	
}
