<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ page import="com.thinkgem.jeesite.common.beanvalidator.BeanValidators"%>
<%@ page import="org.slf4j.Logger,org.slf4j.LoggerFactory" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%response.setStatus(200);%>
<%
	Throwable ex = null;
	if (exception != null)
		ex = exception;
	if (request.getAttribute("javax.servlet.error.exception") != null)
		ex = (Throwable) request.getAttribute("javax.servlet.error.exception");
	//记录日志
	if (ex!=null){
		Logger logger = LoggerFactory.getLogger("500.jsp");
		logger.error(ex.getMessage(), ex);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>500 - 系统内部错误</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
	<div class="middle-box text-center animated fadeInDown">
        <h1>500</h1>
        <h3 class="font-bold">Internal Server Error</h3>

        <div class="error-desc">
            <%
				if (ex!=null){
					if (ex instanceof javax.validation.ConstraintViolationException){
						for (String s : BeanValidators.extractPropertyAndMessageAsList((javax.validation.ConstraintViolationException)ex, ": ")){
							out.print(s+"<br/>");
						}
					}else{
						out.print(ex+"<br/>");
					}
				}
			%>
            You can go back to main page: <br><a class="btn btn-primary m-t" onclick="history.go(-1);" >返回上一页</a>
        </div>
    </div>
</body>
</html>