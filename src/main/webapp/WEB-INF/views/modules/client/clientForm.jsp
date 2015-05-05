<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>客户公司管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#companyChineseName").focus();
			$("#inputForm").validate();
		});
	</script>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		<ul class="nav nav-tabs">
			<li><a href="${ctx}/client/client/">客户公司列表</a></li>
			<li class="active"><a href="${ctx}/client/client/form?id=${client.id}">客户公司<shiro:hasPermission name="client:client:edit">${not empty client.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="client:client:edit">查看</shiro:lacksPermission></a></li>
		</ul><br/>
		
		<form:form id="inputForm" modelAttribute="client" action="${ctx}/client/client/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">中文名称:</label>
				<div class="col-sm-4">
					<form:input path="companyChineseName" htmlEscape="false" maxlength="200" class="required form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">英文名称:</label>
				<div class="col-sm-4">
					<form:input path="companyEnglishName" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">名称缩写:</label>
				<div class="col-sm-4">
					<form:input path="companyShortName" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">公司电话:</label>
				<div class="col-sm-4">
					<form:input path="telephone" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">公司传真:</label>
				<div class="col-sm-4">
					<form:input path="fax" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">公司地址:</label>
				<div class="col-sm-4">
					<form:input path="address" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">公司邮箱:</label>
				<div class="col-sm-4">
					<form:input path="email" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">公司网址:</label>
				<div class="col-sm-4">
					<form:input path="website" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">公司图标:</label>
				<div class="col-sm-4">
					<input type="file" name="logoUrlFile" id="logoUrlFile" title="选择文档..." class="btn btn-default btn-sm"/>
					<input type="hidden" name="logoUrl" id="logoUrl" />
					<p style="margin:0;padding-top:5px;">* 文件大小不能超过20M</p>
					<script type="text/javascript">
						$(document).ready(function(){
							$('input[type=file]').bootstrapFileInput();
							$("#logoUrlUploader").click(function(){
								$(this).parent().after('<div class="col-sm-8 progress-container"><div class="progress"><div class="progress-bar" style="width: 0%;" id="file-progress-bar"></div></div></div>');
								$('#logoUrlFile').upload({
									action:"${ctx}/upload/client",
									oncomplete: function() {
									},
									onsuccess: function(json) {
										$(".progress-container").remove();
										$("#logoUrlUploader").parent().after('<div class="col-sm-8 progress-container"><a href="${baseCtx}'+json.filePath+'">图片地址</a></div>');
										$("#logoUrl").val(json.filePath);
									},
									onerror: function(json) {
									},
									onprogress: function(e) {
										$("#file-progress-bar").css("width",(e.loaded / e.total)*100+"%");
									} 
								});
							});
						});
					</script>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2"></label>
				<div class="col-sm-4">
					<div class="row">
						<div class="col-sm-4"><button id="logoUrlUploader" class="btn btn-primary btn-sm" type="button">开始上传</button></div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">联&nbsp;&nbsp;系&nbsp;&nbsp;人:</label>
				<div class="col-sm-4">
					<input type="text" id="contacter-chineseName" name="contacter.chineseName" value="${client.contacter.chineseName}" class="form-control input-sm"/>
					<input type="hidden" id="contacter-id" name="contacter.id" value="${client.contacter.id}"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2"></label>
				<div class="col-sm-4">
					<shiro:hasPermission name="client:client:edit">
						<input id="btnSubmit" class="btn btn-primary btn-sm" type="submit" value="保 存"/>&nbsp;
					</shiro:hasPermission>
					<input id="btnCancel" class="btn btn-default btn-sm" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</div>
		</form:form>
	</div>
</body>
</html>
