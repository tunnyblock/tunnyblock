package com.thinkgem.jeesite.modules.client.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.client.entity.ClientEmployee;
import com.thinkgem.jeesite.modules.client.service.ClientEmployeeService;

/**
 * 客户员工管理Controller
 * @author 俞超
 * @version 2014-11-26
 */
@Controller
@RequestMapping(value = "${adminPath}/client/clientEmployee")
public class ClientEmployeeController extends BaseController {

	@Autowired
	private ClientEmployeeService clientEmployeeService;
	
	@ModelAttribute
	public ClientEmployee get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return clientEmployeeService.get(id);
		}else{
			return new ClientEmployee();
		}
	}
	
	@RequiresPermissions("client:clientEmployee:view")
	@RequestMapping(value = {"list", ""})
	public String list(ClientEmployee clientEmployee, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<ClientEmployee> page = clientEmployeeService.find(new Page<ClientEmployee>(request, response), clientEmployee); 
        model.addAttribute("page", page);
		return "modules/" + "client/clientEmployeeList";
	}

	@RequiresPermissions("client:clientEmployee:view")
	@RequestMapping(value = "form")
	public String form(ClientEmployee clientEmployee, Model model) {
		model.addAttribute("clientEmployee", clientEmployee);
		return "modules/" + "client/clientEmployeeForm";
	}

	@RequiresPermissions("client:clientEmployee:edit")
	@RequestMapping(value = "save")
	public String save(ClientEmployee clientEmployee, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, clientEmployee)){
			return form(clientEmployee, model);
		}
		clientEmployeeService.save(clientEmployee);
		addMessage(redirectAttributes, "保存客户员工管理成功");
		return "redirect:"+Global.getAdminPath()+"/client/clientEmployee/?repage";
	}
	
	@RequiresPermissions("client:clientEmployee:edit")
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		clientEmployeeService.delete(id);
		addMessage(redirectAttributes, "删除客户员工管理成功");
		return "redirect:"+Global.getAdminPath()+"/client/clientEmployee/?repage";
	}
	
	@RequestMapping(value="/{clientId}/employees")
	@ResponseBody
	public String getCliemtEmplyeeListByClientId(@PathVariable String clientId){
		return JsonMapper.toJsonString(clientEmployeeService.findByClientId(clientId));
	}

}
