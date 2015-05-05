package com.thinkgem.jeesite.modules.process.web;

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
import com.thinkgem.jeesite.modules.process.entity.DepartExamination;
import com.thinkgem.jeesite.modules.process.entity.Process;
import com.thinkgem.jeesite.modules.process.entity.ProcessIventory;
import com.thinkgem.jeesite.modules.process.service.DepartExaminationService;
import com.thinkgem.jeesite.modules.process.service.ProcessIventoryService;
import com.thinkgem.jeesite.modules.process.service.ProcessService;

/**
 * 出场箱检Controller
 * @author 俞超
 * @version 2014-12-17
 */
@Controller
@RequestMapping(value = "${adminPath}/process/departExamination")
public class DepartExaminationController extends BaseController {

	@Autowired
	private DepartExaminationService departExaminationService;
	
	@Autowired
	private ProcessService processService;
	
	@Autowired
	private ProcessIventoryService processIventoryService;
	
	@ModelAttribute
	public DepartExamination get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return departExaminationService.get(id);
		}else{
			return new DepartExamination();
		}
	}
	
	@RequestMapping(value = {"list", ""})
	public String list(DepartExamination departExamination, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<DepartExamination> page = departExaminationService.find(new Page<DepartExamination>(request, response), departExamination); 
        model.addAttribute("page", page);
		return "modules/" + "process/departExaminationList";
	}

	@RequestMapping(value = "examine")
	public String form(DepartExamination departExamination, Model model) {
		model.addAttribute("departExamination", departExamination);
		return "modules/" + "process/departExaminationForm";
	}

	@RequestMapping(value = "save")
	public String save(DepartExamination departExamination, Model model, RedirectAttributes redirectAttributes) {
		//出场流程结束
		Process departProcess = processService.get(departExamination.getDepartProcess().getId());
		processService.updateProcessState(departProcess, Process.STATE_END);
		
		//流程清单结束
		ProcessIventory processIventory = processIventoryService.get(departExamination.getProcessIventory().getId());
		processIventory.setIsEnded("1");
		processIventory.setEndTime(new Date());
		processIventoryService.save(processIventory);
		
		//保存出场箱检
		departExaminationService.save(departExamination);
		
		addMessage(redirectAttributes, "保存出场箱检成功");
		return "redirect:"+Global.getAdminPath()+"/process/departExamination/?repage";
	}
	
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		departExaminationService.delete(id);
		addMessage(redirectAttributes, "删除出场箱检成功");
		return "redirect:"+Global.getAdminPath()+"/process/departExamination/?repage";
	}

}
