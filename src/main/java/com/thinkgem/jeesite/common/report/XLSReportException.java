package com.thinkgem.jeesite.common.report;

/**
 * superclass for XLS reporting exception
 * @author 俞超
 *
 */
@SuppressWarnings("serial")
public class XLSReportException extends RuntimeException {
	
	public XLSReportException() {
	}
	
	public XLSReportException(String msg) {
		super(msg);
	}
	
	public XLSReportException(Throwable cause) {
		super(cause);
	}
	
	public XLSReportException(String msg, Throwable cause) {
		super(msg, cause);
	}
	
}	
