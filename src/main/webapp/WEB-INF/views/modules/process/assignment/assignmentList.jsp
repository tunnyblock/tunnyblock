<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>进场箱检管理</title>
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
	
		<div class="row">
		    <div class="col-lg-8">
		        <div class="ibox float-e-margins">
		            <div class="ibox-title">
		                <h5>待分配流程列表</h5>
		            </div>
		            <div class="ibox-content">
						<!--查询框-->
						<form:form id="searchForm" modelAttribute="approachExamination" action="${ctx}/process/assignment" method="post" class="form-inline" cssStyle="margin-bottom:10px;">
							<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
							<div class="form-group">
								<div class="input-group input-group-sm">
								  <form:input type="text" class="form-control" maxlength="50" id="tankCode" path="tank.tankCode" placeholder="箱号"/>
								  <span class="input-group-addon"><a href="#" onclick="return page();"><i class="fa fa-search"></i> 查询</a></span>
								</div>
							</div>
						</form:form>
						
						<!--表单-->
						<table id="contentTable" class="table table-striped table-bordered table-condensed">
							<thead>
								<tr>
									<th>箱号</th>
									<th>箱子归属</th>
									<th>进场目的</th>
									<th>进场时间</th>
									<th>箱检员</th>
									<th>是否损坏</th>
									<th>备注</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${page.list}" var="approachExamination">
								<tr>
									<td><a href="${ctx}/process/assignment/${approachExamination.id}/pictureList">${approachExamination.tank.tankCode}</a></td>
									<td>${approachExamination.tank.client.companyChineseName}</td>
									<!-- 输出进场目的 -->
									<td>
										<c:forEach items="${approachExamination.preorder.approachAimList}" var="aim">
											${aim.name}&nbsp;
										</c:forEach>
									</td>
									<td><fmt:formatDate value="${approachExamination.createdTime}" pattern="yyyy-MM-dd" /></td>
									<td>${approachExamination.createUser.name}</td>
									<td>
										<c:choose>
											<c:when test="${approachExamination.isDamaged=='1'}">是</c:when>
											<c:otherwise>否</c:otherwise>
										</c:choose>
									</td>
									<td>${approachExamination.remarks}</td>
									<td>
										<a href="#"><i class="fa fa-bell"></i> 通知客户</a>
										<a href="${ctx}/process/assignment/${approachExamination.id}/process"><i class="fa fa-cog"></i> 设定内部流程</a>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						${page}
					</div>
				</div>
			</div>
			<div class="col-lg-4">
				<%@include file="/WEB-INF/views/include/custom-plugin.jsp" %>
				<%@include file="/WEB-INF/views/include/messages.jsp" %>
			</div>
	</div>
	<%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
</body>
</html>
