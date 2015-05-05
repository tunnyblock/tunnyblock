package com.thinkgem.jeesite.modules.emergency.service;

import java.util.Date;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.persistence.Parameter;
import com.thinkgem.jeesite.common.service.BaseService;
import com.thinkgem.jeesite.modules.emergency.dao.EmergencyMaintenanceDao;
import com.thinkgem.jeesite.modules.emergency.entity.EmergencyMaintenance;
import com.thinkgem.jeesite.modules.process.dao.ProcessDao;
import com.thinkgem.jeesite.modules.process.dao.ProcessIventoryDao;
import com.thinkgem.jeesite.modules.process.dao.TankDao;
import com.thinkgem.jeesite.modules.process.dao.TankOperationLogDao;
import com.thinkgem.jeesite.modules.process.dao.TaskDao;
import com.thinkgem.jeesite.modules.process.entity.Process;
import com.thinkgem.jeesite.modules.process.entity.ProcessIventory;
import com.thinkgem.jeesite.modules.process.entity.Tank;
import com.thinkgem.jeesite.modules.process.entity.TankOperationLog;
import com.thinkgem.jeesite.modules.process.entity.Task;
import com.thinkgem.jeesite.modules.sys.dao.UserDao;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 应急维修Service
 * @author 俞超
 * @version 2015-02-07
 */
@Service
@Transactional(readOnly=true)
public class EmergencyMaintenanceService extends BaseService {

	@Autowired
	private EmergencyMaintenanceDao emergencyMaintenanceDao;
	
	@Autowired
	private ProcessIventoryDao processIventoryDao;
	
	@Autowired
	private TaskDao taskDao;
	
	@Autowired
	private TankDao tankDao;
	
	@Autowired
	private ProcessDao processDao;
	
	@Autowired
	private TankOperationLogDao tankOperationLogDao;
	
	@Autowired
	private UserDao userDao;
	
	public EmergencyMaintenance get(String id) {
		return emergencyMaintenanceDao.get(id);
	}
	
	public Page<EmergencyMaintenance> find(Page<EmergencyMaintenance> page, EmergencyMaintenance emergencyMaintenance) {
		DetachedCriteria dc = emergencyMaintenanceDao.createDetachedCriteria();
		dc.addOrder(Order.desc("id"));
		return emergencyMaintenanceDao.find(page, dc);
	}
	
	@Transactional(readOnly=false)
	public void save(EmergencyMaintenance emergencyMaintenance) {
		emergencyMaintenanceDao.save(emergencyMaintenance);
	}
	
	@Transactional(readOnly=false)
	public void generateEmergencyMaintenance(EmergencyMaintenance emergencyMaintenance){
		//查询箱子
		Tank tank = tankDao.getByHql("from Tank tank where tank.tankCode=:p1",new Parameter(emergencyMaintenance.getTankCode()));
		if(tank==null){
			tank = new Tank();
			tank.setTankCode(emergencyMaintenance.getTankCode());
			tank.setClient(emergencyMaintenance.getClient());
			tankDao.save(tank);
		}else{
			emergencyMaintenance.setTank(tank);
		}
		
		
		//生成应急维修单
		emergencyMaintenanceDao.save(emergencyMaintenance);
		
		//生成流程清单
		ProcessIventory processIventory = new ProcessIventory();
		processIventory.setEmergencyMaintenance(emergencyMaintenance);
		processIventory.setCreateTime(new Date());
		processIventory.setOperator(UserUtils.getUser());
		processIventory.setTank(tank);
		processIventoryDao.save(processIventory);
		
		//生成流程
		Process process = new Process();
		process.setProcessIventory(processIventory);
		Task task = taskDao.getByHql("from Task t where t.taskName=:p1", new Parameter("应急维修"));
		process.setTask(task);
		process.setStartTime(new Date());
		process.setStartUser(UserUtils.getUser());
		process.setEndUser(emergencyMaintenance.getAssignToUser());
		process.setState(Process.STATE_PROCESSING);
		processDao.save(process);
		
		//更新流程清单
		processIventory.setCurrentProcess(process);
		processIventoryDao.save(processIventory);
		
		//生成箱子操作日志
		TankOperationLog tankOperationLog= new TankOperationLog();
		tankOperationLog.setProcessIventory(processIventory);
		tankOperationLog.setTank(processIventory.getTank());
		User endUser = userDao.get(emergencyMaintenance.getAssignToUser().getId());
		tankOperationLog.setOperationLog(UserUtils.getUser().getName()+"启动"+process.getTask().getTaskName()+"任务，分配给"+endUser.getName()+"完成");
		tankOperationLog.setOperator(UserUtils.getUser());
		tankOperationLog.setOperationTime(new Date());
		tankOperationLogDao.save(tankOperationLog);
	}
	
	@Transactional(readOnly=false)
	public void delete(String id) {
		emergencyMaintenanceDao.deleteById(id);
	}
	
}
