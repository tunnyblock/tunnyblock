/**
 * Copyright &copy; 2012-2013 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.thinkgem.jeesite.modules.sys.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.CompanyFinanceInfo;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.CompanyFinanceInfoService;
import com.thinkgem.jeesite.modules.sys.service.UserService;

/**
 * 用户Controller
 * 
 * @author ThinkGem
 * @version 2013-5-31
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/companyfinance")
public class CompanyFinanceController extends BaseController {

	@Autowired
	private CompanyFinanceInfoService companyFinanceInfoService;
	@Autowired
	private UserService userService;

	@ModelAttribute
	public CompanyFinanceInfo get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return companyFinanceInfoService.get(id);
		} else {
			return new CompanyFinanceInfo();
		}
	}

	@RequiresPermissions("sys:companyfinance:edit")
	@RequestMapping({ "addUI", "" })
	public String addUI(CompanyFinanceInfo companyFinanceInfo,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {

		List<User> userList = userService.findAll();
		model.addAttribute("userList", userList);
		if (StringUtils.isBlank(companyFinanceInfo.getId())) {
			companyFinanceInfo = companyFinanceInfoService.findTopOne();
			model.addAttribute("companyFinanceInfo", companyFinanceInfo);
		}
		return "modules/sys/finance/editUI";
	}

	@RequiresPermissions("sys:companyfinance:edit")
	@RequestMapping({ "add" })
	public String add(String finaceContacter,
			CompanyFinanceInfo companyFinanceInfo, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		User user = userService.findById(finaceContacter);
		companyFinanceInfo.setFinaceContacter(user);
		List<User> userList = userService.findAll();
		model.addAttribute("userList", userList);
		companyFinanceInfoService.save(companyFinanceInfo);

		return "redirect:" + Global.getAdminPath()
				+ "/sys/companyfinance/addUI";
	}

}
