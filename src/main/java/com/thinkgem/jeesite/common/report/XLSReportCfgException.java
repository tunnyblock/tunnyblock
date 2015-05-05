package com.thinkgem.jeesite.common.report;

/**
 * exception of XLS report template configuration
 * @author 俞超
 *
 */
@SuppressWarnings("serial")
public class XLSReportCfgException extends XLSReportException {
	
	public XLSReportCfgException() {
	}
	
	public XLSReportCfgException(String msg) {
		super(msg);
	}
	
	public XLSReportCfgException(Throwable cause) {
		super(cause);
	}
	
	public XLSReportCfgException(String msg, Throwable cause) {
		super(msg, cause);
	}
	
}
