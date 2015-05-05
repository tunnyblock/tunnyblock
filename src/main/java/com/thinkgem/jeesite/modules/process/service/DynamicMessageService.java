package com.thinkgem.jeesite.modules.process.service;

import java.util.Date;
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
import com.thinkgem.jeesite.modules.process.entity.DynamicMessage;
import com.thinkgem.jeesite.modules.process.dao.DynamicMessageDao;

/**
 * 动态消息Service
 * @author 俞超
 * @version 2015-01-24
 */
@Service
@Transactional(readOnly=true)
public class DynamicMessageService extends BaseService {

	@Autowired
	private DynamicMessageDao dynamicMessageDao;
	
	public DynamicMessage get(String id) {
		return dynamicMessageDao.get(id);
	}
	
	public List<DynamicMessage> find(DynamicMessage dynamicMessage){
		DetachedCriteria dc = dynamicMessageDao.createDetachedCriteria();
		if(dynamicMessage.getToUser()!=null&&!StringUtils.isEmpty(dynamicMessage.getToUser().getId())){
			dc.add(Restrictions.eq("toUser.id", dynamicMessage.getToUser().getId()));
		}
		
		if(!StringUtils.isEmpty(dynamicMessage.getType())){
			dc.add(Restrictions.eq("type", dynamicMessage.getType()));
		}
		dc.add(Restrictions.eq("isReaded", DynamicMessage.NO));
		dc.addOrder(Order.desc("generateTime"));
		return dynamicMessageDao.find(dc);
	}
	
	public Page<DynamicMessage> find(Page<DynamicMessage> page, DynamicMessage dynamicMessage) {
		DetachedCriteria dc = dynamicMessageDao.createDetachedCriteria();
		dc.addOrder(Order.desc("id"));
		return dynamicMessageDao.find(page, dc);
	}
	
	@Transactional(readOnly=false)
	public void save(DynamicMessage dynamicMessage) {
		dynamicMessageDao.save(dynamicMessage);
	}
	
	@Transactional(readOnly=false)
	public void delete(String id) {
		dynamicMessageDao.deleteById(id);
	}
	
	@Transactional(readOnly=false)
	public void readDynamicMessage(DynamicMessage dynamicMessage){
		dynamicMessage.setIsReaded(DynamicMessage.YES);
		dynamicMessage.setReadedTime(new Date());
		dynamicMessageDao.save(dynamicMessage);
	}
	
}
