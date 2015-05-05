package jeesite.service;

import java.util.Date;

import javax.annotation.Resource;

import org.junit.Test;

import com.thinkgem.jeesite.modules.client.service.ClientEmployeeService;
import com.thinkgem.jeesite.modules.client.service.ClientService;
import com.thinkgem.jeesite.modules.process.entity.Preorder;
import com.thinkgem.jeesite.modules.process.entity.Tank;
import com.thinkgem.jeesite.modules.process.service.ApproachAimService;
import com.thinkgem.jeesite.modules.process.service.PreorderService;
import com.thinkgem.jeesite.modules.process.service.TankService;
import com.thinkgem.jeesite.modules.process.service.TaskService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;

import jeesite.BaseTestCase;

public class PreorderServiceTest extends BaseTestCase{
	
	@Resource
	private PreorderService preorderService;
	
	@Resource
	private ApproachAimService approachAimService;
	
	@Resource
	private TaskService taskService;
	
	@Resource
	private TankService tankService;
	
	@Resource
	private ClientService clientService;
	
	@Resource
	private ClientEmployeeService clientEmployeeService;
	
	@Resource
	private SystemService systemService;
	
	
	@Test
	public void tankSaveTest(){
		Tank tank = new Tank();
		tank.setTankCode("EX91231232");
		tank.setLastAnnualInspectTime(new Date());
		tank.setNextAnnualInspectTime(new Date());
		tank.setTankType("0");
		tankService.save(tank);
	}
	
	@Test
	public void saveTest(){
		Preorder preorder = new Preorder();
		preorder.setOrderCode("20141215153011");
		preorder.setTank(tankService.get("1"));
		preorder.setClient(clientService.get("003edba645ef4efc82b93ffcec0a0510"));
		preorder.setClientContacter(clientEmployeeService.get("b47cf62101ff4db8885364c9236a67cf"));
		preorder.setExpectedApproachTime(new Date());
		preorder.setExpectedDepartTime(new Date());
		preorder.setApproachTime(new Date());
		preorder.setDepartTime(new Date());
		preorder.setCreateTime(new Date());
		preorder.setCreateUser(systemService.getUser("1"));
		preorder.setUpdateTime(new Date());
		preorder.setUpdateUser(systemService.getUser("1"));
		preorderService.save(preorder);
	}
	
}
