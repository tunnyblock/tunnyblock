package com.thinkgem.jeesite.modules.process.service;

import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.persistence.Parameter;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.common.utils.Collections3;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.modules.process.dao.ProcessDao;
import com.thinkgem.jeesite.modules.process.dao.ProcessIventoryDao;
import com.thinkgem.jeesite.modules.process.entity.ApproachExamination;
import com.thinkgem.jeesite.modules.process.entity.DynamicMessage;
import com.thinkgem.jeesite.modules.process.entity.Preorder;
import com.thinkgem.jeesite.modules.process.entity.Process;
import com.thinkgem.jeesite.modules.process.entity.ProcessIventory;
import com.thinkgem.jeesite.modules.process.entity.Tank;
import com.thinkgem.jeesite.modules.process.entity.TankChangeHistory;
import com.thinkgem.jeesite.modules.process.entity.TankOperationLog;
import com.thinkgem.jeesite.modules.process.entity.Task;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.WashInfo;
import com.thinkgem.jeesite.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.thinkgem.jeesite.modules.sys.service.SystemService;

/**
 * 流程清单Service
 * @author 俞超
 * @version 2014-12-17
 */
@Service
@Transactional(readOnly=true)
public class ProcessIventoryService extends BaseService {

	@Autowired
	private ProcessIventoryDao processIventoryDao;
	
	@Autowired
	private ApproachExaminationService approachExaminationService;
	
	@Autowired
	private TaskService taskService;
	
	@Autowired
	private ProcessService processService;
	
	@Autowired
	private SystemService systemService;
	
	@Autowired
	private TankOperationLogService tankOperationLogService;
	
	@Autowired
	private DynamicMessageService dynamicMessageService;
	
	@Autowired
	private TankChangeHistoryService tankChangeHistoryService;
	
	@Autowired
	private ProcessDao processDao;
	
	@Autowired
	private TankService tankService;
	
	public ProcessIventory get(String id) {
		return processIventoryDao.get(id);
	}
	
	public Page<ProcessIventory> find(Page<ProcessIventory> page, ProcessIventory processIventory) {
		DetachedCriteria dc = processIventoryDao.createDetachedCriteria();
		dc.add(Restrictions.or(
				Restrictions.ne("isEnded", ProcessIventory.YES),
				Restrictions.isNull("isEnded")
		));
		dc.addOrder(Order.asc("plannedDepartTime"));
		return processIventoryDao.find(page, dc);
	}
	
	/**
	 * 获取已结束流程，未确认账单的流程清单
	 * @param page
	 * @param processIventory
	 * @return
	 */
	public Page<ProcessIventory> findEndProcessIventories(Page<ProcessIventory> page, ProcessIventory processIventory) {
		DetachedCriteria dc = processIventoryDao.createDetachedCriteria();
		dc.add(Restrictions.eq("isEnded", ProcessIventory.YES));
		dc.add(Restrictions.eq("isChargeSubmitted", ProcessIventory.NO));
		dc.addOrder(Order.asc("plannedDepartTime"));
		return processIventoryDao.find(page, dc);
	}
	
	@Transactional(readOnly=false)
	public void save(ProcessIventory processIventory) {
		processIventoryDao.save(processIventory);
	}
	
	@Transactional(readOnly=false)
	public void delete(String id) {
		processIventoryDao.deleteById(id);
	}
	
	@Transactional(readOnly=false)
	public void updateProcessIventoryState(ProcessIventory processIventory,String state){
		processIventoryDao.update("update "+ProcessIventory.class.getSimpleName()+" set isEnded='" + state + "' where id = :p1", new Parameter(processIventory.getId()));
	}
	
	public List<ProcessIventory> findProcessIventoryListByUserId(String userId){
		DetachedCriteria dc = processIventoryDao.createDetachedCriteria();
		return processIventoryDao.find(dc);
	}
	
	/**
	 * 根据箱检信息及任务安排列表保存流程
	 * @param approachExaminationId
	 * @param taskIdArray
	 */
	@SuppressWarnings("unchecked")
	@Transactional(readOnly=false)
	public void saveProcess(String approachExaminationId,String[] taskIdArray,Date plannedDepartTime){
		ProcessIventory processIventory = new ProcessIventory();
		processIventory.setPlannedDepartTime(plannedDepartTime);
		ApproachExamination approachExamination = approachExaminationService.get(approachExaminationId);
		processIventory.setOperator(this.getCurrentUser());
		processIventory.setApproachExamination(approachExamination);
		processIventory.setPreorder(approachExamination.getPreorder());
		processIventory.setTank(approachExamination.getTank());
		processIventory.setName("任务清单"+DateUtils.formatDate(new Date(), "yyyyMMdd"));
		processIventory.setCreateTime(new Date());
		processIventoryDao.save(processIventory);
		List<Task> taskList = taskService.findTaskListByIds(taskIdArray);
		//取出任务后仍需要按照前台设置的顺序进行排序
		for(int i=0;i<taskIdArray.length;i++){
			String id = taskIdArray[i];
			for(Task task:taskList){
				if(id.equals(task.getId())){
					task.setSort(i);
					break;
				}
			}
		}
		Collections.sort(taskList);
		//倒置存储流程，方便建立下一个流程
		Process nextProcess = null;
		for(int i=taskList.size()-1;i>=0;i--){
			Process process  = new Process();
			process.setProcessIventory(processIventory);
			process.setNextProcess(nextProcess);
			Task task = taskList.get(i);
			process.setTask(task);
			process.setCompanyChargeInfo(task.getCompanyChargeInfo());
			process.setName(task.getTaskName()+"流程");
			process.setSort(i+1);
			//进场任务已经完成
			if(i==0&&"进场".equals(task.getTaskName())){
				process.setStartTime(approachExamination.getCreatedTime());
				process.setEndUser(approachExamination.getCreateUser());
				process.setRemarks(approachExamination.getRemarks());
				process.setState(com.thinkgem.jeesite.modules.process.entity.Process.STATE_END);
				process.setEndTime(new Date());
			}
			
			
			//对应收费信息
			process.setCompanyChargeInfo(task.getCompanyChargeInfo());
			
			//清洗任务，需要添加前装货物品的收费信息
			if("清洗".equals(task.getTaskName())){
				WashInfo washInfo = approachExamination.getPreorder().getCleanGoods();
				if(washInfo!=null){
					process.setGoodsCleanCharge(washInfo.getReferenceCleanPrice());
					process.setOtherAdditionalCharge(washInfo.getAdditionalCleanPrice());
				}
			}
			
			processService.save(process);
			nextProcess = process;
		}
		
		//预录单生成日志
		Preorder preorder = approachExamination.getPreorder();
		TankOperationLog tankOperationLog= new TankOperationLog();
		tankOperationLog.setProcessIventory(processIventory);
		tankOperationLog.setTank(approachExamination.getTank());
		tankOperationLog.setOperationLog(preorder.getCreateUser().getName()+"完成预录单提交");
		tankOperationLog.setOperator(preorder.getCreateUser());
		tankOperationLog.setOperationTime(preorder.getCreateTime());
		tankOperationLogService.save(tankOperationLog);
		
		//箱检日志
		tankOperationLog= new TankOperationLog();
		tankOperationLog.setProcessIventory(processIventory);
		tankOperationLog.setTank(approachExamination.getTank());
		tankOperationLog.setOperationLog(approachExamination.getCreateUser().getName()+"完成箱检");
		tankOperationLog.setOperator(approachExamination.getCreateUser());
		tankOperationLog.setOperationTime(approachExamination.getCreatedTime());
		tankOperationLogService.save(tankOperationLog);
		
		//标记为流程已设置
		approachExamination.setIsProcessSetted(ApproachExamination.YES);
		approachExamination.setProcessSettedTime(new Date());
		approachExaminationService.save(approachExamination);
	}
	
	/**
	 * 重新调整流程清单
	 * 未开始的流程可以被删除，重新调整顺序，出场流程不能被改变,可调整的流程则重新生成
	 * @param processIventory
	 * @param fixedProcessIds
	 * @param taskIdArray
	 */
	@SuppressWarnings("unchecked")
	@Transactional(readOnly=false)
	public void adjustProcessIventory(ProcessIventory processIventory,String[] fixedProcessIds,String[] taskIdArray){
		//删除固定流程外的其他流程
		processService.deleteProcess(processIventory.getId(), fixedProcessIds);
		
		if(taskIdArray!=null&&taskIdArray.length>0){
			//根据Task创建的Process
			int fixedProcessIdsLength = fixedProcessIds.length;
			Process lastFixedProcess = processService.get(fixedProcessIds[fixedProcessIdsLength-1]);
			Integer startSort = lastFixedProcess.getSort();
			
			List<Task> taskList = taskService.findTaskListByIds(taskIdArray);
			//取出任务后仍需要按照前台设置的顺序进行排序
			for(int i=0;i<taskIdArray.length;i++){
				String id = taskIdArray[i];
				for(Task task:taskList){
					if(id.equals(task.getId())){
						task.setSort(i+startSort+1);
						break;
					}
				}
			}
			Collections.sort(taskList);
			
			
			//倒置存储流程，方便建立下一个流程
			Process nextProcess = null;
			Process lastFixProcessNextProcess = null;
			int taskIdArrayLength = taskIdArray.length;
			for(int i = taskIdArrayLength-1;i>=0;i--){
				Process process = new Process();
				process.setProcessIventory(processIventory);
				process.setNextProcess(nextProcess);
				Task task = taskList.get(i);
				process.setTask(task);
				process.setCompanyChargeInfo(task.getCompanyChargeInfo());
				process.setName(task.getTaskName()+"流程");
				process.setSort(fixedProcessIds.length+i+1);
				
				processService.save(process);
				nextProcess = process;
				
				if(i==0){
					lastFixProcessNextProcess = process;
				}
			}
			
			//更新最后一个不变流程的下一个流程链接
			lastFixedProcess.setNextProcess(lastFixProcessNextProcess);
			processService.save(lastFixProcessNextProcess);
		}
	}
	
	/**
	 * 虚拟出场
	 * 流程清单里不能有还正在处理中的流程，否则进行虚拟出场动作
	 * 当箱号或者箱主有一个发生变更时，就会触发虚拟出场动作
	 * 1.生成一条新的箱子记录（父箱子为之前的箱子）
	 * 2.生成一条箱子变更历史记录（便于后续追溯）
	 * 3.箱子流程清单未完成的都删除，同时添加一条已完成的出场流程
	 * 4.新建一个流程清单，默认为暂存（只有进场和出场，进场已完成）
	 * 5.生成箱子操作日志
	 * @param processIventory
	 */
	@Transactional(readOnly = false)
	public void virtualDepart(ProcessIventory processIventory,Tank tank){
		//1.生成一条新的箱子记录（父箱子为之前的箱子）
		Tank oldTank = processIventory.getTank();
		tank.setParentTank(oldTank);
		tank.setParentIds((oldTank.getParentIds()==null?"":oldTank.getParentIds())+oldTank.getId()+",");
		tank.setTankType(oldTank.getTankType());
		tank.setTankCapacity(oldTank.getTankCapacity());
		tank.setTankWeight(oldTank.getTankWeight());
		tank.setManufacturedTime(oldTank.getManufacturedTime());
		tank.setLastAnnualInspectTime(oldTank.getLastAnnualInspectTime());
		tank.setNextAnnualInspectTime(oldTank.getNextAnnualInspectTime());
		tank.setAnnualInspectComments(oldTank.getAnnualInspectComments());
		tank.setChangeDate(new Date());
		tank.setChangeUser(getCurrentUser());
		tankService.save(tank);
		
		//2.生成一条箱子变更历史记录（便于后续追溯）
		TankChangeHistory tankChangeHistory = new TankChangeHistory();
		tankChangeHistory.setOldTank(oldTank);
		tankChangeHistory.setNewTank(tank);
		tankChangeHistory.setUpdateTime(new Date());
		tankChangeHistory.setUpdateUser(getCurrentUser());
		tankChangeHistoryService.save(tankChangeHistory);
		
		//3.箱子流程清单未完成的都删除，添加一条出场记录
		List<Process> fixsProcessList = processDao.find("from Process process where process.processIventory.id=:p1 and process.state=:p2", new Parameter(processIventory.getId(),Process.STATE_END));
		@SuppressWarnings("unchecked")
		List<String> fixedProcessList = Collections3.extractToList(fixsProcessList, "id");
		processService.deleteProcess(processIventory.getId(), fixedProcessList);
		Process process = new Process();
		process.setProcessIventory(processIventory);
		process.setSort(fixsProcessList.size()+1);
		process.setState(Process.STATE_END);
		process.setIsVirtual(Process.YES);
		process.setStartTime(new Date());
		process.setEndTime(new Date());
		process.setStartUser(getCurrentUser());
		process.setEndUser(getCurrentUser());
		Task task = taskService.findTaskByTaskName("出场");
		process.setName(task.getTaskName()+"流程");
		process.setTask(task);
		processService.save(process);
		//流程清单修改为结束和结束时间
		processIventory.setIsEnded(ProcessIventory.YES);
		processIventory.setEndTime(new Date());
		processIventoryDao.save(processIventory);
		
		//4.新建一个流程清单，默认为暂存（只有进场和出场，进场已完成）
		ProcessIventory newProcessIventory = new ProcessIventory();
		newProcessIventory.setTank(tank);
		newProcessIventory.setName("任务清单"+DateUtils.formatDate(new Date(), "yyyyMMdd"));
		newProcessIventory.setCreateTime(new Date());
		newProcessIventory.setOperator(getCurrentUser());
		this.save(newProcessIventory);
		
		Task approachTask = taskService.findTaskByTaskName("进场");
		//已完成进场
		Process approachProcess = new Process();
		approachProcess.setProcessIventory(newProcessIventory);
		approachProcess.setSort(1);
		approachProcess.setState(Process.STATE_END);
		approachProcess.setIsVirtual(Process.YES);
		approachProcess.setStartTime(new Date());
		approachProcess.setStartUser(getCurrentUser());
		approachProcess.setEndTime(new Date());
		approachProcess.setEndUser(getCurrentUser());
		approachProcess.setTask(approachTask);
		approachProcess.setName(approachTask.getTaskName()+"流程");
		processService.save(approachProcess);
		//未开始出场
		Process departProcess = new Process();
		departProcess.setProcessIventory(newProcessIventory);
		departProcess.setSort(2);
		departProcess.setState(Process.STATE_NOTSTART);
		departProcess.setTask(task);
		departProcess.setName(task.getTaskName()+"流程");
		processService.save(departProcess);
		
		//5.生成箱子操作日志
		TankOperationLog tankOperationLog = new TankOperationLog();
		tankOperationLog.setProcessIventory(processIventory);
		tankOperationLog.setTank(oldTank);
		StringBuilder operationLog= new StringBuilder("完成虚拟出场 <br/>");
		if(!oldTank.getClient().getId().equals(tank.getClient().getId())){
			operationLog.append(" 箱主由"+oldTank.getClient().getCompanyChineseName()+" 变更为 "+tank.getClient().getCompanyChineseName()+"<br/>");
		}
		
		if(!oldTank.getTankCode().equals(tank.getTankCode())){
			operationLog.append(" 箱号由"+oldTank.getTankCode()+" 变更为 "+tank.getTankCode()+"<br/>");
		}
		tankOperationLog.setOperationLog(operationLog.toString());
		tankOperationLog.setOperator(getCurrentUser());
		tankOperationLog.setOperationTime(new Date());
		tankOperationLogService.save(tankOperationLog);
	}
	
	/**
	 * 批量启动某个流程
	 * @param processIventoryIds 流程清单编号列表
	 * @param taskName 任务名称
	 * @param user 指定完成用户
	 * 完成端由IOS客户端来触发，将流程状态变更，同时产生动态消息和操作日志
	 */
	@Transactional(readOnly = false)
	public void batchStartProcess(String[] processIventoryIds,String taskName,User user){
		DetachedCriteria dc = processIventoryDao.createDetachedCriteria();
		dc.add(Restrictions.in("id", processIventoryIds));
		List<ProcessIventory> processIventoryList = processIventoryDao.find(dc);
		User currentUser = this.getCurrentUser();
		for(ProcessIventory processIventory:processIventoryList){
			List<Process> processList = processIventory.getProcessList();
			for(Process process:processList){
				if(taskName.equals(process.getTask().getTaskName())){
					process.setStartTime(new Date());
					process.setState(Process.STATE_PROCESSING);
					process.setStartUser(currentUser);
					process.setEndUser(user);
					processService.save(process);
					
					//生成动态消息
					DynamicMessage dynamicMessage = new DynamicMessage();
					dynamicMessage.setFromUser(getCurrentUser());
					dynamicMessage.setToUser(user);
					dynamicMessage.setBussinessId(process.getId());
					dynamicMessage.setMessageContent(currentUser.getName()+"将"+taskName+"任务 分配给了"+user.getName());
					dynamicMessage.setGenerateTime(new Date());
					
					//生成箱子操作日志
					TankOperationLog tankOperationLog= new TankOperationLog();
					tankOperationLog.setProcessIventory(processIventory);
					tankOperationLog.setTank(processIventory.getTank());
					tankOperationLog.setOperationLog("启动"+taskName+"任务，分配给"+user.getName()+"完成");
					tankOperationLog.setOperator(currentUser);
					tankOperationLog.setOperationTime(new Date());
					tankOperationLogService.save(tankOperationLog);
					break;
				}
			}
		}
	}
	
	/**
	 * 批量设置出场时间
	 * @param processIventoryIds
	 * @param plannedDepartTime
	 */
	@Transactional(readOnly = false)
	public void batchSetPlannedDepartTime(String[] processIventoryIds,Date plannedDepartTime){
		processDao.update("update ProcessIventory p set p.plannedDepartTime=:p1 where p.id in:p2 ",new Parameter(plannedDepartTime,processIventoryIds));
	}
	
	
	/**
	 * 获取当前登录用户
	 * @return
	 */
	protected User getCurrentUser(){
		User user = null;
		Subject subject = SecurityUtils.getSubject();
		Principal principal = (Principal)subject.getPrincipal();
		if (principal!=null){
			user = systemService.getUser(principal.getId());
		}
		return user;
	}
	
}
