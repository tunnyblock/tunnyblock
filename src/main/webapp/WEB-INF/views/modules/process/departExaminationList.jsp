<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>出场箱检管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
		<div class="wrapper wrapper-content animated fadeInRight">
	
		<!--导航菜单-->
		<ul class="nav nav-tabs">
			<li class="active"><a href="${ctx}/process/departExamination/">出场箱检列表</a></li>
			<li><a href="${ctx}/process/departExamination/form">已出箱列表</a></li>
		</ul>
		
		<div style="margin-top: 10px;"></div>
		
		<!--查询框-->
		<form:form id="searchForm" modelAttribute="departExamination" action="${ctx}/process/departExamination/" method="post" class="breadcrumb form-inline" cssStyle="margin-bottom:10px;">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<div class="form-group">
				<form:input type="text" class="form-control input-sm" maxlength="50" id="tankCode" path="tank.tankCode" placeholder="箱号"/>
			</div>
			
			<div class="form-group">
				<input id="btnSubmit" class="btn btn-primary btn-sm" type="submit" value="查询" onclick="return page();"/>
				<input id="btnExport" class="btn btn-primary btn-sm" type="button" value="导出"/>
			</div>
		</form:form>
		
		<!--表单-->
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead>
			<tr>
				<th>箱号</th>
				<th>进场箱检员</th>
				<th>进场时间</th>
				<th>备注</th>
				<th>操作</th></tr>
			</thead>
			<tbody>
			<c:forEach items="${page.list}" var="departExamination">
				<tr>
					<td>${departExamination.tank.tankCode}</td>
					<td>${departExamination.approachExamination.createUser.name}</td>
					<td><fmt:formatDate value="${departExamination.approachExamination.createdTime}" pattern="yyyy/MM/dd" /></td>
					<td>${departExamination.remarks}</td>
					<td>
						<a href="${ctx}/process/departExamination/examine?id=${departExamination.id}" class="btn btn-default btn-xs">出场箱检</a>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		${page}
	  <%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
</body>
</html>
