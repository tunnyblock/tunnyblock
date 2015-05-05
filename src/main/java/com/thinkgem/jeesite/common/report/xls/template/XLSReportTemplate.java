package com.thinkgem.jeesite.common.report.xls.template;

import java.io.IOException;

import org.apache.poi.ss.usermodel.Workbook;

/**
 * represents the object that provides the XLS template,
 * based on which XLS report is created 
 * @author ex_zhusiyuan
 *
 */
public interface XLSReportTemplate {
	
	/**
	 * 
	 * @return
	 * 	the XLS template 
	 * @throws IOException
	 */
	Workbook getTemplate() throws IOException;
	
}
