package com.thinkgem.jeesite.common.report.xls.data;

import java.util.Map;

/**
 * represents the object that provides the data 
 * to fill the XLS template
 * @author 俞超
 *
 */
public interface XLSReportDataSource {
	
	/**
	 * @return
	 * 	the data used to fill the XLS template
	 */
	@SuppressWarnings("rawtypes")
	Map getData();
	
}
