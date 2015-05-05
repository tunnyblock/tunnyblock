package com.thinkgem.jeesite.common.report.xls.template.fill;

import java.util.Map;

import org.apache.poi.ss.usermodel.Workbook;

/**
 * High level representation of a rule, 
 * which defines how to fill the XLS template by data.
 * @author 俞超
 *
 */
public interface XLSReportFiller {
	
	/**
	 * fill the XLS template by data
	 * @param template
	 * @param dataSource
	 */
	@SuppressWarnings("rawtypes")
	void fill(Workbook template, Map dataSource);
	
}
