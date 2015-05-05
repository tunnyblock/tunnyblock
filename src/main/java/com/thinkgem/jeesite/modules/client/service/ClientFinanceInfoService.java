/**
 * There are <a href="https://github.com/thinkgem/jeesite">JeeSite</a> code generation
 */
package com.thinkgem.jeesite.modules.client.service;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.service.jta.platform.internal.ResinJtaPlatform;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.persistence.Parameter;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.modules.client.dao.ClientFinanceInfoDao;
import com.thinkgem.jeesite.modules.client.entity.ClientFinanceInfo;

/**
 * 客户财务信息Service
 * @author 俞超
 * @version 2014-12-08
 */
@Service
@Transactional(readOnly=true)
public class ClientFinanceInfoService extends BaseService {

	@Autowired
	private ClientFinanceInfoDao clientFinanceInfoDao;
	
	public ClientFinanceInfo get(String id) {
		return clientFinanceInfoDao.get(id);
	}
	
	public Page<ClientFinanceInfo> find(Page<ClientFinanceInfo> page, ClientFinanceInfo clientFinanceInfo) {
		DetachedCriteria dc = clientFinanceInfoDao.createDetachedCriteria();
		dc.addOrder(Order.desc("id"));
		return clientFinanceInfoDao.find(page, dc);
	}
	
	public ClientFinanceInfo findClientFianceInfoByClientId(String clientId){
		return clientFinanceInfoDao.findClientFianceInfoByClientId(clientId);
	}
	
	@Transactional(readOnly=false)
	public void save(ClientFinanceInfo clientFinanceInfo) {
		clientFinanceInfoDao.save(clientFinanceInfo);
	}
	
	@Transactional(readOnly=false)
	public void delete(String id) {
		clientFinanceInfoDao.deleteById(id);
	}
	
}
