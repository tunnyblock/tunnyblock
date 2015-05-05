package jeesite.service;

import javax.annotation.Resource;

import org.junit.Test;

import com.thinkgem.jeesite.modules.process.entity.ApproachExamination;
import com.thinkgem.jeesite.modules.process.service.ApproachExaminationService;
import com.thinkgem.jeesite.modules.process.service.PreorderService;
import com.thinkgem.jeesite.modules.process.service.TankService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;

import jeesite.BaseTestCase;

public class ApproachExaminationServiceTest extends BaseTestCase{

	@Resource
	private ApproachExaminationService approachExaminationService;
	
	@Resource
	private TankService tankService;
	
	@Resource
	private PreorderService preorderService;
	
	@Resource
	private SystemService systemService;
	
	@Test
	public void saveTest(){
		ApproachExamination approachExamination = new ApproachExamination();
		approachExamination.setTank(tankService.get("3f3d655bec014b7286efc382b3db4dd6"));
		approachExamination.setPreorder(preorderService.get("afecb54bb111490e932f7cdd6a2b0541"));
		approachExamination.setCreateUser(systemService.getUser("1"));
		approachExaminationService.save(approachExamination);
	}
}
