package com.thinkgem.jeesite.modules.client.dao;

import org.springframework.stereotype.Repository;

import com.thinkgem.jeesite.common.persistence.BaseDao;
import com.thinkgem.jeesite.common.persistence.Parameter;
import com.thinkgem.jeesite.modules.client.entity.ClientFinanceInfo;

/**
 * 客户财务信息DAO接口
 * @author 俞超
 * @version 2014-12-08
 */
@Repository
public class ClientFinanceInfoDao extends BaseDao<ClientFinanceInfo> {
	
	public ClientFinanceInfo findClientFianceInfoByClientId(String clientId){
		return getByHql("from ClientFinanceInfo where client.id = :p1", new Parameter(clientId));
	}
}
