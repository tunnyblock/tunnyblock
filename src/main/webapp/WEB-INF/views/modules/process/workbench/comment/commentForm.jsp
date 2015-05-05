<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ page import="java.util.Date"%>
<html>
<head>
<title>重新设定流程</title>
<meta name="decorator" content="default" />
<style type="text/css">
	.affix-operation{
		margin-bottom:0;
		display: none;
	}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("#inputForm").validate({
			submitHandler : function(form) {
				form.submit();
			}
		});
	});
</script>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-lg-12">
				<div class="ibox-content forum-post-container">
                            <div class="forum-post-info">
                                <h4><span class="text-navy"><i class="fa fa-globe"></i> 罐箱${process.processIventory.tank.tankCode}</span>  - <span class="text-muted">${process.task.taskName}任务评论列表</span></h4>
                            </div>
                            
                            <c:forEach items="${commentList}" var="item">
                            	<div class="media">
	                                <a href="#" class="forum-avatar">
	                                	<h5>${item.generateUser.name}</h5>
	                                    <div class="author-info">
	                                        <fmt:formatDate value="${item.generateTime}" pattern="yyyy/MM/dd HH:mm" /><br> <br>
	                                    </div>
	                                </a>
	                                <div class="media-body">
	                                    	${item.content}
	                                    	<c:if test="${fn:length(item.affixList)>0}">
	                                    		<div class="media">
			                                        <div class="media-body">
			                                            <h4 class="media-heading"><i class="fa fa-paperclip"></i>  附件列表</h4>
			                                            <div class="photos">
			                                                <c:forEach items="${item.affixList}" var="affix">
																<div style="float: left;padding-right: 15px;">
																	<center>
																		<a href="${baseCtx}${affix.affixUrl}">
																			<c:choose>
																				<c:when test="${affix.isImageType}">
																					<img alt="image" height="88" class="forum-photo" src="${baseCtx}${affix.affixUrl}"/>
																				</c:when>
																				<c:otherwise>
																					<img alt="image" class="forum-photo" src="${ctxStatic}/image/file_extension_${affix.type}.png"/>
																				</c:otherwise>
																			</c:choose>
																		</a>
																		<br>${affix.affixName}
																	</center>
																</div>
															</c:forEach>
			                                            </div>
			                                            <div style="clear: both;"></div>
			                                        </div>
			                                    </div>
	                                    	</c:if>
	                                </div>
	                            </div>
                            </c:forEach>
                            
                             <div class="media">
                                <a href="#" class="forum-avatar">
                                    <h5>${fns:getUser().name}</h5>
                                    <div class="author-info">
                                    	<jsp:useBean id="nowDate" class="java.util.Date" />
                                        <strong><fmt:formatDate value="${nowDate}" pattern="yyyy/MM/dd HH:mm" /></strong>
                                    </div>
                                </a>
                                <div class="media-body">
                                	<form id="inputForm"action="${ctx}/process/workbench/customService/${process.id}/comments/save" method="post">
                                			<input type="hidden" name="process.id" value="${process.id}">
                              				<div class="form-group">
                              					<textarea rows="6" cols="" class="form-control input-sm required" name="content"></textarea>
                              				</div>
                              				<div class="form-group">
                              					<div id="affix-file-container">
                              						
                                                </div>
                                                <div style="clear: both;"></div>
                              				</div>
                              				<div class="form-group">
                              					<input type="file" name="damagePicturePackageFile" id="damagePicturePackageFile" title="点击上传附件" class="btn btn-white btn-sm"/>&nbsp;
                              					<div class="pull-right">
													<input id="btnSubmit" class="btn btn-primary btn-sm" type="submit" value="发表评论"/>&nbsp;
													<input id="btnCancel" class="btn btn-default btn-sm" type="button" value="返回" onclick="history.go(-1)"/>
												</div>
													<script type="text/javascript">
				                            			$(document).ready(function(){
				                            				$("#inputForm").validate();
				                            				$('input[type=file]').bootstrapFileInput();
				                            				
				                            				function setAffixOperation(){
				                            					$(".remove-label").click(function(){
					                            					$(this).parentsUntil(".affix-wraper").fadeOut('slow').remove();
					                            				});
					                            				$(".affix-container").hover(function(){
	                              									$(".affix-operation",this).fadeIn();
	                              								},function(){
	                              									$(".affix-operation",this).fadeOut();
	                              								});
				                            				}
				                            				
				                            				
				                            				//上传附件
				                            				$("#damagePicturePackageFile").change(function(){
												        		$(".file-input-name").remove();
																$(this).upload({
																	action:"${ctx}/upload/client",
																	data:{
																		filepath:'comments',
																		tankcode:'${process.processIventory.tank.tankCode}'
																	},
																	oncomplete: function() {
																		$("#affix-file-container").spin(false);
																	},
																	onsuccess: function(json) {
																		var affixElement='<div style="float: left;padding-right: 15px;" class="affix-wraper">'
									                              							+'<div class="affix-container">'
									                              								+'<center>';
									                              									if(json.isImage=='true'){
									                              										affixElement+='<a href="${baseCtx}'+json.filePath+'"><img alt="image" height="88" class="forum-photo" src="${baseCtx}'+json.filePath+'"/></a>';
									                              									}else{
									                              										affixElement+='<a href="${baseCtx}'+json.filePath+'"><img alt="image" class="forum-photo" src="${ctxStatic}/image/file_extension_'+json.fileType+'.png"/></a>';
									                              									}
										                              								affixElement+='<br/>'+json.fileName
										                              								+'<p class="affix-operation"><a href="${baseCtx}'+json.filePath+'" >下载</a>  <a href="#" class="remove-label">删除</a></p>'
										                              							+'</center>'
										                              							+'<input type="hidden" name="affixFileUrl" value="'+json.filePath+'"/>'
										                              							+'<input type="hidden" name="affixFileName" value="'+json.fileName+'"/>'
										                              							+'<input type="hidden" name="affixFileType" value="'+json.fileType+'"/>'
										                              						+'</div>'
									                              						+'</div>';
																		$("#affix-file-container").append(affixElement);
																		setAffixOperation();
																	},
																	onerror: function(json) {
																	},
																	onprogress: function(e) {
																		$("#affix-file-container").spin();
																	} 
																});
															});
				                            			});
			                            		</script>
											</div>
                            		</form>
                                </div>
                            </div>
                        </div>
			</div>
		</div>
		<%@include file="/WEB-INF/views/include/footer.jsp"%>
	</div>
</body>
</html>
