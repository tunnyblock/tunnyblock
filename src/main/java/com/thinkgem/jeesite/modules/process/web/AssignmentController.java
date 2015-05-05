package com.thinkgem.jeesite.modules.process.web;

import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Collections3;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.client.service.ClientService;
import com.thinkgem.jeesite.modules.process.entity.ApproachAim;
import com.thinkgem.jeesite.modules.process.entity.ApproachExamination;
import com.thinkgem.jeesite.modules.process.entity.Task;
import com.thinkgem.jeesite.modules.process.service.ApproachExaminationService;
import com.thinkgem.jeesite.modules.process.service.PreorderService;
import com.thinkgem.jeesite.modules.process.service.ProcessIventoryService;
import com.thinkgem.jeesite.modules.process.service.TankService;
import com.thinkgem.jeesite.modules.process.service.TaskService;

/**
 * 进场箱检Controller
 * @author 俞超
 * @version 2014-12-17
 */
@Controller
@RequestMapping(value = "${adminPath}/process/assignment")
public class AssignmentController extends BaseController {

	@Autowired
	private ApproachExaminationService approachExaminationService;
	
	@Autowired
	private PreorderService preorderService;
	
	@Resource
	private TankService tankService;
	
	@Resource
	private ClientService clientService;
	
	@Resource
	private TaskService taskService;
	
	@Resource
	private ProcessIventoryService processIventoryService;
	
	@ModelAttribute
	public ApproachExamination get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return approachExaminationService.get(id);
		}else{
			return new ApproachExamination();
		}
	}
	
	/**
	 * 任务分配列表
	 * @param approachExamination
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"list", ""})
	public String list(ApproachExamination approachExamination, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<ApproachExamination> page = approachExaminationService.find(new Page<ApproachExamination>(request, response), approachExamination); 
        model.addAttribute("page", page);
		return "modules/" + "process/assignment/assignmentList";
	}
	
	/**
	 * 查看箱检图片信息
	 * @param approachExaminationId
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/{approachExaminationId}/pictureList")
	public String viewExaminePictureList(@PathVariable String approachExaminationId,Model model){
		ApproachExamination approachExamination = approachExaminationService.get(approachExaminationId);
		model.addAttribute("approachExamination", approachExamination);
		return "modules/" + "process/assignment/approachExaminiationPictureList";
	}
	
	/**
	 * 分配任务界面
	 * @param approachExaminationId
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/{approachExaminationId}/process")
	public String setTankProcess(@PathVariable String approachExaminationId,Model model){
		ApproachExamination approachExamination = approachExaminationService.get(approachExaminationId);
		model.addAttribute("approachExamination", approachExamination);
		List<Task> allTask = taskService.findTaskListExcepApproachAndDepart();
		Collections.sort(allTask);
		model.addAttribute("taskList", allTask);
		List<ApproachAim> approachAimList = approachExamination.getPreorder().getApproachAimList();
		List<Task> presupposedTaskList = taskService.findTaskListByApproachAimList(approachAimList);
		Collections.sort(presupposedTaskList);
		model.addAttribute("presupposedTaskList", presupposedTaskList);
		model.addAttribute("presupposedTaskIds", Collections3.extractToString(presupposedTaskList, "id", ","));
		return "modules/" + "process/assignment/assignmentForm";
	}
	

	/**
	 * 保存任务表
	 * @param approachExamination
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "save",method=RequestMethod.POST)
	public String save(ApproachExamination approachExamination,HttpServletRequest request,@RequestParam(required=false)Date plannedDepartTime) {
		String taskOrder = request.getParameter("list1SortOrder");
		String[] taskIdArray = taskOrder.split(",");
		processIventoryService.saveProcess(approachExamination.getId(), taskIdArray,plannedDepartTime);
		return "redirect:"+Global.getAdminPath()+"/process/assignment";
	}

}
