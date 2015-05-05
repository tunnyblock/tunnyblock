<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>客户员工管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate();
		});
	</script>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		<ul class="nav nav-tabs">
			<li><a href="${ctx}/client/clientEmployee/">客户员工管理列表</a></li>
			<li class="active"><a href="${ctx}/client/clientEmployee/form?id=${clientEmployee.id}">客户员工管理<shiro:hasPermission name="client:clientEmployee:edit">${not empty clientEmployee.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="client:clientEmployee:edit">查看</shiro:lacksPermission></a></li>
		</ul><br/>
		
		<form:form id="inputForm" modelAttribute="clientEmployee" action="${ctx}/client/clientEmployee/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<tags:message content="${message}"/>
			<div class="control-group">
				<label class="control-label" for="name">名称:</label>
				<div class="controls">
					<form:input path="name" htmlEscape="false" maxlength="200" class="required"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="remarks">备注:</label>
				<div class="controls">
					<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge"/>
				</div>
			</div>
			<div class="form-actions">
				<shiro:hasPermission name="client:clientEmployee:edit">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
				</shiro:hasPermission>
				<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			</div>
		</form:form>
	</div>
</body>
</html>
