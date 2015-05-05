package com.thinkgem.jeesite.modules.process.web;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.client.service.ClientService;
import com.thinkgem.jeesite.modules.process.entity.ApproachExamination;
import com.thinkgem.jeesite.modules.process.entity.Preorder;
import com.thinkgem.jeesite.modules.process.entity.Tank;
import com.thinkgem.jeesite.modules.process.service.ApproachExaminationService;
import com.thinkgem.jeesite.modules.process.service.PreorderService;
import com.thinkgem.jeesite.modules.process.service.TankService;

/**
 * 进场箱检Controller
 * @author 俞超
 * @version 2014-12-17
 */
@Controller
@RequestMapping(value = "${adminPath}/process/approachExamination")
public class ApproachExaminationController extends BaseController {

	@Autowired
	private ApproachExaminationService approachExaminationService;
	
	@Autowired
	private PreorderService preorderService;
	
	@Resource
	private TankService tankService;
	
	@Resource
	private ClientService clientService;
	
	@ModelAttribute
	public ApproachExamination get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return approachExaminationService.get(id);
		}else{
			return new ApproachExamination();
		}
	}
	
	@RequestMapping(value = {"list", ""})
	public String list(ApproachExamination approachExamination, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<ApproachExamination> page = approachExaminationService.find(new Page<ApproachExamination>(request, response), approachExamination); 
        model.addAttribute("page", page);
		return "modules/" + "process/approachExaminationList";
	}
	
	@RequestMapping(value="examine/{preorderId}")
	public String examine(@PathVariable String preorderId,Model model){
		ApproachExamination approachExamination = new ApproachExamination();
		approachExamination.setCreatedTime(new Date());
		Preorder preorder = preorderService.get(preorderId);
		approachExamination.setPreorder(preorder);
		approachExamination.setTank(preorder.getTank());
		model.addAttribute("clientList", JsonMapper.toJsonString(clientService.listAllClients()));
		model.addAttribute("approachExamination", approachExamination);
		return "modules/" + "process/approachExaminiationForm";
	}

	@RequestMapping(value = "form")
	public String form(ApproachExamination approachExamination, Model model) {
		model.addAttribute("approachExamination", approachExamination);
		return "modules/" + "process/approachExaminationForm";
	}

	@RequestMapping(value = "save")
	public String save(ApproachExamination approachExamination, Model model, RedirectAttributes redirectAttributes) {
		String tankCode = approachExamination.getTank().getTankCode();
		String preorderId = approachExamination.getPreorder().getId();
		Preorder preorder = preorderService.get(preorderId);
		preorderService.updateAppraochTime(preorder);
		Tank tank = tankService.findTankByCode(tankCode);
		BeanUtils.copyProperties(approachExamination.getTank(), tank, new String[]{"id"});
		tankService.save(tank);
		if(!StringUtils.isEmpty(approachExamination.getDamagePicturePackage())){
			approachExamination.setIsDamaged(ApproachExamination.YES);
		}
		approachExamination.setTank(tank);
		approachExamination.setCreateUser(getCurrentUser());
		approachExaminationService.save(approachExamination);
		return "redirect:"+Global.getAdminPath()+"/process/approachExamination/?repage";
	}
	
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		approachExaminationService.delete(id);
		addMessage(redirectAttributes, "删除进场箱检成功");
		return "redirect:"+Global.getAdminPath()+"/process/approachExamination/?repage";
	}

}
