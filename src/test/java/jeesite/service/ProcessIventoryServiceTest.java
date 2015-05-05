package jeesite.service;

import java.util.Date;
import java.util.List;

import jeesite.BaseTestCase;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.thinkgem.jeesite.modules.process.entity.Process;
import com.thinkgem.jeesite.modules.process.entity.ProcessIventory;
import com.thinkgem.jeesite.modules.process.service.ApproachExaminationService;
import com.thinkgem.jeesite.modules.process.service.ProcessIventoryService;
import com.thinkgem.jeesite.modules.process.service.ProcessService;
import com.thinkgem.jeesite.modules.process.service.TaskService;

public class ProcessIventoryServiceTest  extends BaseTestCase{
	
	@Autowired
	private ApproachExaminationService approachExaminationService;
	
	@Autowired
	private TaskService taskService;
	
	@Autowired
	private ProcessService processService;
	
	@Autowired
	private ProcessIventoryService processIventoryService;
	
	@Test
	public void processAutoSaveTest(){
		processIventoryService.saveProcess("4f4dba75c7794d9983e9bcc3d3af513d", "1,10,11,2".split(","),new Date());
	}
	
	@Test
	public void listAllProcessIventoryTest(){
		List<ProcessIventory> list = processIventoryService.findProcessIventoryListByUserId(null);
		for(ProcessIventory processIventory:list){
			System.out.println(processIventory.getName());
			for(Process process:processIventory.getProcessList()){
				System.out.println("=="+process.getTask().getTaskName()+","+process.getState());
			}
		}
	}

}
