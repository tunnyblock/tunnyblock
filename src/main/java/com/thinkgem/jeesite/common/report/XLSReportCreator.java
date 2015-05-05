package com.thinkgem.jeesite.common.report;

import java.io.IOException;
import java.io.OutputStream;

import org.apache.poi.ss.usermodel.Workbook;

import com.thinkgem.jeesite.common.report.xls.data.XLSReportDataSource;
import com.thinkgem.jeesite.common.report.xls.template.XLSReportTemplate;
import com.thinkgem.jeesite.common.report.xls.template.fill.XLSReportFiller;

/**
 * a utility class used to create XLS report 
 * based on XLS template, data and the filling rule
 * @author 俞超
 *
 */
public class XLSReportCreator {
	
	/**
	 * 
	 * @param dataSource
	 * @param filler
	 * @param os
	 * @throws IOException
	 */
	public static void createXLS(XLSReportTemplate template, XLSReportDataSource dataSource, XLSReportFiller filler, OutputStream os) throws IOException {
		Workbook workbook = template.getTemplate();
		filler.fill(workbook, dataSource.getData());
		workbook.write(os);
	}
	
}
