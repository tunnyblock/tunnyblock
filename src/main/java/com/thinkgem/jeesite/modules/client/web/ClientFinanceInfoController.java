package com.thinkgem.jeesite.modules.client.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.client.entity.ClientFinanceInfo;
import com.thinkgem.jeesite.modules.client.service.ClientFinanceInfoService;

/**
 * 客户财务信息Controller
 * @author 俞超
 * @version 2014-12-08
 */
@Controller
@RequestMapping(value = "${adminPath}/client/clientFinanceInfo")
public class ClientFinanceInfoController extends BaseController {

	@Autowired
	private ClientFinanceInfoService clientFinanceInfoService;
	
	@ModelAttribute
	public ClientFinanceInfo get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return clientFinanceInfoService.get(id);
		}else{
			return new ClientFinanceInfo();
		}
	}
	
	@RequestMapping(value = {"list", ""})
	public String list(ClientFinanceInfo clientFinanceInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<ClientFinanceInfo> page = clientFinanceInfoService.find(new Page<ClientFinanceInfo>(request, response), clientFinanceInfo); 
        model.addAttribute("page", page);
		return "modules/" + "client/clientFinanceInfoList";
	}

	@RequestMapping(value = "form")
	public String form(ClientFinanceInfo clientFinanceInfo, Model model) {
		model.addAttribute("clientFinanceInfo", clientFinanceInfo);
		return "modules/" + "client/clientFinanceInfoForm";
	}

	@RequestMapping(value = "save")
	public String save(ClientFinanceInfo clientFinanceInfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, clientFinanceInfo)){
			return form(clientFinanceInfo, model);
		}
		clientFinanceInfoService.save(clientFinanceInfo);
		addMessage(redirectAttributes, "保存客户财务信息成功");
		return "redirect:"+Global.getAdminPath()+"/client/clientFinanceInfo/?repage";
	}
	
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		clientFinanceInfoService.delete(id);
		addMessage(redirectAttributes, "删除客户财务信息成功");
		return "redirect:"+Global.getAdminPath()+"/client/clientFinanceInfo/?repage";
	}

}
