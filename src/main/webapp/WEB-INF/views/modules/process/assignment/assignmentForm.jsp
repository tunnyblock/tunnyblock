<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>设定内部流程</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/jquery-dragsort/jquery.dragsort-0.5.2.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#inputForm").validate({
				submitHandler: function(form) {
					var data = $("#list1 li div").map(function() { return $(this).attr("task-id"); }).get();
					$("input[name=list1SortOrder]").val(data.join(","));
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
		
		<form:form id="inputForm" action="${ctx}/process/assignment/save" method="post" class="form-horizontal">
			<div class="row">
					<input type="hidden" name="id" value="${approachExamination.id}">
					<!-- 箱子基本信息 -->
					<div class="col-lg-12">
						<div class="ibox float-e-margins">
							<div class="ibox-title">
								<h5>内部流程设定<small> 箱号 ${approachExamination.tank.tankCode}</small></h5>
							</div>
							<div class="ibox-content">
								<div class="form-group">
									<div class="col-sm-12">
										<h5>预计出场时间 * </h5>
										<input id="plannedDepartTime" name="plannedDepartTime" class="form-control input-sm required" readonly="true" style="width: 200px;margin: 0 0 0 20px;"/>
										<script type="text/javascript">
											$(function(){
												//时间控件
												$("#plannedDepartTime").datepicker({
													format:'yyyy-mm-dd',
													startDate: 'today',
													language: "zh-CN"
												});
											});
										</script>
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12">
										<h5>预设流程</h5>
										<ul id="list1">
											<li class="fix-item-li">
												<div class="fix-item" id="process-start" task-id="1">
													<center>进场</center>
													<span class="label label-warning index-label">1</span>
												</div>
											</li>
											<c:forEach items="${presupposedTaskList}" var="presupposedTask" varStatus="varStatus">
												<li class="process-item-li">
													<div class="process-item" task-id="${presupposedTask.id}">
														<span class="fa fa-times remove-label"></span>
														<center>${presupposedTask.taskName}</center>
														<span class="label label-warning index-label">${varStatus.index+2}</span>
													</div>
												</li>
											</c:forEach>
											<li class="fix-item-li">
												<div class="fix-item" id="process-end" task-id="2">
													<center>出场</center>
													<span class="label label-warning index-label">${fn:length(presupposedTaskList)+2}</span>
												</div>
											</li>
										</ul>
									</div>
								</div>
								<hr/>
								<div class="form-group">
									<div class="col-sm-12">
										<h5>请选择内部流程</h5>
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
								<!-- save sort order here which can be retrieved on server on postback -->
								<input name="list1SortOrder" type="hidden" value="${presupposedTaskIds}"/>
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
						$("#process-end").parent().before('<li class="process-item-li"><div class="process-item" task-id="'+$(this).attr("task-id")+'"><span class="fa fa-times remove-label"></span><center>'+content+'</center><span class="label label-warning index-label">2</span></div></li>');
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
		</form:form>
	
	  <%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
</body>
</html>
