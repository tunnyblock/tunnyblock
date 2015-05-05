<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>客户员工管理</title>
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
			<form:form id="searchForm" modelAttribute="clientEmployee" action="${ctx}/client/client/${officeId }/clientEmployeeList" method="post" class="breadcrumb form-inline" cssStyle="margin-bottom:10px;">
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
				<div class="form-group">
					<form:input path="chineseName" htmlEscape="false" maxlength="50" class="form-control input-sm" placeholder="员工姓名"/>
				</div>
				<div class="form-group">
					<input id="addButton" class="btn btn-default btn-sm" type="button" value="新建" onclick="javascript:addOrUpdateClientEmployee(null);"/>
					<input id="btnSubmit" class="btn btn-primary btn-sm" type="submit" value="查询" onclick="return page();"/>
				</div>
			</form:form>
			
			<table id="contentTable" class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>中文名</th>
						<th>英文名</th>
						<th>岗位</th>
						<th>邮箱</th>
						<th>电话</th>
						<th>传真</th>
						<th>手机</th>
						<th>QQ</th>
						<th>备注</th>
						<shiro:hasPermission name="client:clientEmployee:edit">
							<th>操作</th>
						</shiro:hasPermission>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.list}" var="clientEmployee">
					<tr>
						<td>${clientEmployee.chineseName}</td>
						<td>${clientEmployee.englishName}</td>
						<td>${clientEmployee.position}</td>
						<td>${clientEmployee.email}</td>
						<td>${clientEmployee.telephone}</td>
						<td>${clientEmployee.fax}</td>
						<td>${clientEmployee.mobilephone}</td>
						<td>${clientEmployee.qqNum}</td>
						<td>${clientEmployee.description}</td>
						<shiro:hasPermission name="client:clientEmployee:edit">
							<td>
			    				<a href="#" onclick="javascript:addOrUpdateClientEmployee('${clientEmployee.id}')">修改</a>
								<a rel="${ctx}/client/client/${officeId}/clientEmployee/delete?id=${clientEmployee.id}" class="btn-delete" href="#confirmModal" dialog-content="确认要删除该客户员工信息吗？" data-toggle="modal" role="button">删除</a>
							</td>
						</shiro:hasPermission>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			${page}
		</div>
		<%@include file="/WEB-INF/views/include/footer.jsp" %>
		
		<!-- 新建/修改 -->
		<div class="modal fade" id="clientEmployeeDialog">
			<div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			        <h4 class="modal-title" >新增客户员工</h4>
			      </div>
			      <div class="modal-body">
				      <form action="${ctx}/client/client/${officeId}/clientEmployee/save" method="post" id="clientEmployeeForm" class="form-horizontal">
				      	<input type="hidden" id="id" name="id"/>
				      	<input type="hidden" id="photoUrl" name="photoUrl"/>
						<div class="row">
							<div class="col-sm-7">
								<div class="form-group">
									<label class="control-label col-sm-3" for="name">中文名:</label>
									<div class="col-sm-9">
										<input id="chineseName" name="chineseName" type="text" maxlength="200" class="required form-control input-sm"/>
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-3" for="name">英文名:</label>
									<div class="col-sm-9">
										<input id="englishName" name="englishName" type="text" maxlength="200" class="form-control input-sm"/>
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-3" for="name">岗位:</label>
									<div class="col-sm-9">
										<input id="position" name="position" type="text" maxlength="200" class="form-control input-sm"/>
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-3" for="name">邮箱:</label>
									<div class="col-sm-9">
										<input id="email" name="email"  type="text" maxlength="200" class="form-control input-sm"/>
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-3" for="name">电话:</label>
									<div class="col-sm-9">
										<input id="telephone"  name="telephone" type="text"  maxlength="200" class="form-control input-sm"/>
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-3" for="name">传真:</label>
									<div class="col-sm-9">
										<input id="fax" name="fax" type="text" maxlength="200" class="form-control input-sm"/>
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-3" for="name">手机:</label>
									<div class="col-sm-9">
										<input id="mobilephone" name="mobilephone" type="text" maxlength="200" class="form-control input-sm"/>
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-3" for="name">QQ:</label>
									<div class="col-sm-9">
										<input id="qqNum" name="qqNum"  type="text" maxlength="200" class="form-control input-sm"/>
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-3" for="name">备注:</label>
									<div class="col-sm-9">
										<textarea id="description" name="description" maxlength="200" class="form-control input-sm"></textarea>
									</div>
								</div>
							</div>
							
							<div class="col-sm-5" id="upload-container">
								<center>
									<img src="${ctxStatic}/image/index.png" alt="..." class="img-thumbnail" width="140px;" height="140px;" id="photoImg"/>
									<p style="padding:5px 0 5px 0;color: red;margin: 0">* 只支持jpg,jpeg,png,gif等格式</p>
									<input type="file" name="logoUrlFile" id="logoUrlFile" title="上传头像" class="btn btn-default btn-sm"/>
								</center>
								<script type="text/javascript">
									$(document).ready(function(){
										$('input[type=file]').bootstrapFileInput();
										$("#logoUrlFile").change(function(){
											$(this).upload({
												action:"${ctx}/upload/client",
												oncomplete: function() {
													$("#ajax-loader").remove();
												},
												onsuccess: function(json) {
													$("#photoImg").attr("src",'${baseCtx}'+json.filePath);
												},
												onerror: function(json) {
												},
												onprogress: function(e) {
													$("#upload-container").append("<div class='ajax-loader' id='ajax-loader'></div>");
												} 
											});
										});
									});
								</script>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-9"></label>
							<div class="col-sm-3">
								<button type="submit" class="btn btn-primary btn-sm">保&nbsp;存</button>
								<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">关&nbsp;闭</button>
							</div>
						</div>
				      </form>
			      </div>
			    </div><!-- /.modal-content -->
			  </div><!-- /.modal-dialog -->
		</div>
		
		<script type="text/javascript">
			function addOrUpdateClientEmployee(id){
				if(id!=null){
					$("#clientEmployeeDialog .modal-title").html('编辑客户员工');
				}
				$("#clientEmployeeForm")[0].reset();
				$(".file-input-name").html("");
				$('#clientEmployeeDialog').modal('show');
			}
		</script>
		
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
</body>
</html>
