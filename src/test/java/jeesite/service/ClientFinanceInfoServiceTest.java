package jeesite.service;

import javax.annotation.Resource;

import jeesite.BaseTestCase;

import org.junit.Test;

import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.modules.client.entity.Client;
import com.thinkgem.jeesite.modules.client.entity.ClientFinanceInfo;
import com.thinkgem.jeesite.modules.client.service.ClientFinanceInfoService;
import com.thinkgem.jeesite.modules.client.service.ClientService;

public class ClientFinanceInfoServiceTest  extends BaseTestCase{
	
	@Resource
	private ClientService clientService;
	
	@Resource
	private ClientFinanceInfoService clientFinanceInfoService;
	
	@Test
	public void saveTest(){
		Client client = clientService.get("003edba645ef4efc82b93ffcec0a0510");
		ClientFinanceInfo clientFinanceInfo = new ClientFinanceInfo();
		clientFinanceInfo.setClient(client);
		clientFinanceInfoService.save(clientFinanceInfo);
	}
	
	@Test
	public void findClientFianceInfoByClientIdTest(){
		ClientFinanceInfo clientFinanceInfo = clientFinanceInfoService.findClientFianceInfoByClientId("003edba645ef4efc82b93ffcec0a0510");
		System.out.println(JsonMapper.toJsonString(clientFinanceInfo));
	}
}
