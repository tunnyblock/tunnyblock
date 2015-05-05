<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
	<head>
		<title>我的工作台</title>
		<meta name="decorator" content="default" />
		<!-- iCheck -->
		<link href="${ctxStatic}/icheck/flat/green.css" rel="stylesheet">
		<script src="${ctxStatic}/icheck/icheck.js"></script>
		<script type="text/javascript" src="${ctxStatic}/js/simplejsmap.js"></script>
		<script type="text/javascript">
			//屏蔽validate的默认值
			$.validator.setDefaults({
				 submitHandler: function(form) {
				 	 $(form).spin();
					 form.submit();
				 }
			});
			
			$(document).ready(function(){
				//时间控件
				$(".datepicker").datepicker({
					format:'yyyy-mm-dd',
					startDate: 'today',
					language: "zh-CN"
				});
				
				//表单验证
				$("#inputForm").validate();
				$("#startProcessForm").validate();
				
				//虚拟出场表单验证单独处理
				$("#virtualDepartForm").validate({
					submitHandler:function(form){
						var $tankCode = $("#virtual_depart_tankCode");
						var $clientName = $("#virtual_depart_tank_client_companyChineseName");
						//修改箱号
						if(typeof ($tankCode.attr("readonly"))=="undefined"){
							if($tankCode.val()==$("#old_tankCode").val()){
								alert("箱号未发生变化！");
								return false;
							}
						}
						
						//修改箱子归属
						if(typeof ($clientName.attr("readonly"))=="undefined"){
							if($("#virtual_depart_tank_client_id").val()==$("#old_client_id").val()){
								alert("箱主未发生变化！");
								return false;
							}
						}
						
						$(form).spin();
						form.submit();
					}
				})
				
				//checkbox美化
				$("input").iCheck({
					checkboxClass: 'icheckbox_flat-green',
					radioClass: 'iradio_flat-green'
				});
				$(".all-process-checkbox").on('ifChecked',function(e){
					$(".process-checkbox").iCheck('check');
					$(".disabled-checkbox").iCheck('uncheck');
				}).on('ifUnchecked',function(e){
					$(".process-checkbox").iCheck('uncheck');
					$(".disabled-checkbox").iCheck('uncheck');
				});
				$(".disabled-checkbox").iCheck('disable');
			});
		</script>
	</head>
	<body>
		<div class="wrapper wrapper-content animated fadeInRight">
			<div class="row">
				<div class="col-lg-8">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
                            <h5>任务清单 <a href="#"><i class="fa fa-question-circle"></i></a></h5>
                        </div>
						<div class="ibox-content" id="processiventory-container">
							<div class="row">
								<div class="col-lg-8 col-md-8">
									<form id="searchForm" action="#" method="post" class="form-inline">
										<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
										<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
										<div class="form-group">
											<input type="checkbox" class="all-process-checkbox"/>
											<div class="input-group input-group-sm">
											  <input type="text" class="form-control" placeholder="罐箱号/客户公司/联系人"/>
											  <span class="input-group-addon"><a href="#"><i class="fa fa-search"></i> 查询</a></span>
											</div>
										</div>
									</form>
								</div>
								<div class="col-lg-4  col-md-4">
									<div class="pull-right">
										<div class="btn-group btn-group-sm">
											<button type="button" class="btn btn-white">前5条</button>
										  	<button type="button" class="btn btn-white">后5条</button>
											<button type="button" class="btn btn-white dropdown-toggle btn-sm" data-toggle="dropdown" aria-expanded="false">
												批量操作 <span class="caret"></span>
											</button>
											<ul class="dropdown-menu" role="menu">
												<li><a href="#" id="batch-set-planned-departtime-btn"><i class="fa fa-clock-o"></i> 预设出场时间</a></li>
												<li class="divider"></li>
												<li><a href="#"><i class="fa fa-download"></i> 导出清洗列表</a></li>
												<li><a href="#"><i class="fa fa-download"></i> 导出估价列表</a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<hr class="hr-divider"/>
							<c:forEach items="${page.list}" var="processIventory" varStatus="varStatus">
								<div class="assign-item">
									<div>
										<span class="pull-right text-right"> 
											<span>
												创建者: <strong> ${processIventory.operator.name}</strong>
												<br /> <small><fmt:formatDate value="${processIventory.createTime}" pattern="yyyy/MM/dd"/></small>
											</span> 
										</span>
										<h3 class="m-b-xs">
											罐箱 ${processIventory.tank.tankCode}
										</h3>
										<div>
											<p>
												<a href="#" class="custion-tooptip" data-toggle="tooltip" data-placement="top" title="" data-original-title="虚拟出场">
													<i class="fa fa-mail-forward"></i> ${processIventory.tank.client.companyChineseName}
													<i class="fa fa-user"></i> <i class="fa fa-phone"></i> <i class="fa fa-envelope"></i>
												</a> 
											</p>
											<script type="text/javascript">
												$(document).ready(function(){
													$(".custion-tooptip").tooltip();
												});
											</script>
										</div>
									</div>
									<div class="row">
						        		<div class="col-xs-8 col-sm-8 col-lg-8">
						        			<input type="checkbox" class="process-checkbox <c:if test="${processIventory.isEnded=='1' }">disabled-checkbox</c:if>" value="${processIventory.id}"/>  
							        		<c:forEach items="${processIventory.processList}" var="process">
							        			<c:choose>
							        				<c:when test="${process.state=='2' }">
							        				<button type="button" class="btn btn-success btn-sm">
							        				 	<span class="fa  fa-check-circle-o"></span> <c:if test="${process.isVirtual=='1' }">虚拟</c:if>${process.task.taskName}
							        				</button>
							        				</c:when>
							        				<c:when test="${process.state=='1' }">
							        					<div class="btn-group btn-group-sm">
								        					<button type="button" class="btn btn-warning btn-sm process-button dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
								        						<span class="fa fa-spinner"></span> ${process.task.taskName} <span class="caret"></span>
								        					</button>
								        					 <ul class="dropdown-menu" role="menu">
															  	<li><a type="button" href="${ctx}/process/workbench/customService/endprocess/${process.id}">完成流程</a></li>
																<li>
																	<a type="button" href="${ctx}/process/workbench/customService/${process.id}/comments">发表评论</a>  
																</li>
															  </ul>
														</div>
							        				</c:when>
							        				<c:when test="${process.state=='0' }">
							        					<a type="button" class="btn btn-default btn-sm <c:if test="${not empty  processIventory.currentProcess}">disabled</c:if>" href="javascript:openStartProcessDialog('${process.id}');" ><span class="fa fa-circle-o"></span> ${process.task.taskName}</a>
							        				</c:when>
							        			</c:choose>
							        		</c:forEach>
						        		</div>
						        		<div class="col-xs-4 col-sm-4 col-lg-4">
						        			<div class="pull-right" style="margin:0;">
						        				<div class="btn-group btn-group-sm">
												  <button type="button" class="btn btn-white dropdown-toggle btn-sm <c:if test="${processIventory.isEnded=='1' || not empty  processIventory.currentProcess}">disabled</c:if>" data-toggle="dropdown" aria-expanded="false">
												    	设置 <span class="caret"></span>
												  </button>
												  <ul class="dropdown-menu" role="menu">
												  	<li>
												  		<a href="javascript:openVirtualDepartDialog('${processIventory.id}','${processIventory.tank.tankCode}','${processIventory.tank.client.companyChineseName}','${processIventory.tank.client.id}','virtual_depart_tank_client_companyChineseName');">
												  			<i class="fa fa-wrench"></i> 修改箱子编号
												  		</a>
												  	</li>
													<li>
														<a href="javascript:openVirtualDepartDialog('${processIventory.id}','${processIventory.tank.tankCode}','${processIventory.tank.client.companyChineseName}','${processIventory.tank.client.id}','virtual_depart_tankCode');">
															<i class="fa fa-wrench"></i> 修改箱子归属
														</a>
													</li>
													<li class="divider"></li>
												    <li><a href="javascript:popBatchSetPlannedDepartTimeDialog('${processIventory.id}');" ><i class="fa fa-clock-o"></i> 预设出场时间</a></li>
												    <li class="divider"></li>
												     <li><a href="${ctx}/process/workbench/customService/reassignprocess/${processIventory.id}" ><i class="fa fa-cog"></i> 重新设定流程</a></li>
												  </ul>
												</div>
												
						        				<div class="btn-group btn-group-sm">
												  <button type="button" class="btn btn-white dropdown-toggle btn-sm" data-toggle="dropdown" aria-expanded="false">
												    	详情 <span class="caret"></span>
												  </button>
												  <ul class="dropdown-menu" role="menu">
												  	<li><a type="button" href="${ctx}/process/workbench/customService/${processIventory.id}/serviceDetail">服务详情</a></li>
													<li class="disabled" >
														<!--<a type="button" href="${ctx}/process/workbench/customService/${processIventory.id}/chargeDetail">费用详情</a>  -->
														<a type="button" href="javascript:void(0)">费用详情</a>  
													</li>
												  </ul>
												</div>
		        							</div>
						        		</div>
									</div>
									<div>
										<small class="pull-right"> 
											<i class="fa fa-clock-o"></i> 预计出场时间 <fmt:formatDate value="${processIventory.plannedDepartTime}" pattern="yyyy/MM/dd"/>
										</small>
										<jsp:useBean id="nowDate" class="java.util.Date" />
										<c:if test="${not empty processIventory.approachExamination}">
											<c:set var="interval" value="${nowDate.time - processIventory.approachExamination.createdTime.time}"/>
										</c:if>
										
										<c:if test="${not empty processIventory.emergencyMaintenance}">
											<c:set var="interval" value="${nowDate.time - processIventory.emergencyMaintenance.generateTime.time}"/>
										</c:if>
										
										<span> 截至今天，我们已经为您服务<fmt:formatNumber value="${interval/1000/60/60/24}" pattern="#0"/>天.</span>
									</div>
								</div>
								<c:if test="${not  varStatus.last}">
									<hr class="hr-divider"/>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
				
				<div class="col-lg-4">
					<%@include file="/WEB-INF/views/include/custom-plugin.jsp" %>
					<%@include file="/WEB-INF/views/include/messages.jsp" %>
				</div>
			</div>
		</div>
		<div class="footer">
			<div>
				<strong>Copyright</strong> ISO Tank&copy; 2014-2015
			</div>
		</div>
		
		<!-- 批量预设出场时间 -->
		<div class="modal fade bs-example-modal-sm" id="batchSetPlannedDepartTimeDialog" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
		    <div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4>预设出场时间</h4>
					</div>
						<div class="modal-body" style="padding-bottom: 0;">
							<form action="${ctx}/process/workbench/customService/batchsetplanneddeparttime" method="post" class="form-horizontal" id="inputForm">
								<input type="hidden" id="processIventorys" name="processIventorys"/>
								<div class="form-group">
									<label class="control-label col-sm-3" for="remarks">预计出场日期 * :</label>
									<div class="col-sm-9">
										<input id="plannedDepartTime" type="text" maxlength="200" class="form-control input-sm datepicker required" name="plannedDepartTime" />
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-2" for="remarks"></label>
									<div class="col-sm-10">
										<div class="pull-right">
											<button type="submit" href="#" class="btn btn-primary btn-sm" >确定</button>
											<button href="#" class="btn btn-default btn-sm" data-dismiss="modal">取消</button>
										</div>
									</div>
								</div>
							</form>
						</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			/*
				弹出指设置出场时间对话框
			*/
			function popBatchSetPlannedDepartTimeDialog(selectIds){
				$("#processIventorys").val(selectIds);
				$('#batchSetPlannedDepartTimeDialog').modal('show')
			}
			
			$(document).ready(function(){
				$("#batch-set-planned-departtime-btn").click(function(){
					var $processiventoryContainer = $("#processiventory-container");
					var selectProcessIventory = new Array();
					var $processIventoryArray = $(".checked",$processiventoryContainer);
					if($processIventoryArray.size()==0|| typeof $processIventoryArray=="undefined"){
						BootstrapDialog.show({
				            title: '系统提示',
				            message: '请至少选择一个流程清单！'
				        });
						return false;
					}else{
						$($processIventoryArray).each(function(i,item){
							var $inputItem = $(item).find('input[type="checkbox"]');
							if($inputItem.hasClass("process-checkbox")){
								selectProcessIventory.push($inputItem.val());
							}
						});
						popBatchSetPlannedDepartTimeDialog(selectProcessIventory.join(','));
					}
				});
			});
		</script>
		
		<!-- 虚拟出场 -->
		<div class="modal fade bs-example-modal-sm" id="virtualDepartDialog" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
		    	<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4>虚拟出场操作</h4>
					</div>
					<div class="modal-body" style="padding-bottom: 0;">
							<form action="${ctx}/process/workbench/customService/virtualDepart" method="post" class="form-horizontal" id="virtualDepartForm">
								<input type="hidden" id="virtual_depart_processIventoryId" name="processIventoryId"/>
								<div class="form-group">
									<label class="control-label col-sm-2" for="remarks">箱子编号:</label>
									<div class="col-sm-7">
										<input id="virtual_depart_tankCode" type="text" maxlength="200" class="form-control input-sm required 11Length isTankCode" name="tankCode"/>
										<input id="old_tankCode" type="hidden"/>
									</div>
									<div class="col-sm-3">
										<input type="checkbox" id="check_tank_code" value="true"/> 是否验证箱号
										<script type="text/javascript">
											$(document).ready(function(){
												$("#check_tank_code").iCheck('check').on('ifChecked', function(event){
													  $("#virtual_depart_tankCode").addClass("isTankCode");
												}).on('ifUnchecked', function(event){
													$("#virtual_depart_tankCode").removeClass("isTankCode");
												});
											});
										</script>
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-2" for="remarks">箱子归属:</label>
									<div class="col-sm-7">
										<input id="virtual_depart_tank_client_companyChineseName" type="text" maxlength="200" class="form-control input-sm required" name="client.companyChineseName"/>
										<input id="virtual_depart_tank_client_id" type="hidden" maxlength="200" class="form-control input-sm" name="client.id"/>
										<input id="old_client_id" type="hidden"/>
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-2" for="remarks"></label>
									<div class="col-sm-10">
										<div class="pull-right">
											<button type="submit" href="#" class="btn btn-primary btn-sm" >确定</button>
											<button href="#" class="btn btn-default btn-sm" data-dismiss="modal">取消</button>
										</div>
									</div>
								</div>
							</form>
						</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			function openVirtualDepartDialog(processIventoryId,tankCode,tankClientName,tankClientId,readonlyElement){
				$("#virtual_depart_tank_client_companyChineseName").removeAttr("readonly");
				$("#virtual_depart_tankCode").removeAttr("readonly");
				$("#old_tankCode").val(tankCode);
				$("#old_client_id").val(tankClientId);
				$(".error",$("#virtualDepartForm")).remove();
				
				$("#virtual_depart_processIventoryId").val(processIventoryId);
				$("#virtual_depart_tankCode").val(tankCode);
				$("#virtual_depart_tank_client_companyChineseName").val(tankClientName);
				$("#virtual_depart_tank_client_id").val(tankClientId);
				$("#"+readonlyElement).attr("readonly","readonly");
				$("#virtualDepartDialog").modal("show");
			}
			
			//26位箱号代码
			var map = simplejsmap.createMap();
			map.add("A",10);map.add("B",12);map.add("C",13);map.add("D",14);map.add("E",15);map.add("F",16);map.add("G",17);map.add("H",18);map.add("I",19);map.add("J",20);
			map.add("K",21);map.add("L",23);map.add("M",24);map.add("N",25);map.add("O",26);	map.add("P",27);	map.add("Q",28);map.add("R",29);map.add("S",30);	map.add("T",31);
			map.add("U",32);map.add("V",34);	map.add("W",35);map.add("X",36);map.add("Y",37);map.add("Z",38);		
			
			//验证箱号方法
			function validateTankCode(value){
				var length = value.length;
				if(length!=11)
					return false;
				
				//总和
				var totalValue=0;
				//验证前4位
				for(var i=0;i<4;i++){
					var codeKey = value[i].toUpperCase();
					var codeValue = map.get(codeKey);
					if(codeValue==null || typeof codeValue =='undefined'){
						return false;
					}
					totalValue+= codeValue*Math.pow(2,i);
				}
				
				//验证后6位
				for(var i=4;i<10;i++){
					var codeKey = parseInt(value[i]);
					var reg = new RegExp("^[0-9]*$");
					if(!reg.test(codeKey)){
						return false;
					}
					totalValue+= codeKey*Math.pow(2,i);
				}
				return (totalValue%11)==value[10];
			}
			
			$(document).ready(function(){
				//11位箱号验证规则
				jQuery.validator.addMethod("11Length", function(value, element) {
					var lengh = value.length;
				     return this.optional(element) || (lengh==11);       
				}, "* 箱号必须是11位代码");
				
				// 箱号验证    
				jQuery.validator.addMethod("isTankCode", function(value, element) {       
				     return this.optional(element) || validateTankCode(value);       
				}, "* 请输入正确的11位箱号代码");
				
				//客户公司
				$("#virtual_depart_tank_client_companyChineseName").typeahead({
					source:$.parseJSON('${clientList}'),
					autoSelect: true
				}).change(function(){
					var current = $(this).typeahead("getActive");
				    if (current) {
				        $(this).val(current.companyChineseName);
				        $("#virtual_depart_tank_client_id").val(current.id);
				    }
				});
			});
		</script>
		
		<!-- 启动某个流程 -->
		<script type="text/javascript">
			function openStartProcessDialog(processId){
				$("#start-process-id").val(processId);
				$(".error").remove();
				$("#startProcessForm")[0].reset();
				$("#startProcessDialog").modal("show");
			}
		</script>
		<div class="modal fade bs-example-modal-sm" id="startProcessDialog" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4>启动流程</h4>
					</div>
					<div class="modal-body" style="padding-bottom: 0;">
						<form action="${ctx}/process/workbench/customService/startprocess" method="post" class="form-horizontal" id="startProcessForm">
							<input type="hidden" id="start-process-id" name="id"/>
							<div class="form-group">
								<label class="control-label col-sm-2" for="remarks">分配给 * :</label>
								<div class="col-sm-10">
									<select name="endUser.id" class="form-control input-sm required">
										<option value="">请指定完成用户</option>
										<c:forEach items="${userList}" var="user">
											<option value="${user.id}">${user.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-2" for="remarks">截止日期*:</label>
								<div class="col-sm-10">
									<input name="deadline" class="form-control input-sm required datepicker" readonly="readonly"/>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-2" for="remarks"></label>
								<div class="col-sm-10">
									<div class="pull-right">
										<button type="submit" href="#" class="btn btn-primary btn-sm" >确定</button>
										<button href="#" class="btn btn-default btn-sm" data-dismiss="modal">取消</button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		
	</body>
</html>