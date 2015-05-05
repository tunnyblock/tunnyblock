<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>403 - 用户权限不足</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body class="gray-bg">
    <div class="middle-box text-center animated fadeInDown">
        <h1>403</h1>
        <h3 class="font-bold">用户权限不足</h3>
        <div class="error-desc">
            Sorry, you have no rights to view the page you are looking for. Try checking the URL for error, then hit the refresh button on your browser or try found something else in our app.
            <form role="form" class="form-inline m-t">
                <button class="btn btn-primary" type="button" onclick="history.go(-1)">返回上一页</button>
            </form>
        </div>
    </div>
</body>
</html>