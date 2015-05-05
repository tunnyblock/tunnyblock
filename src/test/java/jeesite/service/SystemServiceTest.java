package jeesite.service;

import javax.annotation.Resource;

import org.junit.Test;

import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;

import jeesite.BaseTestCase;

public class SystemServiceTest extends BaseTestCase {

	@Resource
	private SystemService systemService;
	
	@Resource
	private OfficeService officeService;
	
	@Test
	public void getUserTest(){
		System.out.println(JsonMapper.toJsonString(systemService.getUser("1")));
	}
	
	@Test
	public void saveUserTest(){
		User user = new User();
		user.setLoginName("yuchao");
		user.setPassword(SystemService.entryptPassword("123456"));
		user.setName("俞超");
		user.setCompany(officeService.get("1"));
		user.setOffice(officeService.get("2"));
		systemService.saveUser(user);
	}
}
