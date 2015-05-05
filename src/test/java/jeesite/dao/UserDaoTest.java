package jeesite.dao;

import javax.annotation.Resource;

import jeesite.BaseTestCase;

import org.junit.Test;

import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.modules.sys.dao.UserDao;

public class UserDaoTest extends BaseTestCase{

	@Resource
	private UserDao userDao;
	
	@Test
	public void findAllListTest(){
		System.out.println(JsonMapper.toJsonString(userDao.findAllList()));
	}
}
