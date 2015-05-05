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
	
	<div class="row">
	    <div class="col-lg-12">
	        <div class="ibox float-e-margins">
	            <div class="ibox-title">
	                <h5>进场预录单列表</h5>
	            </div>
	            <div class="ibox-content">
					<!--查询框-->
					<form:form id="searchForm" modelAttribute="preorder" action="${ctx}/process/preorder/" method="post" class="form-inline" cssStyle="margin-bottom:10px;">
						<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
						<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
						<div class="form-group">
							<form:input type="text" class="form-control input-sm" maxlength="50" id="orderCode" path="orderCode" placeholder="订单编号"/>
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
								<th>订单编号</th>
								<th>罐箱编号</th>
								<th>客户公司</th>
								<th>前装货品</th>
								<th>预计进场时间</th>
								<th>创建者</th>
								<th>是否已箱检</th>
								<th>备注</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${page.list}" var="preorder">
							<tr>
								<td><a href="${ctx}/process/preorder/form?id=${preorder.id}">${preorder.orderCode}</a></td>
								<td>${preorder.tank.tankCode}</td>
								<td>${preorder.client.companyChineseName}</td>
								<td>${preorder.cleanGoods.goodsChineseName}</td>
								<td><fmt:formatDate value="${preorder.expectedApproachTime}" pattern="yyyy-MM-dd" /></td>
								<td>${preorder.createUser.name}</td>
								<td>
									<c:choose>
										<c:when test="${preorder.isApproachExamined=='1'}">是</c:when>
										<c:otherwise>否</c:otherwise>
									</c:choose>
								</td>
								<td>${preorder.remarks}</td>
								<td>
									<a href="${ctx}/process/preorder/form?id=${preorder.id}">修改</a>
									<a rel="${ctx}/process/preorder/delete?id=${preorder.id}" class="btn-delete" href="#confirmModal" dialog-content="确认要删除该预录单吗？" data-toggle="modal" role="button">删除</a>
								</td>
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
					</div>
                 </div>
             </div>
         </div>
	  <%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
</body>
</html>
