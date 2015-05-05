<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>客户公司报表管理</title>
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
			<li><a href="${ctx}/client/clientReportTemplate/">客户公司报表列表</a></li>
			<li class="active"><a href="${ctx}/client/clientReportTemplate/form?id=${clientReportTemplate.id}">客户公司报表<shiro:hasPermission name="client:clientReportTemplate:edit">${not empty clientReportTemplate.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="client:clientReportTemplate:edit">查看</shiro:lacksPermission></a></li>
		</ul><br/>
		
		<form:form id="inputForm" modelAttribute="clientReportTemplate" action="${ctx}/client/clientReportTemplate/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">名称:</label>
				<div class="col-sm-4">
					<form:input path="name" htmlEscape="false" maxlength="200" class="required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="remarks">备注:</label>
				<div class="col-sm-4">
					<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2"></label>
				<div class="col-sm-4">
					<shiro:hasPermission name="client:clientReportTemplate:edit">
						<input id="btnSubmit" class="btn btn-primary btn-sm" type="submit" value="保 存"/>&nbsp;
					</shiro:hasPermission>
					<input id="btnCancel" class="btn btn-default btn-sm" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</div>
		</form:form>
		<%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
</body>
</html>
