package com.thinkgem.jeesite.modules.client.entity;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.utils.IdGen;


/**
 * 客户公司报表Entity
 * @author 俞超
 * @version 2014-12-17
 */
@Entity
@Table(name = "client_report_template")
public class ClientReportTemplate extends BaseEntity<ClientReportTemplate> implements Serializable{
	
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


