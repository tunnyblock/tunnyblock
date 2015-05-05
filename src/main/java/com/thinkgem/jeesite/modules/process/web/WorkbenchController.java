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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.charge.entity.ChargeInfo;
import com.thinkgem.jeesite.modules.charge.service.ChargeInfoService;
import com.thinkgem.jeesite.modules.client.service.ClientService;
import com.thinkgem.jeesite.modules.comment.entity.Affix;
import com.thinkgem.jeesite.modules.comment.entity.Comment;
import com.thinkgem.jeesite.modules.comment.service.CommentService;
import com.thinkgem.jeesite.modules.process.entity.Process;
import com.thinkgem.jeesite.modules.process.entity.ProcessIventory;
import com.thinkgem.jeesite.modules.process.entity.Tank;
import com.thinkgem.jeesite.modules.process.entity.TankOperationLog;
import com.thinkgem.jeesite.modules.process.entity.Task;
import com.thinkgem.jeesite.modules.process.service.ProcessIventoryService;
import com.thinkgem.jeesite.modules.process.service.ProcessService;
import com.thinkgem.jeesite.modules.process.service.TankOperationLogService;
import com.thinkgem.jeesite.modules.process.service.TaskService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;

/**
 * 我的工作台，区分客户和门卫
 * @author 俞超
 * @version 2014-12-17
 */
@Controller
@RequestMapping(value = "${adminPath}/process/workbench")
public class WorkbenchController extends BaseController {
	
	@Autowired
	private ProcessIventoryService processIventoryService;
	
	@Autowired
	private ProcessService processService;
	
	@Autowired
	private TankOperationLogService tankOperationLogService;
	
	@Autowired
	private SystemService systemService;
	
	@Resource
	private ClientService clientService;
	
	@Resource
	private TaskService taskService;
	
	@Resource
	private CommentService commentService;
	
	@Resource
	private ChargeInfoService chargeInfoService;
	
	/**
	 * 客服我的工作台
	 * @param processIventory
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/customService")
	public String customServiceWorkbench(ProcessIventory processIventory,HttpServletRequest request, HttpServletResponse response, Model model){
		Page<ProcessIventory> page = processIventoryService.find(new Page<ProcessIventory>(request, response), processIventory); 
        model.addAttribute("page", page);
        model.addAttribute("userList",systemService.getAllTechnologyOfficeUsers());
        model.addAttribute("clientList", JsonMapper.toJsonString(clientService.listAllClients()));
		return "modules/" + "process/workbench/customService";
	}
	
	/**
	 * 批量设置出场时间
	 * @param plannedDepartTime
	 * @param processIventorys
	 * @return
	 */
	@RequestMapping(value = "/customService/batchsetplanneddeparttime")
	public String batchSetPlannedDepartTime(@RequestParam Date plannedDepartTime,@RequestParam String processIventorys){
		processIventoryService.batchSetPlannedDepartTime(processIventorys.split(","), plannedDepartTime);
		return "redirect:"+Global.getAdminPath()+"/process/workbench/customService";
	}
	
	/**
	 * 箱号或者箱主变更，虚拟出场
	 * @param processIventoryId
	 * @param tank
	 * @return
	 */
	@RequestMapping(value = "/customService/virtualDepart")
	public String virtualDepart(@RequestParam String processIventoryId,Tank tank){
		processIventoryService.virtualDepart(processIventoryService.get(processIventoryId), tank);
		return "redirect:"+Global.getAdminPath()+"/process/workbench/customService";
	}
	
	/**
	 * 重新设定流程
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/customService/reassignprocess/{processIventoryId}")
	public String reAssignProcess(@PathVariable String processIventoryId, Model model){
		List<Task> allTask = taskService.findTaskListExcepApproachAndDepart();
		Collections.sort(allTask);
		model.addAttribute("taskList", allTask);
		model.addAttribute("processIventory", processIventoryService.get(processIventoryId));
		return "modules/" + "process/workbench/reAssignmentForm";
	}
	
	/**
	 * 重新设定流程
	 * @param processIventoryId
	 * @param fixedProcessIds
	 * @param taskIdArray
	 * @return
	 */
	@RequestMapping(value = "/customService/reassignprocess/save")
	public String reAssignProcessSave(
	@RequestParam String  processIventoryId,
	@RequestParam(required=false,value="fixedProcessId")String[] fixedProcessIds,
	@RequestParam(required=false,value="taskId")String[] taskIdArray){
		processIventoryService.adjustProcessIventory(processIventoryService.get(processIventoryId),fixedProcessIds,taskIdArray);
		return "redirect:"+Global.getAdminPath()+"/process/workbench/customService";
	}
	
	/**
	 * 启动流程
	 * @param process
	 * @return
	 */
	@RequestMapping(value="/customService/startprocess")
	public String startProcess(Process process){
		processService.startProcess(process, getCurrentUser(), process.getEndUser());
		return "redirect:"+Global.getAdminPath()+"/process/workbench/customService";
	}
	
	/**
	 * 结束流程
	 * @param processId
	 * @return
	 */
	@RequestMapping(value="/customService/endprocess/{processId}")
	public String endProcess(@PathVariable String processId){
		processService.endProcess(processId);
		return "redirect:"+Global.getAdminPath()+"/process/workbench/customService";
	}
	
	/**
	 * 服务详情
	 * @param processIventoryId
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/customService/{processIventoryId}/serviceDetail")
	public String serviceDetail(@PathVariable String processIventoryId,HttpServletRequest request, HttpServletResponse response, Model model){
		List<TankOperationLog> tankOperationLogList = tankOperationLogService.findTankOperationLogByProcessIventoryId(processIventoryId);
		model.addAttribute("tankOperationLogList", tankOperationLogList);
		List<Process> processList = processService.getProcessListByProcessIventoryId(processIventoryId);
		model.addAttribute("processList", processList);
		return "modules/" + "process/workbench/detail/serviceDetail";
	}
	
	/**
	 * 费用详情
	 * @param processIventoryId
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/customService/{processIventoryId}/chargeDetail")
	public String chargeDetail(@PathVariable String processIventoryId,HttpServletRequest request, HttpServletResponse response, Model model){
		ProcessIventory processIventory = processIventoryService.get(processIventoryId);
		//暂存时间
		Date startTime=null;
		if(processIventory.getApproachExamination()!=null){
			startTime = processIventory.getApproachExamination().getCreatedTime();
		}
		if(processIventory.getEmergencyMaintenance()!=null){
			startTime = processIventory.getEmergencyMaintenance().getGenerateTime();
		}
		if(startTime==null){
			startTime = new Date();
		}
		int intervalDays =(int) ((processIventory.getEndTime().getTime() - startTime.getTime())/1000/60/60/24);
		model.addAttribute("processIventory", processIventory);
		model.addAttribute("intervalDays", intervalDays);
		return "modules/" + "process/workbench/detail/chargeDetail";
	}
	
	/**
	 * 保存用户详情
	 * @param chargeInfo
	 * @return
	 */
	@RequestMapping(value="/customService/charge/save",method=RequestMethod.POST)
	public String saveCharge(ChargeInfo chargeInfo){
		chargeInfoService.saveChargeInfo(chargeInfo);
		return "redirect:"+Global.getAdminPath()+"/process/workbench/customService/charge";
	}
	
	/**
	 * 获取待确认账单列表
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/customService/charge")
	public String charge(ProcessIventory processIventory,HttpServletRequest request, HttpServletResponse response, Model model){
		Page<ProcessIventory> page = processIventoryService.findEndProcessIventories(new Page<ProcessIventory>(request, response), processIventory); 
		model.addAttribute("page", page);
		return "modules/" + "process/workbench/charge";
	}
	
	/**
	 * 评论
	 * @param processId
	 * @return
	 */
	@RequestMapping(value="/customService/{processId}/comments")
	public String commentForm(@PathVariable String processId,Model model){
		Process process = processService.get(processId);
		List<Comment> commentList =  commentService.getCommentsByProcessId(processId);
		model.addAttribute("process", process);
		model.addAttribute("commentList", commentList);
		return "modules/" + "process/workbench/comment/commentForm";
	}
	
	/**
	 * 发表评论
	 * @param affixFiles
	 * @param comment
	 * @return
	 */
	@RequestMapping(value="/customService/{processId}/comments/save",method=RequestMethod.POST)
	public String saveComments(
			@PathVariable String processId,
			@RequestParam(required=false,value="affixFileUrl")String[] affixFileUrls,
			@RequestParam(required=false,value="affixFileName")String[] affixFileNames,
			@RequestParam(required=false,value="affixFileType")String[] affixFileTypes,
			Comment comment){
		comment.setGenerateTime(new Date());
		comment.setGenerateUser(getCurrentUser());
		List<Affix> list = Lists.newArrayList();
		if(affixFileUrls!=null){
			for(int i=0;i<affixFileUrls.length;i++){
				Affix affix = new Affix();
				affix.setGenerateTime(new Date());
				affix.setGenerateUser(getCurrentUser());
				affix.setAffixUrl(affixFileUrls[i]);
				affix.setAffixName(affixFileNames[i]);
				affix.setType(affixFileTypes[i]);
				list.add(affix);
			}
		}
		comment.setAffixList(list);
		commentService.saveComments(comment);
		return "redirect:"+Global.getAdminPath()+"/process/workbench/customService/"+processId+"/comments";
	}

}
