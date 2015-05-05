<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>费用详情</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		.invoice-table,.invoice-total{
			font-size:12px;
		}
	</style>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		<div style="margin-top: 10px;"></div>
		<div class="row">
			<div class="col-lg-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>费用详情<small></small></h5>
					</div>
					<div class="ibox-content inspinia-timeline">
						<form id="inputForm" action="${ctx}/process/workbench/customService/charge/save" method="post" class="form-horizontal">
							<input type="hidden" name="processIventory.id" value="${processIventory.id}"/>
							<c:set var="totalPrice" value="0"></c:set>
							<c:forEach items="${processIventory.processList}" var="process" varStatus="varStatus">
								<c:if test="${process.task.taskName !='出场'}">
									<div class="timeline-item">
										<div class="row">
											<div class="col-xs-3 date">
												<a href="#" data-toggle="tooltip" data-placement="top" title="删除费用"><i class="fa fa-times"></i></a>
												<script type="text/javascript">
													$(function () {
													  $('[data-toggle="tooltip"]').tooltip();
													});
												</script>
											</div>
											<div class="col-xs-9 content <c:if test="${varStatus.first}">no-top-border</c:if>">
													<p class="m-b-xs">
														<strong>${process.task.taskName}</strong>
													</p>
													
													<c:choose>
														<c:when test="${process.task.taskName =='进场'}">
															<p>进场时间 ：<fmt:formatDate value="${processIventory.createTime}" pattern="yyyy/MM/dd" />  出场时间 ：<fmt:formatDate value="${processIventory.endTime}" pattern="yyyy/MM/dd" /></p>
															<p>箱子共堆存： ${intervalDays} 天 
																  ${process.task.companyChargeInfo.chargeName}：${intervalDays}*${process.task.companyChargeInfo.unitPrice}=<fmt:formatNumber value="${intervalDays*process.task.companyChargeInfo.unitPrice}" type="number"/> 元  记录人：${process.startUser.name}</p>
																  <c:set var="totalPrice" value="${totalPrice+intervalDays*process.task.companyChargeInfo.unitPrice}"></c:set>
															<p>
																费用修改:
																	<select id="${process.id}-${varStatus.index}" name="chargeDeatilList[${varStatus.index}].currencyType" class="form-control input-sm" style="width: 100px;display: inline;">
																		<option value="0">RMB</option>
																		<option value="1">USD</option>
																	</select>
																	<input type="text" class="form-control input-sm currency" style="width: 150px;display: inline;" 
																		name="chargeDeatilList[${varStatus.index}].chargePrice"
																		value="${intervalDays*process.task.companyChargeInfo.unitPrice}"/>
																	<input type="text" class="form-control input-sm" style="width: 250px;display: inline;" placeholder="备注信息" name="remarks"/>
																	<input type="hidden" name="chargeDeatilList[${varStatus.index}].chargeName" value="${process.task.companyChargeInfo.chargeName}"/>
																	<input type="hidden" name="chargeDeatilList[${varStatus.index}].process.id" value="${process.id}"/>
															</p>
														</c:when>
														<c:otherwise>
															<p>
																${process.task.companyChargeInfo.chargeName}：${process.task.companyChargeInfo.unitPrice} 元  记录人：${process.startUser.name}
																<c:set var="totalPrice" value="${totalPrice+process.task.companyChargeInfo.unitPrice}"></c:set>
															</p>
															<p>
																费用修改: 
																<select id="${process.id}-${varStatus.index}" name="chargeDeatilList[${varStatus.index}].currencyType" class="form-control input-sm" style="width: 100px;display: inline;">
																		<option value="0">RMB</option>
																		<option value="1">USD</option>
																</select>
																 <input type="text" class="form-control input-sm currency" style="width: 150px;display: inline;" 
																 	name="chargeDeatilList[${varStatus.index}].chargePrice"
																 	value="${process.task.companyChargeInfo.unitPrice}"/>
																  <input type="text" class="form-control input-sm" style="width: 250px;display: inline;" placeholder="备注信息" name="remarks"/>
																 <input type="hidden" name="chargeDeatilList[${varStatus.index}].chargeName" value="${process.task.companyChargeInfo.chargeName}"/>
																<input type="hidden" name="chargeDeatilList[${varStatus.index}].process.id" value="${process.id}"/>
															</p>
														</c:otherwise>
													</c:choose>
											</div>
										</div>
									</div>
								</c:if>
							</c:forEach>
							
							<div class="timeline-item">
								<div class="row">
									<div class="col-xs-3 date">
										<a href="#" data-toggle="tooltip" data-placement="top" title="添加费用"><i class="fa fa-plus"></i></a>
									</div>
									<div class="col-xs-9 content">
										<p class="m-b-xs">
											<strong>总计</strong>
										</p>
										<p><strong style="font-size:18px;"><i class="fa fa-rmb"></i> <span id="totalPrice"><fmt:formatNumber value="${totalPrice}" pattern="#.00" type="number"/></span> RMB</strong></p>
										<script type="text/javascript">
											$(document).ready(function(){
												$(".currency").blur(function(){
													var $select = $(this).parent().find("select:first-child");
													alert($select.val());
												});
											});
										</script>
										<div class="pull-right">
											<div class="btn-group btn-group-sm">
												<button type="button" class="btn btn-white dropdown-toggle btn-sm" data-toggle="dropdown" aria-expanded="false">
													账单相关 <span class="caret"></span>
												</button>
												<ul class="dropdown-menu" role="menu">
													<li><a href="javascript:openpreviewChargeDialog();">账单预览</a></li>
													<li><a href="javascript:saveForm();">保存账单</a></li>
													<li><a href="#">客户确认</a></li>
													<li><a href="javascript:submitForm();">账单提交</a></li>
												</ul>
												<script type="text/javascript">
													$(document).ready(function() {
														$("#inputForm").validate({
															submitHandler: function(form) {
																form.submit();
															}
														});
													});
													
													function saveForm(){
														$("#inputForm").submit();
													}
													
													function submitForm(){
														BootstrapDialog.confirm({
												            title: '系统提示',
												            message: '账单提交后无法修改，是否继续？',
												            closable: true, 
												            draggable: true, 
												            btnOKLabel: '确定',
												            btnOKClass: 'btn-primary', 
												            btnCancelLabel: '取消',
												            callback: function(result) {
												                if(result) {
												                    //保存账单
												                }
												            }
												        });
													}
												</script>
											</div>
											<a class="btn btn-white btn-sm" onclick="history.go(-1)">返回</a>
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	 	<%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
	
	
	
	<!-- 账单预览 -->
	<script type="text/javascript">
		function openpreviewChargeDialog(){
			$("#previewChargeDialog").modal("show");
		}
	</script>
	<div class="modal fade bs-example-modal-lg" id="previewChargeDialog" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4>账单预览</h4>
				</div>
				<div class="modal-body" style="padding-bottom: 0;">
					<div class="ibox-content" style="border: none;">
                            <div class="row">
                                <div class="col-sm-6">
                                    <h5>From:</h5>
                                    <address>
                                        <strong>上海罐联科技股份有限公司, Inc.</strong><br>
                                        	浙江省宁波市鄞州区<br>
                                        	奥克斯大厦509室<br>
                                        <abbr title="Phone">P:</abbr> (0574) 87232345
                                    </address>
                                </div>

                                <div class="col-sm-6 text-right">
                                    <h4>账单编号.</h4>
                                    <h4 class="text-navy">20150228140000</h4>
                                    <span>To:</span>
                                    <address>
                                        <strong>宁波远洋贸易有限公司, Inc.</strong><br>
                                        	浙江省宁波市北仑区<br>
                                        	xxxxxx大厦<br>
                                        <abbr title="Phone">P:</abbr> (0574) 87232345
                                    </address>
                                    <p>
                                        <span><strong>进场日期:</strong> 2015/02/21</span><br>
                                        <span><strong>出场日期:</strong> 2015/02/28</span>
                                    </p>
                                </div>
                            </div>

                            <div class="table-responsive m-t">
                                <table class="table invoice-table">
                                    <thead>
                                    <tr>
                                        <th>收费条目</th>
                                        <th>总价</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>
                                        	<div><strong>堆存费</strong></div>
                                        </td>
                                        <td><i class="fa fa-rmb"></i> 26.00</td>
                                    </tr>
                                    <tr>
                                       <td>
                                        	<div><strong>清洗费</strong></div>
                                        </td>
                                        <td><i class="fa fa-dollar"></i> 26.00</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div><!-- /table-responsive -->

                            <table class="table invoice-total">
                                <tbody>
                                <tr>
                                    <td><strong>RMB总额 :</strong></td>
                                    <td><i class="fa fa-rmb"></i> 1026.00</td>
                                </tr>
                                <tr>
                                    <td><strong>USD总额 :</strong></td>
                                    <td><i class="fa fa-dollar"></i> 235.98</td>
                                </tr>
                                </tbody>
                            </table>
                            <div class="text-right">
                                <button class="btn btn-primary"><i class="fa fa-rmb"></i> 保存账单</button>
                            </div>
                        </div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
