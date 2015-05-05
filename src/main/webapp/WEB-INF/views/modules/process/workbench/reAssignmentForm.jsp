<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>重新设定流程</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/jquery-dragsort/jquery.dragsort-0.5.2.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#inputForm").validate({
				submitHandler: function(form) {
					form.submit();
				}
			});
		});
	</script>
	<style type="text/css">
		#list1, #list2 { margin:0px; padding:0px; margin-left:20px;  }
		#list1 li, #list2 li { float:left; padding:5px; }
		.process-item { width:90px; height:50px; border:solid 1px #c2c2c2; background-color:#FFFFFF; text-align:center; padding-top:5px; border-radius:3px;}
		.fix-item{ width:90px; height:50px; border:solid 1px #c2c2c2; background-color:#FFFFFF; text-align:center; padding-top:18px; border-radius:3px;} 
		.index-label{position:relative;bottom:2px;right:-32px;padding: 1px 2px;}
		.remove-label{cursor: pointer;position: relative;left:-36px;top:-4px;}
		.choose-item{cursor: pointer;}
		.placeHolder div {width:90px; height:50px; background-color:white !important; border:dashed 1px gray !important; text-align:center; padding-top:5px; border-radius:3px;}
	</style>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		<div style="margin-top: 10px;"></div>
		<form id="inputForm" action="${ctx}/process/workbench/customService/reassignprocess/save" method="post" class="form-horizontal">
			<input type="hidden" name="processIventoryId" id="processIventoryId" value="${processIventory.id}"/>
			<div class="row">
					<div class="col-lg-12">
						<div class="ibox float-e-margins">
							<div class="ibox-title">
								<h5>内部流程重新设定<small> 箱号 ${processIventory.tank.tankCode}</small></h5>
							</div>
							<div class="ibox-content">
								<div class="form-group">
									<div class="col-sm-12">
										<h4>重置流程</h4>
										<ul id="list1">
											<c:forEach items="${processIventory.processList}" var="process" varStatus="varStatus">
												<c:choose>
													<c:when test="${process.task.taskName=='进场'}">
														<li class="fix-item-li">
															<div class="fix-item" id="process-start" task-id="${process.task.id}" style="background-color: #f6f6f6">
																<center>进场</center>
																<span class="label label-warning index-label">${varStatus.index+1}</span>
																<input name="fixedProcessId" value="${process.id}" type="hidden"/>
															</div>
														</li>
													</c:when>
													<c:when test="${process.task.taskName=='出场'}">
														<li class="fix-item-li">
															<div class="fix-item" id="process-end" task-id="${process.task.id}">
																<center>出场</center>
																<span class="label label-warning index-label">${varStatus.index+1}</span>
																<input name="taskId" value="${process.task.id}" type="hidden"/>
															</div>
														</li>
													</c:when>
													<c:otherwise>
														<c:if test="${process.state=='0'}">
															<li class="process-item-li">
																<div class="process-item" task-id="${process.task.id}">
																	<span class="fa fa-times remove-label"></span>
																	<center>${process.task.taskName}</center>
																	<span class="label label-warning index-label">${varStatus.index+1}</span>
																	<input name="taskId" value="${process.task.id}" type="hidden"/>
																</div>
															</li>
														</c:if>
														<c:if test="${process.state=='2'}">
															<li class="fix-item-li">
																<div class="fix-item" task-id="${process.task.id}" style="background-color: #f6f6f6">
																	<center>${process.task.taskName}</center>
																	<span class="label label-warning index-label">${varStatus.index+1}</span>
																	<input name="fixedProcessId" value="${process.id}" type="hidden"/>
																</div>
															</li>
														</c:if>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</ul>
									</div>
								</div>
								<hr/>
								<div class="form-group">
									<div class="col-sm-12">
										<h4>请选择内部流程</h4>
										<ul id="list2">
											<c:forEach items="${taskList}" var="task">
												<li><div class="fix-item choose-item" task-id="${task.id}">${task.taskName}</div></li>
											</c:forEach>
										</ul>
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-2"></label>
									<div class="col-sm-3 col-sm-offset-8 col-lg-2">
										<input id="btnCancel" class="btn btn-default btn-sm pull-right" type="button" value="返 回" onclick="history.go(-1)"/>
										<input id="btnSubmit" class="btn btn-primary btn-sm pull-right" type="submit" value="保 存" style="margin-right:5px;"/>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
		
			<script type="text/javascript">
				$(document).ready(function(){
					$(".choose-item").click(function(){
						if($('div[task-id="'+$(this).attr("task-id")+'"]',$("#list1")).size()>0){
							BootstrapDialog.show({
					            title: '系统提示',
					            message: '已选择该任务'
					        });
							return false;
						}
						var content = $(this).html();
						$("#process-end").parent().before('<li class="process-item-li"><div class="process-item" task-id="'+$(this).attr("task-id")+'"><span class="fa fa-times remove-label"></span><center>'+content+'</center><span class="label label-warning index-label">2</span><input type="hidden" name="taskId" value="'+$(this).attr("task-id")+'"/></div></li>');
						refreshIndexLabel();
						setRemoveLabelFunction();
					});
					
					setRemoveLabelFunction();
				});
				
				$("#list1").dragsort({ dragSelector: ".process-item", itemSelector:".process-item-li",dragBetween: true, dragEnd: saveOrder, placeHolderTemplate: "<li class='placeHolder process-item-li'><div></div></li>" });
				
				function saveOrder() {
					refreshIndexLabel();
				};
				
				function refreshIndexLabel(){
					$("#list1 div").each(function(index,item){
						$(".index-label",item).html(index+1);
					});
				}
				
				function setRemoveLabelFunction(){
					$(".remove-label").click(function(){
						var $li = $(this).parents("li");
						$li.fadeOut("fast",function(){
							$li.remove();
							refreshIndexLabel();
						});
					});
				};
			</script>
		</form>
	
	  <%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
</body>
</html>
