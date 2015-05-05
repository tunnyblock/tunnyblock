package jeesite.service;

import javax.annotation.Resource;

import org.junit.Test;

import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.modules.client.entity.Client;
import com.thinkgem.jeesite.modules.client.entity.ClientEmployee;
import com.thinkgem.jeesite.modules.client.service.ClientEmployeeService;
import com.thinkgem.jeesite.modules.client.service.ClientService;

import jeesite.BaseTestCase;

public class ClientEmployeeServiceTest extends BaseTestCase{
	
	@Resource
	private ClientService clientService;
	
	@Resource
	private ClientEmployeeService clientEmployeeService;
	
	@Test
	public void saveTest(){
		Client client = clientService.get("d657ad57b00d49a3b7bcc0c2a36adbfb");
		ClientEmployee clientEmployee = new ClientEmployee();
		clientEmployee.setClient(client);
		clientEmployee.setChineseName("俞超");
		clientEmployee.setEnglishName("jack");
		clientEmployeeService.save(clientEmployee);
	}
	
	@Test
	public void getTest(){
		Client client = clientService.get("d657ad57b00d49a3b7bcc0c2a36adbfb");
		System.out.println(JsonMapper.toJsonString(client));
	}

}
