package com.thinkgem.jeesite.modules.client.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.client.entity.Client;
import com.thinkgem.jeesite.modules.client.entity.ClientEmployee;
import com.thinkgem.jeesite.modules.client.entity.ClientFinanceInfo;
import com.thinkgem.jeesite.modules.client.service.ClientEmployeeService;
import com.thinkgem.jeesite.modules.client.service.ClientFinanceInfoService;
import com.thinkgem.jeesite.modules.client.service.ClientService;

/**
 * 客户管理Controller
 * @author yuchao
 * @version 2014-11-25
 */
@Controller
@RequestMapping(value = "${adminPath}/client/client")
public class ClientController extends BaseController {

	@Autowired
	private ClientService clientService;
	
	@Autowired
	private ClientEmployeeService clientEmployeeService;
	
	@Autowired
	private ClientFinanceInfoService clientFinanceInfoService;
	
	@ModelAttribute
	public Client get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return clientService.get(id);
		}else{
			return new Client();
		}
	}
	
	@RequestMapping(value = {"list", ""})
	public String list(Client client, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Client> page = clientService.find(new Page<Client>(request, response), client); 
        model.addAttribute("page", page);
		return "modules/" + "client/clientList";
	}

	@RequestMapping(value = "form")
	public String form(Client client, Model model) {
		model.addAttribute("client", client);
		return "modules/" + "client/clientForm";
	}

	@RequestMapping(value = "save")
	public String save(Client client, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, client)){
			return form(client, model);
		}
		clientService.save(client);
		addMessage(redirectAttributes, "保存客户'" + client.getCompanyShortName()+ "'成功");
		return "redirect:"+Global.getAdminPath()+"/client/client/?repage";
	}
	
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		clientService.delete(id);
		addMessage(redirectAttributes, "删除客户成功");
		return "redirect:"+Global.getAdminPath()+"/client/client/?repage";
	}
	
	@RequestMapping(value="/{officeId}/clientEmployeeList")
	public String getClientEmployeeList(ClientEmployee clientEmployee, HttpServletRequest request, HttpServletResponse response, Model model,@PathVariable String officeId){
		Client client = clientService.get(officeId);
		clientEmployee.setClient(client);
		Page<ClientEmployee> page = clientEmployeeService.find(new Page<ClientEmployee>(request, response), clientEmployee); 
        model.addAttribute("page", page);
        model.addAttribute("officeId", officeId);
		return "modules/client/clientEmployeeList";
	}
	
	///员工信息
	@RequestMapping(value="/{officeId}/clientEmployee/{clientEmployeeId}")
	@ResponseBody
	public String getClientEmployeeJson(@PathVariable String officeId,@PathVariable String clientEmployeeId){
		ClientEmployee clientEmployee = clientEmployeeService.get(clientEmployeeId);
		return JsonMapper.toJsonString(clientEmployee);
	}
	
	@RequestMapping(value = "/{officeId}/clientEmployee/save",method=RequestMethod.POST)
	public String save(ClientEmployee clientEmployee, Model model, RedirectAttributes redirectAttributes,@PathVariable String officeId) {
		Client client = clientService.get(officeId);
		clientEmployee.setClient(client);
		clientEmployeeService.save(clientEmployee);
		addMessage(redirectAttributes, "保存客户员工信息成功");
		return "redirect:"+Global.getAdminPath()+"/client/client/"+officeId+"/clientEmployeeList";
	}
	
	@RequiresPermissions("client:clientEmployee:edit")
	@RequestMapping(value = "/{officeId}/clientEmployee/delete")
	public String deleteClientEmployee(String id, RedirectAttributes redirectAttributes,@PathVariable String officeId) {
		clientEmployeeService.delete(id);
		addMessage(redirectAttributes, "删除客户员工成功");
		return "redirect:"+Global.getAdminPath()+"/client/client/"+officeId+"/clientEmployeeList";
	}
	
	///财务信息
	@RequestMapping(value="/{clientId}/clientFinance")
	public String getClientFinanceInfo(@PathVariable String clientId,Model model){
		ClientFinanceInfo clientFinanceInfo = clientFinanceInfoService.findClientFianceInfoByClientId(clientId);
		model.addAttribute("clientFinanceInfo",clientFinanceInfo==null?new ClientFinanceInfo():clientFinanceInfo);
		model.addAttribute("clientId", clientId);
		return "modules/client/clientFinanceInfoForm";
	}
	
	@ResponseBody
	@RequestMapping("clientUserTreeData")
	public List<Map<String, Object>> treeData(HttpServletResponse response,@RequestParam(required = true) String clientId) {
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		Client client = clientService.get(clientId);
		List<ClientEmployee> list = clientEmployeeService.findByClientId(clientId);
		if(list!=null){
			Map<String, Object> clientMap = Maps.newHashMap();
			clientMap.put("id", client.getId());
			clientMap.put("pId", 0);
			clientMap.put("name", client.getCompanyChineseName());
			clientMap.put("open", true);
			mapList.add(clientMap);
			for(ClientEmployee clientEmployee:list){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", clientEmployee.getId());
				map.put("pId", client.getId());
				map.put("name", clientEmployee.getChineseName());
				map.put("open", true);
				mapList.add(map);
			}
		}
		return mapList;
	}

}
