<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
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
			<li><a href="${ctx}/sys/office/">机构列表</a></li>
			<li class="active"><a href="${ctx}/sys/office/form?id=${office.id}&parent.id=${office.parent.id}">机构<shiro:hasPermission name="sys:office:edit">${not empty office.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:office:edit">查看</shiro:lacksPermission></a></li>
		</ul><br/>
		
		<form:form id="inputForm" modelAttribute="office" action="${ctx}/sys/office/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<div class="form-group">
				<label class="control-label col-sm-2">上级机构:</label>
				<div class="col-sm-4">
					<tags:treeselect id="office" name="parent.id" value="${office.parent.id}" labelName="parent.name" labelValue="${office.parent.name}" title="机构" url="/sys/office/treeData" extId="${office.id}" cssClass="required form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2">归属区域:</label>
				<div class="col-sm-4">
					<tags:treeselect id="area" name="area.id" value="${office.area.id}" labelName="area.name" labelValue="${office.area.name}" title="区域" url="/sys/area/treeData" cssClass="form-control input-sm required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">机构名称:</label>
				<div class="col-sm-4">
					<form:input path="name" htmlEscape="false" maxlength="50" class="required form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="code">机构编码:</label>
				<div class="col-sm-4">
					<form:input path="code" htmlEscape="false" maxlength="50" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="type">机构类型:</label>
				<div class="col-sm-4">
					<form:select path="type" class="form-control input-sm">
						<form:options items="${fns:getDictList('sys_office_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="grade">机构级别:</label>
				<div class="col-sm-4">
					<form:select path="grade" class="form-control input-sm">
						<form:options items="${fns:getDictList('sys_office_grade')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="address">联系地址:</label>
				<div class="col-sm-4">
					<form:input path="address" htmlEscape="false" maxlength="50" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label  col-sm-2" for="zipCode">邮政编码:</label>
				<div class="col-sm-4">
					<form:input path="zipCode" htmlEscape="false" maxlength="50" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label  col-sm-2" for="master">负责人:</label>
				<div class="col-sm-4">
					<form:input path="master" htmlEscape="false" maxlength="50" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="phone">电话:</label>
				<div class="col-sm-4">
					<form:input path="phone" htmlEscape="false" maxlength="50"  class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="fax">传真:</label>
				<div class="col-sm-4">
					<form:input path="fax" htmlEscape="false" maxlength="50" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="email">邮箱:</label>
				<div class="col-sm-4">
					<form:input path="email" htmlEscape="false" maxlength="50" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="remarks">备注:</label>
				<div class="col-sm-4">
					<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" ></label>
				<div class="col-sm-4">
					<shiro:hasPermission name="sys:office:edit">
						<input id="btnSubmit" class="btn btn-primary btn-sm" type="submit" value="保 存"/>&nbsp;
					</shiro:hasPermission>
					<input id="btnCancel" class="btn btn-default btn-sm" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</div>
		</form:form>
	</div>
</body>
</html>