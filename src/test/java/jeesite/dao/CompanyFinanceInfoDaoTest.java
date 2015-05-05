package jeesite.dao;

import javax.annotation.Resource;

import org.junit.Test;

import com.thinkgem.jeesite.modules.sys.dao.CompanyFinanceInfoDao;
import com.thinkgem.jeesite.modules.sys.dao.OfficeDao;
import com.thinkgem.jeesite.modules.sys.dao.UserDao;
import com.thinkgem.jeesite.modules.sys.entity.CompanyFinanceInfo;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;

import jeesite.BaseTestCase;

public class CompanyFinanceInfoDaoTest extends BaseTestCase {
	
	@Resource
	private CompanyFinanceInfoDao companyFinanceInfoDao;
	
	@Resource
	private UserDao userDao;
	
	@Resource
	private OfficeDao  officeDao;
	
	@Test
	public void saveTest(){
		Office office = officeDao.get("1");
		User user=userDao.get("1");
		CompanyFinanceInfo companyFinanceInfo = new CompanyFinanceInfo();
		companyFinanceInfo.setOffice(office);
		companyFinanceInfo.setFinaceContacter(user);
		companyFinanceInfo.setRmbAccount("123456");
		companyFinanceInfoDao.save(companyFinanceInfo);
	}

}
