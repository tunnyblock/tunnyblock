package com.thinkgem.jeesite.modules.sys.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.process.service.TaskService;
import com.thinkgem.jeesite.modules.sys.entity.CompanyChargeInfo;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.service.CompanyChargeInfoService;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 公司收费Controller
 * @author 俞超
 * @version 2014-12-17
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/companyChargeInfo")
public class CompanyChargeInfoController extends BaseController {

	@Autowired
	private CompanyChargeInfoService companyChargeInfoService;
	@Autowired
	private OfficeService officeService;
	@Autowired
	private TaskService taskService;
	
	@ModelAttribute
	public CompanyChargeInfo get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return companyChargeInfoService.get(id);
		}else{
			return new CompanyChargeInfo();
		}
	}
	
	@RequestMapping(value = {"list", ""})
	public String list(CompanyChargeInfo companyChargeInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<CompanyChargeInfo> page = companyChargeInfoService.find(new Page<CompanyChargeInfo>(request, response), companyChargeInfo); 
        model.addAttribute("page", page);
		return "modules/" + "sys/companyChargeInfoList";  
	}

	@RequestMapping(value = "form")
	public String form(CompanyChargeInfo companyChargeInfo, Model model) {
		if (companyChargeInfo.getTaskList()==null){
			//role.setOffice(UserUtils.getUser().getOffice());
		}
		model.addAttribute("taskList", taskService.findAll());
		model.addAttribute("companyChargeInfo", companyChargeInfo);
		return "modules/" + "sys/companyChargeInfoForm"; 
	}

	@RequestMapping(value = "save")
	public String save(CompanyChargeInfo companyChargeInfo, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request) {
		if (!beanValidator(model, companyChargeInfo)){
			return form(companyChargeInfo, model);
		}
		/*Office office=officeService.get(request.getParameter("company.id"));*/
		
		companyChargeInfo.setCompany(new Office(request.getParameter("company.id")));
		companyChargeInfoService.save(companyChargeInfo);
		addMessage(redirectAttributes, "保存公司收费成功");
		return "redirect:"+Global.getAdminPath()+"/sys/companyChargeInfo/?repage";
	}
	
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		companyChargeInfoService.delete(id);
		
		addMessage(redirectAttributes, "删除公司收费成功");
		return "redirect:"+Global.getAdminPath()+"/sys/companyChargeInfo/?repage";
	}
	@RequiresUser
	@ResponseBody
	@RequestMapping("treeData")
	public List<Map<String, Object>> treeData(HttpServletResponse response,
			@RequestParam(required = false) Long extId,
			@RequestParam(required = false) Long type,
			@RequestParam(required = false) Long grade) {
		
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		
//		User user = UserUtils.getUser();
		List<Office> list = officeService.findAll();
		for (int i=0; i<list.size(); i++){
			Office e = list.get(i);
			
			if ((extId == null || (extId!=null && !extId.equals(e.getId()) ))
					&& (type == null || (type != null ))
					&& (grade == null || (grade != null )) &&e.getParent() == null){
				
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
//				map.put("pId", !user.isAdmin() && e.getId().equals(user.getOffice().getId())?0:e.getParent()!=null?e.getParent().getId():0);
//              	map.put("pId", e.getParent() != null ? e.getParent().getId() : 0);
				map.put("name", e.getName());
				map.put("open", true);
				mapList.add(map);
			}
		}
		return mapList;
	}

}
