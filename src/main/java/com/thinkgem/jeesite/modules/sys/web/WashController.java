/**
@ModelAttribute * Copyright &copy; 2012-2013 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.thinkgem.jeesite.modules.sys.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.WashInfo;
import com.thinkgem.jeesite.modules.sys.service.CompanyService;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;

/**
 * 用户Controller
 * @author ThinkGem
 * @version 2013-5-31
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/wash")
public class WashController extends BaseController {

	@Autowired
	private CompanyService companyService;
	
	@Resource
	private OfficeService officeService;
	
	@ModelAttribute
	public WashInfo get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return companyService.getWashInfo(id);
		}else{
			return new WashInfo();
		}
	}
	@RequestMapping({"addUI"})
	public String addUI(WashInfo washInfo, Model model) {
		model.addAttribute("washProduct", washInfo);
		return "modules/sys/wash/editUI";
		
	}
	@RequestMapping({"add"})
	public String add(WashInfo washInfo, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		//默认添加根公司
		Office office = officeService.get("1");
		washInfo.setOffice(office);
		washInfo.setDelFlag(WashInfo.DEL_FLAG_NORMAL);
		companyService.saveWashInfo(washInfo);
		addMessage(redirectAttributes, "保存清洗货物成功成功");
		return "redirect:"+ Global.getAdminPath() +"/sys/wash/list"; 
		
	}
	@RequestMapping({"list",""}) 
	public String list(WashInfo washInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<WashInfo> page = companyService.findWashInfo(new Page<WashInfo>(request, response), washInfo); 
	    model.addAttribute("page", page);
		return "modules/sys/wash/list"; 
		
	}
	@RequestMapping({"delete"}) 
	public String delete(String id, RedirectAttributes redirectAttributes) {
		companyService.deleteWashInfo(id);
		addMessage(redirectAttributes, "删除成功");
		return "redirect:"+ Global.getAdminPath() +"/sys/wash/list"; 
		
	}
	@RequestMapping({"editUI"}) 
	public String editUI(WashInfo washInfo, Model model) {
		model.addAttribute("washProduct", washInfo);
		return "modules/sys/wash/editUI";
	}
	
	@RequestMapping({"getCleanGoodsJsonList"})
	@ResponseBody
	public List<WashInfo> getCleanGoodsJson(){
		List<WashInfo> list = companyService.listAllCleanGoods();
		return list;
	}
	
}
