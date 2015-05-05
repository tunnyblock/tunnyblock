<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>预录单管理</title>
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
			<li class="active"><a href="${ctx}/process/preorder/preapproach">预计进箱列表</a></li>
			<li><a href="${ctx}/process/approachExamination/">已进箱列表</a></li>
		</ul>
		
		<div style="margin-top: 10px;"></div>
		
		<!--查询框-->
		<form:form id="searchForm" modelAttribute="preorder" action="${ctx}/process/preorder/" method="post" class="breadcrumb form-inline" cssStyle="margin-bottom:10px;">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<div class="form-group">
				<form:input type="text" class="form-control input-sm" maxlength="50" id="orderCode" path="orderCode" placeholder="订单编号"/>
			</div>
			
			<div class="form-group">
				<input id="btnSubmit" class="btn btn-primary btn-sm" type="submit" value="查询" onclick="return page();"/>
			</div>
		</form:form>
		
		<!--表单-->
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th>订单编号</th>
					<th>箱号</th>
					<th>客户公司</th>
					<th>前装货品</th>
					<th>预计进场时间</th>
					<th>创建者</th>
					<th>备注</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${page.list}" var="preorder">
				<tr>
					<td>${preorder.orderCode}</td>
					<td>${preorder.tank.tankCode}</td>
					<td>${preorder.client.companyChineseName}</td>
					<td>${preorder.cleanGoods.goodsChineseName}</td>
					<td><fmt:formatDate value="${preorder.expectedApproachTime}" pattern="yyyy-MM-dd" /></td>
					<td>${preorder.createUser.name}</td>
					<td>${preorder.remarks}</td>
					<td>
						<a href="${ctx}/process/approachExamination/examine/${preorder.id}">进场箱检</a>
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
