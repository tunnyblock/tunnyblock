package com.thinkgem.jeesite.common.report.xls.template.fill;

import java.util.Map;

import org.apache.poi.ss.usermodel.Sheet;

/**
 * 
 * @author 俞超
 */
public interface CommentProcessor {
	
	/**
	 * initialize the CommentProcessor
	 */
	void init();
	
	/**
	 * @return
	 * 	true if the CommentProcessor has been initialized
	 */
	boolean isInited();
	
	/**
	 * fill the XLS sheet by data
	 * @param sheet
	 * @param dataSource
	 */
	@SuppressWarnings("rawtypes")
	void process(Sheet sheet, Map dataSource);
	
}
