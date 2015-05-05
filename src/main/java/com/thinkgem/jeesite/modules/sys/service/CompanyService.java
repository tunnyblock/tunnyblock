/**
 * Copyright &copy; 2012-2013 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.thinkgem.jeesite.modules.sys.service;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.dao.WashDao;
import com.thinkgem.jeesite.modules.sys.entity.WashInfo;

/**
 * 系统管理，安全相关实体的管理类,包括用户、角色、菜单.
 * @author ThinkGem
 * @version 2013-5-15
 */
@Service
@Transactional(readOnly = true)
public class CompanyService extends BaseService  {
	

	@Autowired 
	private WashDao washDao;

	
	//-- Wash Service --//
	public WashInfo getWashInfo(String id) {
		
		return washDao.get(id);
	}
	public Page<WashInfo> findWashInfo(Page<WashInfo> page, WashInfo washInfo) {
		DetachedCriteria dc = washDao.createDetachedCriteria();
	
		if(!StringUtils.isBlank(washInfo.getGoodsChineseName()))
		{
			dc.add(Restrictions.or(
					Restrictions.like("goodsChineseName", "%"+washInfo.getGoodsChineseName()+"%"),
					Restrictions.like("goodsEnglishName", "%"+washInfo.getGoodsChineseName()+"%"),
					Restrictions.like("goodsShortName", "%"+washInfo.getGoodsChineseName()+"%")
					));
		}
		dc.add(Restrictions.eq(WashInfo.FIELD_DEL_FLAG, WashInfo.DEL_FLAG_NORMAL));
		
		return washDao.find(page, dc);
	
	}
	@Transactional(readOnly = false)
	public void saveWashInfo(WashInfo washInfo) {
		washDao.save(washInfo);
	}
	@Transactional(readOnly = false)
	public void deleteWashInfo(String id) {
		washDao.deleteById(id);
		
	}
	
	public List<WashInfo> listAllCleanGoods(){
		DetachedCriteria dc = washDao.createDetachedCriteria();
		dc.add(Restrictions.eq(WashInfo.FIELD_DEL_FLAG, WashInfo.DEL_FLAG_NORMAL));
		List<WashInfo> list = washDao.find(dc);
		return list==null?new ArrayList<WashInfo>():list;
	}

	
}
