package jeesite.dao;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.modules.sys.dao.WashDao;

import jeesite.BaseTestCase;

public class WashDaoTest extends BaseTestCase{

	@Autowired 
	private WashDao washDao;
	
	@Test
	public void listTest(){
		System.out.println(JsonMapper.toJsonString(washDao.get("1")));
	}
}
