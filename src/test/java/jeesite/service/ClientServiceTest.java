package jeesite.service;

import javax.annotation.Resource;

import org.junit.Test;

import com.thinkgem.jeesite.modules.client.entity.Client;
import com.thinkgem.jeesite.modules.client.service.ClientService;

import jeesite.BaseTestCase;

public class ClientServiceTest extends BaseTestCase{
	
	@Resource
	private ClientService clientService;
	
	@Test
	public void saveTest(){
		Client client = new Client();
		client.setCompanyChineseName("测试中文名");
		client.setCompanyEnglishName("Testenglishname");
		clientService.save(client);
	}

}
