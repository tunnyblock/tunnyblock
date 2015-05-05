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
	
		<!--导航菜单-->
		<ul class="nav nav-tabs">
			<li><a href="${ctx}/process/preorder/preapproach">预计进箱列表</a></li>
			<li class="active"><a href="${ctx}/process/approachExamination/">已进箱列表</a></li>
		</ul>
		
		<div style="margin-top: 10px;"></div>
		
		<!--查询框-->
		<form:form id="searchForm" modelAttribute="approachExamination" action="${ctx}/process/approachExamination/preapproach" method="post" class="breadcrumb form-inline" cssStyle="margin-bottom:10px;">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<div class="form-group">
				<form:input type="text" class="form-control input-sm" maxlength="50" id="tankCode" path="tank.tankCode" placeholder="箱号"/>
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
					<th>进场目的</th>
					<th>进场时间</th>
					<th>操作员</th>
					<th>备注</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${page.list}" var="approachExamination">
				<tr>
					<td>${approachExamination.preorder.orderCode}</td>
					<td>${approachExamination.tank.tankCode}</td>
					<!-- 输出进场目的 -->
					<td>
						<c:forEach items="${approachExamination.preorder.approachAimList}" var="aim">
							${aim.name}&nbsp;
						</c:forEach>
					</td>
					<td><fmt:formatDate value="${approachExamination.createdTime}" pattern="yyyy-MM-dd" /></td>
					<td>${approachExamination.createUser.name}</td>
					<td>${approachExamination.remarks}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		${page}
		
		<!-- Delete Confirm -->
		<div class="modal" id="confirmModal" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
		    <div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4><span class="fa fa-exclamation-triangle fa-2" style="color:red;"></span> 系统提示</h4>
					</div>
					<div class="modal-body">
						<p id='dialog-content'>确定要进行该操作吗?</p>
					</div>
					<div class="modal-footer">
						<a href="#" class="btn btn-primary btn-confirm btn-sm" >确定</a>
						<a href="#" class="btn btn-default btn-sm" data-dismiss="modal">取消</a>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			$(function(){
				$('.btn-delete').click(function(){
					if($(this).attr('dialog-content')){
						$("#dialog-content").html($(this).attr('dialog-content'));
					}
					$('#confirmModal .btn-confirm').attr('href', $(this).attr('rel') );
				});
			});
		</script>
	
	  <%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
</body>
</html>
