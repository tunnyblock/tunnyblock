<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ page import="java.util.Date"%>
<html>
<head>
	<title>进场箱检</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		.text-danger{
			margin-bottom:2px;
		}
	</style>
	<script type="text/javascript">
		jQuery.extend(jQuery.validator.defaults, {
		    errorElement: "p",
		    errorClass:"text-danger"
		});
		$(document).ready(function() {
			$("#tankcode").focus();
			$("#inputForm").validate();
			$('input[type=file]').bootstrapFileInput();
			
			
			//客户公司
			$("#clientName").typeahead({
				source:$.parseJSON('${clientList}'),
				autoSelect: true
			}).change(function(){
				var current = $(this).typeahead("getActive");
			    if (current) {
			        $(this).val(current.name);
			        $("#clientId").val(current.id);
			    }
			});
			
			//时间控件
			$(".datepicker").datepicker({
				format:'yyyy-mm-dd',
				startDate: 'today',
				language: "zh-CN"
			});
			
			//文件上传
			$(".btn-upload-img").change(function(){
        		$(".file-input-name").remove();
				$(this).upload({
					action:"${ctx}/upload/client",
					data:{
						filepath:'approachexamine',
						tankcode:'${approachExamination.tank.tankCode}'
					},
					oncomplete: function() {
						$("#"+$(this).attr("link-img-id")).parent().spin(false);
					},
					onsuccess: function(json) {
						$("#"+$(this).attr("link-img-id")).attr('src','${baseCtx}'+json.filePath);
						$("#"+$(this).attr("link-hidden-id")).val(json.filePath);
					},
					onerror: function(json) {
					},
					onprogress: function(e) {
						$("#"+$(this).attr("link-img-id")).parent().spin();
					} 
				});
			});
		});
	</script>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		
		<div style="margin-top: 10px;"></div>
		
		<form:form id="inputForm" modelAttribute="approachExamination" action="${ctx}/process/approachExamination/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<input type="hidden" name="tank.tankCode" value="${approachExamination.tank.tankCode}"/>
			<input type="hidden" name="preorder.id" value="${approachExamination.preorder.id}"/>
			<div class="row">
				<!-- 箱子基本信息 -->
				<div class="col-lg-6">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>箱子基本信息<small>${approachExamination.tank.tankCode}</small></h5>
						</div>
						<div class="ibox-content">
							<div class="form-group">
                       			<div class="col-sm-12">
                       				<label for="clientName">箱子归属：例如NBWD</label>
                       				<input id="clientName" type="text" maxlength="200" class="form-control input-sm" <c:if test="${not empty  approachExamination.tank.client}"> readonly="readonly"</c:if> 
                       					name="tank.client.companyChineseName" value="${approachExamination.tank.client.companyChineseName}"/>
                       				<input id="clientId" type="hidden" name="tank.client.id" value="${approachExamination.tank.client.id}"/>
                       				<c:if test="${empty  approachExamination.tank.client}">
                       					<p class="text-danger">* 预录单未填写箱子归属</p>
                       				</c:if>
                       			</div>
                       		</div>
                       		<div class="form-group">
                       			<div class="col-sm-12">
                       				<label for="approachTime">进场时间：例如2014-12-19</label>
                       				<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
                       				<input id="approachTime" type="text" maxlength="200" class="form-control input-sm required datepicker" required="required" name="createdTime"
                       					value="<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" />"/>
                       			</div>
                       		</div>
                       		<div class="form-group">
                       			<div class="col-sm-6">
                       				<label for="tankCapacity">箱子容量</label>
                       				<input id="tankCapacity" type="text" maxlength="200" class="form-control input-sm required" required="required" name="tank.tankCapacity" 
                       					value="${approachExamination.tank.tankCapacity}"/>
                       			</div>
                       			<div class="col-sm-6">
                       				<label for="tankWeight">箱子重量</label>
                       				<input id="tankWeight" type="text" maxlength="200" class="form-control input-sm" name="tank.tankWeight" value="${approachExamination.tank.tankCapacity}"/>
                       			</div>
                       		</div>
                       		<div class="form-group">
                       			<div class="col-sm-12">
                       				<label for="tank.tankType">箱子类型</label>
                           			<form:select path="tank.tankType" class="form-control input-sm">
										<form:option value="" label="请选择"/>
										<form:option value="0" label="化工罐"/>
										<form:option value="1" label="食品罐"/>
										<form:option value="2" label="气体罐"/>
									</form:select>
                       			</div>
                       		</div>
                       		<div class="form-group">
                       			<div class="col-sm-12">
                       				<label for="manufacturedTime">制造时间：例如2014-12-19</label>
                       				<input id="manufacturedTime" type="text" maxlength="200" class="form-control input-sm datepicker" name="tank.manufacturedTime" 
                       					value="<fmt:formatDate value="${approachExamination.tank.manufacturedTime}" pattern="yyyy-MM-dd" />"/>
                       			</div>
                       		</div>
                       		<div class="form-group">
                       			<div class="col-sm-12">
                       				<label for="lastAnnualInspectTime">上次年检时间：例如2014-12-19</label>
                       				<input id="lastAnnualInspectTime" type="text" maxlength="200" class="form-control input-sm datepicker" name="tank.lastAnnualInspectTime" 
                       					value="<fmt:formatDate value="${approachExamination.tank.lastAnnualInspectTime}" pattern="yyyy-MM-dd" />"/>
                       			</div>
                       		</div>
                       		<div class="form-group">
                       			<div class="col-sm-8">
                       				<label for="nextAnnualInspectTime">下次年检时间：例如2014-12-19</label>
                       				<input id="nextAnnualInspectTime" type="text" maxlength="200" class="form-control input-sm datepicker" name="tank.nextAnnualInspectTime" 
                       					value="<fmt:formatDate value="${approachExamination.tank.nextAnnualInspectTime}" pattern="yyyy-MM-dd" />"/>
                       			</div>
                       			<div class="col-sm-4">
                       				<label for="annualInspectComments">年检描述</label>
                       				<input id="annualInspectComments" type="text" maxlength="200" class="form-control input-sm"
                       					name="tank.annualInspectComments" value="${approachExamination.tank.annualInspectComments}"/>
                       			</div>
                       		</div>
                       		<div class="form-group">
                       			<div class="col-sm-12">
                       				<label for="tankRemarks">备注信息</label>
                       				<textarea id="tankRemarks" rows="4" class="form-control input-sm" placeholder="备注信息" name="tank.remarks" 
                       					value="${approachExamination.tank.remarks}"></textarea>
                       			</div>
                       		</div>
						</div>
					</div>
				</div>
					
				<!-- 箱子配件信息 -->
				<div class="col-lg-6">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>箱子主要配件信息</h5>
						</div>
						<div class="ibox-content">
							<div class="form-group">
								<div class="col-sm-12">
									<label for="airValveType">空气阀类型</label>
									<form:select path="airValveType" class="form-control input-sm">
										<form:option value="" label="请选择"/>
										<form:option value="0" label="1.5英寸螺纹"/>
										<form:option value="1" label="2英寸螺纹"/>
										<form:option value="2" label="1.5英寸法兰"/>
										<form:option value="3" label="2英寸法兰"/>
									</form:select>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-12">
									<label for=topValveType>顶阀类型</label>
									<form:select path="topValveType" class="form-control input-sm">
										<form:option value="" label="请选择"/>
										<form:option value="0" label="3英寸螺纹"/>
										<form:option value="1" label="3英寸法兰"/>
									</form:select>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-12">
									<div class="checkbox checkbox-inline">
										<input type="checkbox" id="haveSafetyValve" 
											<c:if test="${approachExamination.haveSafetyValve=='1' }">checked="true"</c:if>  name="haveSafetyValve" value="1"/>
										<label for="haveSafetyValve">是否有安全阀</label>
				                    </div>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-12">
									<div class="checkbox checkbox-inline">
					                   	<input type="checkbox" id="haveElectricHeat" <c:if test="${approachExamination.haveElectricHeat=='1' }">checked="true"</c:if>  
					                   		name="haveElectricHeat" value="1"/>
										<label for="haveElectricHeat">是否有电加热</label>
				                    </div>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-12">
									<div class="checkbox checkbox-inline">
										<input type="checkbox" id="havePressureGauge" <c:if test="${approachExamination.havePressureGauge=='1' }">checked="true"</c:if>  
											name="havePressureGauge" value="1"/>
										<label for="havePressureGauge">是否有压力表</label>
				                    </div>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-12">
									<div class="checkbox checkbox-inline">
										<input type="checkbox" id="haveThermomter" <c:if test="${approachExamination.haveThermomter=='1' }">checked="true"</c:if>  
											name="haveThermomter" value="1"/>
										<label for="haveThermomter">是否有温度表</label>
				                    </div>
								</div>
							</div>
							<div class="form-group">
	                           		<div class="col-sm-12">
	                           			<form:textarea path="accessoriesComments" rows="4"  cssClass="form-control input-sm" placeholder="备注信息" />
	                           		</div>
	                           </div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="ibox float-e-margins">
						<div class="ibox-title">
							<h5>箱子进场照片信息</h5>
						</div>
						<div class="ibox-content">
							<div class="form-group">
								<div class="col-sm-3">
                           			<center>
                           				<div class="img-container">
	                           				<img src="${ctxStatic}/image/index.png" alt="..." class="img-thumbnail" width="140px;" height="140px;" id="tankLeftPictureImg" style="margin-bottom: 5px;"/>
	                           			</div>
										<input type="file" name="tankLeftPictureFile" id="tankLeftPictureFile" title="上传罐箱左侧照片" 
											class="btn btn-default btn-sm btn-upload-img" link-hidden-id="tankLeftPicture" link-img-id="tankLeftPictureImg"/>
										<input type="hidden" id="tankLeftPicture" name="tankLeftPicture"/>
									</center>
                           		</div>
                           		<div class="col-sm-3">
                           			<center>
                           				<div class="img-container">
	                           				<img src="${ctxStatic}/image/index.png" alt="..." class="img-thumbnail" width="140px;" height="140px;" id="tankRightPictureImg" style="margin-bottom: 5px;"/>
	                           			</div>
										<input type="file" name="tankRightPictureFile" id="tankRightPictureFile" title="上传罐箱右侧照片" 
											class="btn btn-default btn-sm btn-upload-img"  link-hidden-id="tankRightPicture" link-img-id="tankRightPictureImg"/>
										<input type="hidden" id="tankRightPicture" name="tankRightPicture"/>
									</center>
                           		</div>
                           		<div class="col-sm-3">
                           			<center>
                           				<div class="img-container">
	                           				<img src="${ctxStatic}/image/index.png" alt="..." class="img-thumbnail" width="140px;" height="140px;" id="tankTopPictureImg" style="margin-bottom: 5px;"/>
	                           			</div>
										<input type="file" name="tankTopPictureFile" id="tankTopPictureFile" title="上传罐箱顶部照片" 
											class="btn btn-default btn-sm btn-upload-img"  link-hidden-id="tankTopPicture"  link-img-id="tankTopPictureImg"/>
										<input type="hidden" id="tankTopPicture" name="tankTopPicture"/>
									</center>
                           		</div>
                           		<div class="col-sm-3">
                           			<center>
                           				<div class="img-container">
	                           				<img src="${ctxStatic}/image/index.png" alt="..." class="img-thumbnail" width="140px;" height="140px;" id="tankBottomPictureImg" style="margin-bottom: 5px;"/>
	                           			</div>
										<input type="file" name="tankBottomPictureFile" id="tankBottomPictureFile" title="上传罐箱底部照片" 
											class="btn btn-default btn-sm btn-upload-img"  link-hidden-id="tankBottomPicture" link-img-id="tankBottomPictureImg"/>
										<input type="hidden" id="tankBottomPicture" name="tankBottomPicture"/>
									</center>
                           		</div>
							</div>
							
							<div class="form-group">
								<div class="col-sm-3">
                           			<center>
                           				<div class="img-container">
	                           				<img src="${ctxStatic}/image/index.png" alt="..." class="img-thumbnail" width="140px;" height="140px;" id="tankFrontPictureImg" style="margin-bottom: 5px;"/>
	                           			</div>
										<input type="file" name="tankFrontPictureFile" id="tankFrontPictureFile" title="上传罐箱前部照片" 
											class="btn btn-default btn-sm btn-upload-img" link-hidden-id="tankFrontPicture" link-img-id="tankFrontPictureImg"/>
										<input type="hidden" id="tankFrontPicture" name="tankFrontPicture"/>
									</center>
                           		</div>
                           		<div class="col-sm-3">
                           			<center>
                           				<div class="img-container">
	                           				<img src="${ctxStatic}/image/index.png" alt="..." class="img-thumbnail" width="140px;" height="140px;" id="tankBackPictureImg" style="margin-bottom: 5px;"/>
	                           			</div>
										<input type="file" name="tankBackPictureFile" id="tankBackPictureFile" title="上传罐箱后部照片" 
											class="btn btn-default btn-sm btn-upload-img"  link-hidden-id="tankBackPicture" link-img-id="tankBackPictureImg"/>
										<input type="hidden" id="tankBackPicture" name="tankBackPicture"/>
									</center>
                           		</div>
                           		<div class="col-sm-3">
                           			<center>
                           				<div class="img-container">
	                           				<img src="${ctxStatic}/image/index.png" alt="..." class="img-thumbnail" width="140px;" height="140px;" id="tankEntryHolePictureImg" style="margin-bottom: 5px;"/>
	                           			</div>
										<input type="file" name="tankEntryHolePictureFile" id="tankEntryHolePictureFile" title="上传罐箱入孔阀照片" 
											class="btn btn-default btn-sm btn-upload-img"  link-hidden-id="tankEntryHolePicture"  link-img-id="tankEntryHolePictureImg"/>
										<input type="hidden" id="tankEntryHolePicture" name="tankEntryHolePicture"/>
									</center>
                           		</div>
                           		<div class="col-sm-3">
                           			<center>
                           				<div class="img-container">
	                           				<img src="${ctxStatic}/image/index.png" alt="..." class="img-thumbnail" width="140px;" height="140px;" id="tankAirValvePictureImg" style="margin-bottom: 5px;"/>
	                           			</div>
										<input type="file" name="tankAirValvePictureFile" id="tankAirValvePictureFile" title="上传罐箱空气阀照片" 
											class="btn btn-default btn-sm btn-upload-img"  link-hidden-id="tankAirValvePicture" link-img-id="tankAirValvePictureImg"/>
										<input type="hidden" id="tankAirValvePicture" name="tankAirValvePicture"/>
									</center>
                           		</div>
							</div>
							
							<div class="form-group">
								<div class="col-sm-3">
                           			<center>
                           				<div class="img-container">
	                           				<img src="${ctxStatic}/image/index.png" alt="..." class="img-thumbnail" width="140px;" height="140px;" id="tankBottomValvePictureImg" style="margin-bottom: 5px;"/>
	                           			</div>
										<input type="file" name="tankBottomValvePictureFile" id="tankBottomValvePictureFile" title="上传罐箱底阀照片" 
											class="btn btn-default btn-sm btn-upload-img" link-hidden-id="tankBottomValvePicture" link-img-id="tankBottomValvePictureImg"/>
										<input type="hidden" id="tankBottomValvePicture" name="tankBottomValvePicture"/>
									</center>
                           		</div>
                           		<div class="col-sm-3">
                           			<center>
                           				<div class="img-container">
	                           				<img src="${ctxStatic}/image/index.png" alt="..." class="img-thumbnail" width="140px;" height="140px;" id="deliveryPictureImg" style="margin-bottom: 5px;"/>
	                           			</div>
										<input type="file" name="deliveryPictureFile" id="deliveryPictureFile" title="上传设备交接单" 
											class="btn btn-default btn-sm btn-upload-img"  link-hidden-id="deliveryPicture" link-img-id="deliveryPictureImg"/>
										<p class="text-danger"> *（必须司机签字，手机号，车牌号）</p>
										<input type="hidden" id="deliveryPicture" name="deliveryPicture"/>
									</center>
                           		</div>
							</div>
							 <hr/>
							 <div class="form-group">
                            	<div class="col-sm-6"  id="damage-picture-container">
                            		<p class="text-danger">* 如进场时发现箱子损坏，建议发客户确认 <input type="file" name="damagePicturePackageFile" id="damagePicturePackageFile" title="上传举证照片" class="btn btn-default btn-sm"/></p>
                            		<input type="hidden" name="damagePicturePackage" id="damagePicturePackage"/>
                            		<script type="text/javascript">
                            			$(document).ready(function(){
                            				//上传损坏举证照片
                            				$("#damagePicturePackageFile").change(function(){
								        		$(".file-input-name").remove();
												$(this).upload({
													action:"${ctx}/upload/client",
													data:{
														filepath:'approachexamine',
														tankcode:'${approachExamination.tank.tankCode}'
													},
													oncomplete: function() {
														$("#damage-picture-container").spin(false);
													},
													onsuccess: function(json) {
														var $damagePicturePackage = $("#damagePicturePackage").val();
														$("#damagePicturePackage").val($damagePicturePackage+json.filePath+",");
														$("#damage-picture-container").append('<img src="${baseCtx}'+json.filePath+'" alt="..." class="img-thumbnail" width="140px;" height="140px;" id="photoImg" style="margin-bottom: 5px;"/>');
													},
													onerror: function(json) {
													},
													onprogress: function(e) {
														$("#damage-picture-container").spin();
													} 
												});
											});
                            			});
                            		</script>
                            	</div>
                            	<div class="col-sm-6">
                            		<textarea id="remarks" rows="8" class="form-control input-sm" placeholder="备注信息" name="remarks"></textarea>
                            	</div>
                            </div>
							
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2"></label>
				<div class="col-sm-3 col-sm-offset-8 col-lg-2">
					<input id="btnCancel" class="btn btn-default btn-sm pull-right" type="button" value="返 回" onclick="history.go(-1)"/>
					<input id="btnSubmit" class="btn btn-primary btn-sm pull-right" type="submit" value="保 存" style="margin-right:5px;"/>
				</div>
			</div>
		</form:form>
		<%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
</body>
</html>
