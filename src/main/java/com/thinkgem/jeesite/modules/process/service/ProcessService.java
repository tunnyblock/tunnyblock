package com.thinkgem.jeesite.modules.process.service;

import java.util.Date;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.persistence.Parameter;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.modules.process.dao.ProcessDao;
import com.thinkgem.jeesite.modules.process.dao.ProcessIventoryDao;
import com.thinkgem.jeesite.modules.process.entity.DepartExamination;
import com.thinkgem.jeesite.modules.process.entity.DynamicMessage;
import com.thinkgem.jeesite.modules.process.entity.Process;
import com.thinkgem.jeesite.modules.process.entity.ProcessIventory;
import com.thinkgem.jeesite.modules.process.entity.TankOperationLog;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;

/**
 * 流程Service
 * @author 俞超
 * @version 2014-12-17
 */
@Service
@Transactional(readOnly=true)
public class ProcessService extends BaseService {

	@Autowired
	private ProcessDao processDao;
	
	@Autowired
	private DepartExaminationService departExaminationService;
	
	@Autowired
	private TankOperationLogService tankOperationLogService;
	
	@Autowired
	private DynamicMessageService dynamicMessageService;
	
	@Autowired
	private ProcessIventoryDao processIventoryDao;
	
	@Autowired
	private SystemService systemService;
	
	public Process get(String id) {
		return processDao.get(id);
	}
	
	public List<Process> getProcessListByProcessIventoryId(String processIventoryId){
		DetachedCriteria dc = processDao.createDetachedCriteria();
		dc.createAlias("processIventory", processIventoryId);
		dc.add(Restrictions.eq("processIventory.id", processIventoryId));
		dc.addOrder(Order.asc("sort"));
		return processDao.find(dc);
	}
	
	public Page<Process> find(Page<Process> page, Process process) {
		DetachedCriteria dc = processDao.createDetachedCriteria();
		dc.addOrder(Order.desc("id"));
		return processDao.find(page, dc);
	}
	
	@Transactional(readOnly=false)
	public void save(Process process) {
		processDao.save(process);
	}
	
	@Transactional(readOnly=false)
	public void delete(String id) {
		processDao.deleteById(id);
	}
	
	/**
	 * 开始流程
	 */
	@Transactional(readOnly=false)
	public void startProcess(Process process,User startUser,User endUser){
		processDao.update("update "+Process.class.getSimpleName()+" set state= :p1,startUser.id= :p2,startTime= :p3,endUser.id= :p4,deadline=:p5 where id = :p6 ", new Parameter(Process.STATE_PROCESSING,startUser.getId(),new Date(),endUser.getId(),process.getDeadline(),process.getId()));
		
		//发送动态消息
		endUser = systemService.getUser(endUser.getId());
		DynamicMessage dynamicMessage = new DynamicMessage();
		dynamicMessage.setFromUser(startUser);
		dynamicMessage.setToUser(endUser);
		dynamicMessage.setBussinessId(process.getId());
		dynamicMessage.setGenerateTime(new Date());
		process = processDao.get(process.getId());
		dynamicMessage.setMessageContent(startUser.getName()+"分配"+process.getTask().getTaskName() +"任务给"+endUser.getName()+" 箱号 【"+process.getProcessIventory().getTank().getTankCode()+"】");
		dynamicMessageService.save(dynamicMessage);
		
		//生成箱子操作日志
		ProcessIventory processIventory = process.getProcessIventory();
		TankOperationLog tankOperationLog= new TankOperationLog();
		tankOperationLog.setProcessIventory(processIventory);
		tankOperationLog.setTank(processIventory.getTank());
		tankOperationLog.setOperationLog(startUser.getName()+"启动"+process.getTask().getTaskName()+"任务，分配给"+endUser.getName()+"完成");
		tankOperationLog.setOperator(startUser);
		tankOperationLog.setOperationTime(new Date());
		tankOperationLogService.save(tankOperationLog);
		
		//设置当前流程
		processIventory.setCurrentProcess(process);
		processIventoryDao.save(processIventory);
		
		//启动出场流程，同时生成出场清单
		if("出场".equals(process.getTask().getTaskName())){
			DepartExamination departExamination = new DepartExamination();
			departExamination.setProcessIventory(processIventory);
			departExamination.setDepartProcess(process);
			departExamination.setTank(processIventory.getTank());
			departExamination.setCreatedTime(new Date());
			departExamination.setPlannedDepartTime(processIventory.getPlannedDepartTime());
			departExaminationService.save(departExamination);
		}
	}
	
	/**
	 * 批量启动流程
	 * @param ids
	 * @param startUser
	 * @param endUser
	 */
	@Transactional(readOnly=false)
	public void batchStartProcess(String[] ids,User startUser,User endUser){
		processDao.update("update "+Process.class.getSimpleName()+" set state= :p1,startUser.id= :p2,startTime= :p3,endUser.id= :p4 where id in :p5 ", new Parameter(Process.STATE_END,startUser.getId(),new Date(),endUser.getId(),ids));
		endUser = systemService.getUser(endUser.getId());
		for(String id:ids){
			//发送动态消息
			Process process = processDao.get(id);
			DynamicMessage dynamicMessage = new DynamicMessage();
			dynamicMessage.setFromUser(startUser);
			dynamicMessage.setToUser(endUser);
			dynamicMessage.setBussinessId(process.getId());
			dynamicMessage.setGenerateTime(new Date());
			dynamicMessage.setMessageContent(startUser.getName()+"分配"+process.getTask().getTaskName() +"任务给"+endUser.getName()+" 箱号 【"+process.getProcessIventory().getTank().getTankCode()+"】");
			dynamicMessageService.save(dynamicMessage);
			
			//生成箱子操作日志
			ProcessIventory processIventory = process.getProcessIventory();
			TankOperationLog tankOperationLog= new TankOperationLog();
			tankOperationLog.setProcessIventory(processIventory);
			tankOperationLog.setTank(processIventory.getTank());
			tankOperationLog.setOperationLog(startUser.getName()+"启动"+process.getTask().getTaskName()+"任务，分配给"+endUser.getName()+"完成");
			tankOperationLog.setOperator(startUser);
			tankOperationLog.setOperationTime(new Date());
			tankOperationLogService.save(tankOperationLog);
			
			//清空当前流程
			processIventory.setCurrentProcess(null);
			processIventoryDao.save(processIventory);
		}
	}
	
	/**
	 * 结束流程，供IOS客户端调用
	 * @param id
	 */
	@Transactional(readOnly=false)
	public void endProcess(String id){
		processDao.update("update "+Process.class.getSimpleName()+" set state= :p1,endTime= :p2 where id = :p3 ", new Parameter(Process.STATE_END,new Date(),id));
		//发送动态消息
		Process process = processDao.get(id);
		DynamicMessage dynamicMessage = new DynamicMessage();
		dynamicMessage.setFromUser(process.getEndUser());
		dynamicMessage.setToUser(process.getStartUser());
		dynamicMessage.setBussinessId(process.getId());
		dynamicMessage.setGenerateTime(new Date());
		dynamicMessage.setMessageContent(process.getEndUser().getName()+"完成"+process.getTask().getTaskName() +"任务"+" 箱号 【"+process.getProcessIventory().getTank().getTankCode()+"】");
		dynamicMessageService.save(dynamicMessage);
		
		//生成箱子操作日志
		ProcessIventory processIventory = process.getProcessIventory();
		TankOperationLog tankOperationLog= new TankOperationLog();
		tankOperationLog.setProcessIventory(processIventory);
		tankOperationLog.setTank(processIventory.getTank());
		tankOperationLog.setOperationLog(process.getEndUser().getName()+"完成"+process.getTask().getTaskName()+"任务");
		tankOperationLog.setOperator(process.getEndUser());
		tankOperationLog.setOperationTime(new Date());
		tankOperationLogService.save(tankOperationLog);
		
		//清空当前流程
		processIventory.setCurrentProcess(null);
		
		//结束出场流程或者应急维修，同时结束整个流程清单
		if("出场".equals(process.getTask().getTaskName())||"应急维修".equals(process.getTask().getTaskName())){
			processIventory.setIsEnded(ProcessIventory.YES);
			processIventory.setEndTime(new Date());
		}
		processIventoryDao.save(processIventory);
	}
	
	@Transactional(readOnly=false)
	public void updateProcessState(Process process,String state){
		processDao.update("update "+Process.class.getSimpleName()+" set state='" + state + "' where id = :p1", new Parameter(process.getId()));
	}
	
	@Transactional(readOnly=false)
	public void deleteProcess(String processIventoryId,String[] fixedProcessIds){
		String hql = "DELETE FROM Process process where process.id not in(:p1) and process.processIventory.id=:p2 ";
		processDao.update(hql, new Parameter(fixedProcessIds,processIventoryId));
	}
	
	@Transactional(readOnly=false)
	public void deleteProcess(String processIventoryId,List<String >fixedProcessList){
		String hql = "DELETE FROM Process process where process.id not in(:p1) and process.processIventory.id=:p2 ";
		processDao.update(hql, new Parameter(fixedProcessList,processIventoryId));
	}
	
}
