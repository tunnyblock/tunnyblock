package ${packageName}.${moduleName}.entity${subModuleName};

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.utils.IdGen;


/**
 * ${functionName}Entity
 * @author ${classAuthor}
 * @version ${classVersion}
 */
@Entity
@Table(name = "${tableName}")
public class ${ClassName} extends BaseEntity<${ClassName}> implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String id; 		// 编号
	
	@PrePersist
	public void prePersist(){
		this.id = IdGen.uuid();
	}
	
	@Id
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
}


