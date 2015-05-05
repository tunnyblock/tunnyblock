package com.thinkgem.jeesite.modules.process.service;

import java.util.ArrayList;
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
import com.thinkgem.jeesite.common.utils.Collections3;
import com.thinkgem.jeesite.modules.process.dao.TaskDao;
import com.thinkgem.jeesite.modules.process.entity.ApproachAim;
import com.thinkgem.jeesite.modules.process.entity.Task;

/**
 * 任务Service
 * @author 俞超
 * @version 2014-12-11
 */
@Service
@Transactional(readOnly=true)
public class TaskService extends BaseService {

	@Autowired
	private TaskDao taskDao;
	
	public Task get(String id) {
		return taskDao.get(id);
	}
	
	public Page<Task> find(Page<Task> page, Task task) {
		DetachedCriteria dc = taskDao.createDetachedCriteria();
		dc.addOrder(Order.desc("id"));
		return taskDao.find(page, dc);
	}
	
	@Transactional(readOnly=false)
	public void save(Task task) {
		taskDao.save(task);
	}
	
	@Transactional(readOnly=false)
	public void delete(String id) {
		taskDao.deleteById(id);
	}

	public List<Task> findAll() {
		return taskDao.findAll();
	}
	
	/**
	 * 获取除进场和出场以外的任务列表
	 * @return
	 */
	public List<Task> findTaskListExcepApproachAndDepart(){
		DetachedCriteria dc = taskDao.createDetachedCriteria();
		dc.add(Restrictions.and(Restrictions.ne("taskName", "进场"),Restrictions.ne("taskName", "出场")));
		dc.add(Restrictions.eq("isShow", Task.YES));
		dc.addOrder(Order.asc("sort"));
		return taskDao.find(dc);
	}
	
	/**
	 * 根据进场目的查询关联的任务列表
	 * @param approachAimList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Task> findTaskListByApproachAimList(List<ApproachAim> approachAimList){
		List<String> approachIds = Collections3.extractToList(approachAimList, "id"); 
		if(approachIds==null || approachIds.size()==0){
			return new ArrayList<Task>();
		}
		//排除进场和出场
		String sqlString = "select t.* from task t inner join approach_aim_task a on t.id= a.task_id left join approach_aim m on a.approach_aim_id=m.id where m.id in(:p1) and t.id!='1' and t.id!='2'";
		return taskDao.findBySql(sqlString, new Parameter(approachIds),Task.class);
	}
	
	/**
	 * 根据ID获取任务列表
	 * @param ids
	 * @return
	 */
	public List<Task> findTaskListByIds(String[] ids){
		DetachedCriteria dc = taskDao.createDetachedCriteria();
		dc.add(Restrictions.in("id", ids));
		return taskDao.find(dc);
	}
	
	public Task findTaskByTaskName(String taskName){
		String hql = "from Task task where task.taskName=:p1";
		return taskDao.getByHql(hql, new Parameter(taskName));
	}
}
