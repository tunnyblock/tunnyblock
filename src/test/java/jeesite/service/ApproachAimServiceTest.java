package jeesite.service;

import javax.annotation.Resource;

import jeesite.BaseTestCase;

import org.junit.Test;

import com.thinkgem.jeesite.modules.process.entity.ApproachAim;
import com.thinkgem.jeesite.modules.process.entity.Task;
import com.thinkgem.jeesite.modules.process.service.ApproachAimService;
import com.thinkgem.jeesite.modules.process.service.TaskService;

public class ApproachAimServiceTest extends BaseTestCase {

	@Resource
	private ApproachAimService approachAimService;
	
	@Resource
	private TaskService taskService;
	
	@Test
	public void saveTaskTest(){
		Task task =  new Task();
		task.setTaskName("出场");
		taskService.save(task);
	}
	
	@Test
	public void approachAimSaveTest(){
		ApproachAim approachAim = new ApproachAim();
		approachAim.setName("暂存");
		approachAim.getTaskList().add(taskService.get("1"));
		approachAim.getTaskList().add(taskService.get("2"));
		approachAim.setRemarks("暂存目的");
		approachAimService.save(approachAim);
	}
}
