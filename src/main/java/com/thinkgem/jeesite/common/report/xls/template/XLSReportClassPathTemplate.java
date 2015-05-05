package com.thinkgem.jeesite.common.report.xls.template;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;

/**
 * Implementation of XLSReportTemplate, which will get the XLS template from the class path.
 * The logical is copied from org.springframework.core.io.ClassPathResource.
 * @author 俞超
 *
 */
public class XLSReportClassPathTemplate implements XLSReportTemplate {
	
	private static final Log logger = LogFactory.getLog(XLSReportClassPathTemplate.class);
	
	/**
	 * 
	 */
	private final String path;
	
	/**
	 * 
	 */
	private ClassLoader classLoader;
	
	/**
	 * 
	 * @param path
	 */
	public XLSReportClassPathTemplate(String path) {
		this(path, (ClassLoader) null);
	}
	
	/**
	 * 
	 * @param path
	 * @param classLoader
	 */
	public XLSReportClassPathTemplate(String path, ClassLoader classLoader) {
		if (path == null) {
			throw new IllegalArgumentException("Path must not be null");
		}
		this.path = path;
		if (classLoader == null) {
			try {
				classLoader = Thread.currentThread().getContextClassLoader();
			} catch (Throwable ex) {
				logger.debug("Cannot access thread context ClassLoader - falling back to system class loader", ex);
				classLoader = XLSReportClassPathTemplate.class.getClassLoader();
			}
		}
		this.classLoader = classLoader;
	}
	
	@Override
	public Workbook getTemplate() throws IOException {
		InputStream is = this.classLoader.getResourceAsStream(this.path);
		if (is == null) {
			throw new FileNotFoundException(
					"class path resource [" + this.path + "] cannot be opened because it does not exist");
		}
		return new HSSFWorkbook(is);
	}

}
