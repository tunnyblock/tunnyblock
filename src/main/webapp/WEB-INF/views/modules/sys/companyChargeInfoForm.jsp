<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>公司收费管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		<ul class="nav nav-tabs">
			<li><a href="${ctx}/sys/companyChargeInfo/">公司收费列表</a></li>
			<li class="active"><a href="${ctx}/sys/companyChargeInfo/form?id=${companyChargeInfo.id}">公司收费<shiro:hasPermission name="sys:companyChargeInfo:edit">${not empty companyChargeInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:companyChargeInfo:edit">查看</shiro:lacksPermission></a></li>
		</ul><br/>
		
		<form:form id="inputForm" modelAttribute="companyChargeInfo" action="${ctx}/sys/companyChargeInfo/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<div class="form-group">
				<label class="control-label col-sm-2" for="chargeName">公司:</label>
				<div class="col-sm-4">
				 <tags:treeselect id="company" name="company.id" value="${companyChargeInfo.company.id}" labelName="company.name" labelValue="${companyChargeInfo.company.name}" title="公司" url="/sys/companyChargeInfo/treeData?type=1" cssClass="form-control input-sm required"/>
				</div>
			</div>
			<div class="form-group"> 
				<label class="control-label col-sm-2" for="chargeName">收费名称:</label>
				<div class="col-sm-4">
					
					<form:input path="chargeName" htmlEscape="false" maxlength="200" class="required form-control"/> 
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="chargeShortName">收费名称缩写:</label>
				<div class="col-sm-4">
					<form:input path="chargeShortName" htmlEscape="false" maxlength="200" class="required form-control"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="unitPrice">单价:</label>
				<div class="col-sm-4">
					<form:input path="unitPrice" htmlEscape="false" maxlength="200" class="required form-control"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="chargeUnit">计价单位:</label>
				<div class="col-sm-4">
					<form:input path="chargeUnit" htmlEscape="false" maxlength="200" class="required form-control"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="description">描述信息:</label>
				<div class="col-sm-4">
					<form:input path="description" htmlEscape="false" maxlength="200" class="required form-control"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="remarks">备注:</label>
				<div class="col-sm-4">
					<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2">任务:</label> 
				<div class="col-sm-8">
					<c:forEach var="item" items="${taskList}" varStatus="varStatus">
					    <div class="radio radio-inline"><form:radiobutton path="taskIdList" value="${item.id}" label="${item.taskName}" class="required"/></div>
					    <c:if test="${varStatus.index%4==3}">
					    	<br/>
					    </c:if>
					</c:forEach>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2"></label>
				<div class="col-sm-4">
					<shiro:hasPermission name="sys:companyChargeInfo:edit">
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
