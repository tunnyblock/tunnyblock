package com.thinkgem.jeesite.modules.emergency.web;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.client.service.ClientService;
import com.thinkgem.jeesite.modules.emergency.entity.EmergencyMaintenance;
import com.thinkgem.jeesite.modules.emergency.service.EmergencyMaintenanceService;

/**
 * 应急维修Controller
 * @author 俞超
 * @version 2015-02-07
 */
@Controller
@RequestMapping(value = "${adminPath}/emergency/emergencyMaintenance")
public class EmergencyMaintenanceController extends BaseController {

	@Autowired
	private EmergencyMaintenanceService emergencyMaintenanceService;
	
	@Autowired
	private ClientService clientService;
	
	@ModelAttribute
	public EmergencyMaintenance get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return emergencyMaintenanceService.get(id);
		}else{
			return new EmergencyMaintenance();
		}
	}
	
	@RequestMapping(value = {"list", ""})
	public String list(EmergencyMaintenance emergencyMaintenance, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<EmergencyMaintenance> page = emergencyMaintenanceService.find(new Page<EmergencyMaintenance>(request, response), emergencyMaintenance); 
        model.addAttribute("page", page);
		return "modules/" + "emergency/emergencyMaintenanceList";
	}

	@RequestMapping(value = "form")
	public String form(EmergencyMaintenance emergencyMaintenance, Model model) {
		model.addAttribute("emergencyMaintenance", emergencyMaintenance);
		model.addAttribute("userList",systemService.getAllTechnologyOfficeUsers());
		model.addAttribute("clientList",clientService.listAllClients());
		return "modules/" + "emergency/emergencyMaintenanceForm";
	}

	@RequestMapping(value = "save")
	public String save(EmergencyMaintenance emergencyMaintenance, Model model) {
		emergencyMaintenance.setGenerateUser(getCurrentUser());
		emergencyMaintenance.setGenerateTime(new Date());
		emergencyMaintenanceService.generateEmergencyMaintenance(emergencyMaintenance);
		return "redirect:"+Global.getAdminPath()+"/process/workbench/customService/?repage";
	}
	
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		emergencyMaintenanceService.delete(id);
		addMessage(redirectAttributes, "删除应急维修成功");
		return "redirect:"+Global.getAdminPath()+"/emergency/emergencyMaintenance/?repage";
	}

}
