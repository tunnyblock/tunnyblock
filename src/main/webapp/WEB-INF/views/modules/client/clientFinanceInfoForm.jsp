<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>客户财务信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#domesticInvoiceTitle").focus();
			$("#inputForm").validate();
		});
	</script>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		<form:form id="inputForm" modelAttribute="clientFinanceInfo" action="${ctx}/client/clientFinanceInfo/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<h5>国内发票要求</h5>
			<hr/>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">发票抬头:</label>
				<div class="col-sm-4">
					<form:input path="domesticInvoiceTitle" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">税务编号:</label>
				<div class="col-sm-4">
					<form:input path="domesticTaxNum" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				</div>
				<label class="control-label col-sm-2" for="name">组织机构:</label>
				<div class="col-sm-4">
					<form:input path="domesticOrganiztionCode" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">快递地址:</label>
				<div class="col-sm-4">
					<form:input path="domesticAddress" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				</div>
				<label class="control-label col-sm-2" for="name">营业执照:</label>
				<div class="col-sm-4">
					<form:input path="domesticBussinessLicence" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">收&nbsp;件&nbsp;人:</label>
				<div class="col-sm-4">
					<tags:treeselect id="domesticClientEmployee" name="domesticClientEmployee.id" value="${empty domesticClientEmployee?'':domesticClientEmployee.id}" labelName="domesticClientEmployee.chineseName" labelValue="${clientFinanceInfo.domesticClientEmployee.chineseName}" title="客户员工" url="/client/client/clientUserTreeData?clientId=${clientId}"  cssClass="form-control input-sm"/>
				</div>
				<label class="control-label col-sm-2" for="name">税务登记:</label>
				<div class="col-sm-4">
					<form:input path="domesticTaxRegisterLicence" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				</div>
			</div>
			
			<h5>海外发票要求</h5>
			<hr/>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">海外发票抬头:</label>
				<div class="col-sm-4">
					<form:input path="overseaInvoiceTitle" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				</div>
				<label class="control-label col-sm-2" for="name">形式发票抬头:</label>
				<div class="col-sm-4">
					<form:input path="proformaInvoiceTitle" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">形式发票快递地址:</label>
				<div class="col-sm-4">
					<form:input path="proformaInvoiceAddress" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				</div>
				<label class="control-label col-sm-2" for="name">形式发票收件人:</label>
				<div class="col-sm-4">
					<tags:treeselect id="proformaClientEmployee" name="proformaClientEmployee.id" value="${empty proformaClientEmployee?'':proformaClientEmployee.id}" labelName="proformaClientEmployee.chineseName" labelValue="${clientFinanceInfo.proformaClientEmployee.chineseName}" title="客户员工" url="/client/client/clientUserTreeData?clientId=${clientId}"  cssClass="form-control input-sm"/>
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
					<input id="btnSubmit" class="btn btn-primary btn-sm" type="submit" value="保 存"/>&nbsp;
					<input id="btnCancel" class="btn btn-default btn-sm" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</div>
		</form:form>
		<%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
</body>
</html>
