package jeesite.service;

import javax.annotation.Resource;

import jeesite.BaseTestCase;

import org.junit.Test;

import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.modules.sys.entity.CompanyFinanceInfo;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.CompanyFinanceInfoService;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;

public class CompanyFinanceInfoServiceTest extends BaseTestCase{

	@Resource
	private CompanyFinanceInfoService companyFinanceInfoService;
	
	@Resource
	private SystemService systemService;
	
	@Resource
	private OfficeService officeService;
	
	@Test
	public void saveTest(){
		User user = systemService.getUser("1");
		Office office = officeService.get("1");
		CompanyFinanceInfo companyFinanceInfo = new CompanyFinanceInfo();
		companyFinanceInfo.setOffice(office);
		companyFinanceInfo.setFinaceContacter(user);
		companyFinanceInfo.setRmbAccount("123456");
		companyFinanceInfoService.save(companyFinanceInfo);
	}
	
	@Test
	public void listAllTest(){
		System.out.println(JsonMapper.toJsonString(companyFinanceInfoService.findAll()));
		/*for(CompanyFinanceInfo companyFinanceInfo:companyFinanceInfoService.findAll()){
			System.out.println(companyFinanceInfo.getOffice().getName());
		}*/
	}
}
