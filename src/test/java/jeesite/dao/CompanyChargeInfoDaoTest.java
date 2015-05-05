package jeesite.dao;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import jeesite.BaseTestCase;

import org.junit.Test;

import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.modules.process.entity.Task;
import com.thinkgem.jeesite.modules.process.service.TaskService;
import com.thinkgem.jeesite.modules.sys.dao.CompanyChargeInfoDao;
import com.thinkgem.jeesite.modules.sys.entity.CompanyChargeInfo;

public class CompanyChargeInfoDaoTest extends BaseTestCase{

	@Resource
	private CompanyChargeInfoDao companyChargeInfoDao;
	@Resource
	private TaskService taskService;
	
	@Test
	public void findAllListTest(){
		CompanyChargeInfo companyChargeInfo=new CompanyChargeInfo();
		Task task=taskService.get("1");
		System.out.println(task.getTaskName()+"----->");
		List<Task> taskList=new ArrayList<Task>();
		taskList.add(task);
		companyChargeInfo.setTaskList(taskList);
		companyChargeInfo.setChargeName("czh11");
		companyChargeInfoDao.clear();
		companyChargeInfoDao.save(companyChargeInfo);
		
/*		task.setCompanyChargeInfo(companyChargeInfo);
		taskService.save(task);*/
		System.out.println("save");
	}
}
