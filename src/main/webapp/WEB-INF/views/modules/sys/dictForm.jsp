<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>字典管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#value").focus();
			$("#inputForm").validate();
		});
	</script>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		<ul class="nav nav-tabs">
			<li><a href="${ctx}/sys/dict/">字典列表</a></li>
			<li class="active"><a href="${ctx}/sys/dict/form?id=${dict.id}">字典<shiro:hasPermission name="sys:dict:edit">${not empty dict.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:dict:edit">查看</shiro:lacksPermission></a></li>
		</ul><br/>
		
		<form:form id="inputForm" modelAttribute="dict" action="${ctx}/sys/dict/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<div class="form-group">
				<label class="control-label col-sm-2" for="value">键值:</label>
				<div class="col-sm-4">
					<form:input path="value" htmlEscape="false" maxlength="50" class="required form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="label">标签:</label>
				<div class="col-sm-4">
					<form:input path="label" htmlEscape="false" maxlength="50" class="required form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label  col-sm-2" for="type">类型:</label>
				<div class="col-sm-4">
					<form:input path="type" htmlEscape="false" maxlength="50" class="required abc form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="description">描述:</label>
				<div class="col-sm-4">
					<form:input path="description" htmlEscape="false" maxlength="50" class="required  form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="sort">排序:</label>
				<div class="col-sm-4">
					<form:input path="sort" htmlEscape="false" maxlength="11" class="required digits  form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2"></label>
				<div class="col-sm-4">
					<shiro:hasPermission name="sys:dict:edit">
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