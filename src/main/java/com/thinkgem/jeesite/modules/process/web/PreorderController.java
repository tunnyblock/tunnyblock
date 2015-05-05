package com.thinkgem.jeesite.modules.process.web;

import java.util.Date;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.client.service.ClientService;
import com.thinkgem.jeesite.modules.process.entity.Preorder;
import com.thinkgem.jeesite.modules.process.entity.Tank;
import com.thinkgem.jeesite.modules.process.service.ApproachAimService;
import com.thinkgem.jeesite.modules.process.service.PreorderService;
import com.thinkgem.jeesite.modules.process.service.TankService;
import com.thinkgem.jeesite.modules.sys.entity.WashInfo;
import com.thinkgem.jeesite.modules.sys.service.CompanyService;

/**
 * 预录单Controller
 * @author 俞超
 * @version 2014-12-09
 */
@Controller
@RequestMapping(value = "${adminPath}/process/preorder")
public class PreorderController extends BaseController {

	@Autowired
	private PreorderService preorderService;
	
	@Autowired
	private CompanyService companyService;
	
	@Resource
	private TankService tankService;
	
	@Resource
	private ApproachAimService approachAimService;
	
	@Resource
	private ClientService clientService;
	
	@ModelAttribute
	public Preorder get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return preorderService.get(id);
		}else{
			return new Preorder();
		}
	}
	
	@RequestMapping(value = {"list", ""})
	public String list(Preorder preorder, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Preorder> page = preorderService.find(new Page<Preorder>(request, response), preorder); 
        model.addAttribute("page", page);
		return "modules/" + "preorder/preorderList";
	}
	
	@RequestMapping(value="preapproach")
	public String preApproachExaminationList(Preorder preorder, HttpServletRequest request, HttpServletResponse response, Model model){
		Page<Preorder> page = preorderService.findUnApproachOrders(new Page<Preorder>(request, response), preorder); 
        model.addAttribute("page", page);
		return "modules/" + "process/preApproachExaminationList";
	}

	@RequestMapping(value = "form")
	public String form(Preorder preorder, Model model) {
		model.addAttribute("preorder", preorder);
		List<WashInfo> list = companyService.listAllCleanGoods();
		model.addAttribute("cleanGoodsList",JsonMapper.toJsonString(list));
		model.addAttribute("clientList", JsonMapper.toJsonString(clientService.listAllClients()));
		model.addAttribute("allApproachAimList", approachAimService.listForPreOrder());
		return "modules/" + "preorder/preorderForm";
	}

	@RequestMapping(value = "save")
	public String save(Preorder preorder, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, preorder)){
			return form(preorder, model);
		}
		String tankCode = preorder.getTank().getTankCode();
		Tank tank = tankService.findTankByCode(tankCode);
		if(tank==null){
			tank = new Tank();
			tank.setTankCode(tankCode);
			tank.setClient(preorder.getClient());
			tankService.save(tank);
		}
		if(StringUtils.isEmpty(preorder.getId())){
			preorder.setCreateUser(getCurrentUser());
			preorder.setCreateTime(new Date());
		}else{
			preorder.setUpdateUser(getCurrentUser());
			preorder.setUpdateTime(new Date());
		}
		preorder.setTank(tank);
		preorderService.save(preorder);
		addMessage(redirectAttributes, "保存预录单成功");
		return "redirect:"+Global.getAdminPath()+"/process/preorder/?repage";
	}
	
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		preorderService.delete(id);
		addMessage(redirectAttributes, "删除预录单成功");
		return "redirect:"+Global.getAdminPath()+"/process/preorder/?repage";
	}

}
