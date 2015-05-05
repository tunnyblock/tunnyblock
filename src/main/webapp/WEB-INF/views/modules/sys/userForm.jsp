<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#loginName").focus();
			$("#inputForm").validate();
		});
	</script>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		<ul class="nav nav-tabs">
			<li><a href="${ctx}/sys/user/">用户列表</a></li>
			<li class="active"><a href="${ctx}/sys/user/form?id=${user.id}">用户<shiro:hasPermission name="sys:user:edit">${not empty user.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:user:edit">查看</shiro:lacksPermission></a></li>
		</ul><br/>
		
		<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<div class="form-group">
				<label class="col-sm-2  control-label" for="company">归属公司:</label>
				<div class="col-sm-4">
					 <tags:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}" title="公司" url="/sys/office/treeData?type=1" cssClass="form-control input-sm required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="office">归属部门:</label>
				<div class="col-sm-4">
					<tags:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}" title="部门" url="/sys/office/treeData?type=2" cssClass="form-control input-sm required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="oldLoginName">登录名:</label>
				<div class="col-sm-4">
					<input id="oldLoginName" name="oldLoginName" type="hidden" value="${user.loginName}">
					<form:input path="loginName" htmlEscape="false" maxlength="50" class="required userName form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="no">工号:</label>
				<div class="col-sm-4">
					<form:input path="no" htmlEscape="false" maxlength="50" class="required form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">姓名:</label>
				<div class="col-sm-4">
					<form:input path="name" htmlEscape="false" maxlength="50" class="required  form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="newPassword">密码:</label>
				<div class="col-sm-4">
					<input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="${empty user.id?'required':''}  form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="confirmNewPassword">确认密码:</label>
				<div class="col-sm-4">
					<input id="confirmNewPassword" name="confirmNewPassword"  type="password" value="" maxlength="50" minlength="3" equalTo="#newPassword" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="email">邮箱:</label>
				<div class="col-sm-4">
					<form:input path="email" htmlEscape="false" maxlength="100" class="email form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="email">邮箱密码:</label>
				<div class="col-sm-4">
					<input type="password" maxlength="100" class="form-control input-sm" value="${user.emailPassword}" name="emailPassword"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label  col-sm-2" for="phone">电话:</label>
				<div class="col-sm-4">
					<form:input path="phone" htmlEscape="false" maxlength="100" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="mobile">手机:</label>
				<div class="col-sm-4">
					<form:input path="mobile" htmlEscape="false" maxlength="100" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="remarks">备注:</label>
				<div class="col-sm-4">
					<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="userType">用户类型:</label>
				<div class="col-sm-4">
					<form:select path="userType" class="form-control input-sm">
						<form:option value="" label="请选择"/>
						<form:options items="${fns:getDictList('sys_user_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="roleIdList">用户角色:</label>
				<div class="col-sm-6">
					<c:forEach var="item" items="${allRoles}">
					    <div class="checkbox checkbox-inline"><form:checkbox path="roleIdList" value="${item.id}" label="${item.name }" class="required"/></div>
					</c:forEach>
				</div>
			</div>
			<c:if test="${not empty user.id}">
				<div class="form-group">
					<label class="control-label col-sm-2">创建时间:</label>
					<div class="col-sm-4">
						<label class="lbl"><fmt:formatDate value="${user.createDate}" type="both" dateStyle="full" pattern="yyyy-MM-dd HH:mm:ss"/></label>
					</div>
				</div>
			</c:if>
			<div class="form-group">
				<label class="control-label col-sm-2"></label>
				<div class="col-sm-4">
					<shiro:hasPermission name="sys:user:edit"><input id="btnSubmit" class="btn btn-primary btn-sm" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
					<input id="btnCancel" class="btn btn-default btn-sm" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</div>
		</form:form>
	</div>
</body>
</html>