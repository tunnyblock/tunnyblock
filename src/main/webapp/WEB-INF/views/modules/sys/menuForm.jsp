<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
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
			<li><a href="${ctx}/sys/menu/">菜单列表</a></li>
			<li class="active"><a href="${ctx}/sys/menu/form?id=${menu.id}&parent.id=${menu.parent.id}">菜单<shiro:hasPermission name="sys:menu:edit">${not empty menu.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:menu:edit">查看</shiro:lacksPermission></a></li>
		</ul><br/>
		
		<form:form id="inputForm" modelAttribute="menu" action="${ctx}/sys/menu/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<div class="form-group">
				<label class="control-label col-sm-2">上级菜单:</label>
				<div class="col-sm-4">
					<tags:treeselect id="menu" name="parent.id" value="${menu.parent.id}" labelName="parent.name" labelValue="${menu.parent.name}" title="菜单" url="/sys/menu/treeData" extId="${menu.id}" cssClass="form-control input-sm required"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">名称:</label>
				<div class="col-sm-4">
					<form:input path="name" htmlEscape="false" maxlength="50" class="required form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="href">链接:</label>
				<div class="col-sm-4">
					<form:input path="href" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="target">目标:</label>
				<div class="col-sm-4">
					<form:input path="target" htmlEscape="false" maxlength="10" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label  col-sm-2" for="sort">排序:</label>
				<div class="col-sm-4">
					<form:input path="sort" htmlEscape="false" maxlength="50" class="required digits form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="isShow">可见:</label>
				<div class="col-sm-6">
					<c:forEach var="item" items="${fns:getDictList('show_hide')}">
					    <div class="radio radio-inline"><form:radiobutton path="isShow" value="${item.value}" label="${item.label }" class="required"/></div>
					</c:forEach>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="isShow">左侧显示:</label>
				<div class="col-sm-6">
					<c:forEach var="item" items="${fns:getDictList('yes_no')}">
					    <div class="radio radio-inline"><form:radiobutton path="isSlide" value="${item.value}" label="${item.label }" class="required"/></div>
					</c:forEach>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="isShow">属于新建:</label>
				<div class="col-sm-6">
					<c:forEach var="item" items="${fns:getDictList('yes_no')}">
					    <div class="radio radio-inline"><form:radiobutton path="isNewMenu" value="${item.value}" label="${item.label }" class="required"/></div>
					</c:forEach>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="permission">权限标识:</label>
				<div class="col-sm-4">
					<form:input path="permission" htmlEscape="false" maxlength="100" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" ></label>
				<div class="col-sm-4">
					<shiro:hasPermission name="sys:menu:edit">
						<input id="btnSubmit" class="btn btn-primary btn-sm" type="submit" value="保 存"/>&nbsp;
					</shiro:hasPermission>
					<input id="btnCancel" class="btn btn-default btn-sm" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</div>
		</form:form>
	</div>
</body>
</html>