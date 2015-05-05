<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="default" />
<script type="text/javascript">
		$(document).ready(function() {
			$("#inputForm").validate();
		});
	</script>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		<ul class="nav nav-tabs">
				<li><a href="${ctx }/sys/wash/list">产品列表</a></li>
				<li class="active"><a href="${ctx}/sys/wash/addUI">产品添加</a></li>
			</ul>
	</div>
	<form:form id="inputForm"  method="post"  modelAttribute="washProduct" class="form-horizontal" action=" ${ctx}/sys/wash/add" style="padding: 10px" role="form">
		<form:hidden path="id"/>
		<div class="form-group">
			<label class="col-sm-2 control-label">中文名称：</label>
			<div class="col-sm-4">
				<form:input path="goodsChineseName" type="text" class="form-control required" id="goodsChineseName" placeholder="中文"  />
				<span class="help-block">如有别名：可以这样添加：xxxxxx(酒精）</span>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">英文名称:</label>
			<div class="col-sm-4">
				<form:input path="goodsEnglishName" type="text" class="form-control" id="goodsEnglishName" placeholder="英文" /> 
				<span class="help-block">如有别名：可以这样添加：xxxxxx（DETA,EDA）</span>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-2 control-label">名称缩写:</label>
			<div class="col-sm-4">
				<form:input path="goodsShortName" type="text" class="form-control" id="goodsShortName" placeholder="英文" /> 
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-2 control-label">货物类别:</label>
			<div class="col-lg-4 col-sm-4 col-xs-4">
			        <c:forEach var="item" items="${fns:getDictList('sys_wash')}">
					    <div class="radio radio-inline"><form:radiobutton path="type" value="${item.value}" label="${item.label }"/></div>
					</c:forEach>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-2 control-label">危险品代码:</label>
			<div class="col-lg-4 col-sm-4 col-xs-4">
				<form:input path="dangerousGoodsCode" placeholder="Class9/Un1052" class="form-control" type="text" />
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-2 control-label">参考费率:</label>
			<div class="col-lg-4 col-sm-4 col-xs-4">
				<form:input path="referenceCleanPrice" class="form-control" type="text" />
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-2 control-label">额外费率:</label>
			<div class="col-lg-4 col-sm-4 col-xs-4">
				<form:input path="additionalCleanPrice" class="form-control" type="text" />
			</div>
		</div>
		
		<div class="form-group" >
			<label class="col-sm-2 control-label">备注信息:</label>
			<div class="col-lg-4 col-sm-4 col-xs-4">
				<form:textarea path="remarks" class="form-control"/>
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
</body>
</html>