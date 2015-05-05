package ${packageName}.${moduleName}.service${subModuleName};

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.BaseService;
import ${packageName}.${moduleName}.entity${subModuleName}.${ClassName};
import ${packageName}.${moduleName}.dao${subModuleName}.${ClassName}Dao;

/**
 * ${functionName}Service
 * @author ${classAuthor}
 * @version ${classVersion}
 */
@Service
@Transactional(readOnly=true)
public class ${ClassName}Service extends BaseService {

	@Autowired
	private ${ClassName}Dao ${className}Dao;
	
	public ${ClassName} get(String id) {
		return ${className}Dao.get(id);
	}
	
	public Page<${ClassName}> find(Page<${ClassName}> page, ${ClassName} ${className}) {
		DetachedCriteria dc = ${className}Dao.createDetachedCriteria();
		dc.addOrder(Order.desc("id"));
		return ${className}Dao.find(page, dc);
	}
	
	@Transactional(readOnly=false)
	public void save(${ClassName} ${className}) {
		${className}Dao.save(${className});
	}
	
	@Transactional(readOnly=false)
	public void delete(String id) {
		${className}Dao.deleteById(id);
	}
	
}
