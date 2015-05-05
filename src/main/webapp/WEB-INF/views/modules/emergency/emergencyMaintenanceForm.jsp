<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>应急维修管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic}/js/simplejsmap.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			
			//11位箱号验证规则
			jQuery.validator.addMethod("11Length", function(value, element) {
				var lengh = value.length;
			     return this.optional(element) || (lengh==11);       
			}, "* 箱号必须是11位代码");
			
			// 箱号验证    
			jQuery.validator.addMethod("isTankCode", function(value, element) {       
			     return this.optional(element) || validateTankCode(value);       
			}, "* 请输入正确的11位箱号代码");
			
			//是否需要验证国际标准
			$("#isValidateTankCode").change(function(){
				var $tankcode = $("#tankcode");
				if($tankcode.hasClass("isTankCode")){
					$tankcode.removeClass("isTankCode")
				}else{
					$tankcode.addClass("isTankCode")
				}
			});
			
			$("#inputForm").validate();
		});
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
	</script>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
                <div class="col-lg-12">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>应急维修 <small>外派出勤维修单.</small></h5>
                        </div>
                        <div class="ibox-content">
                            <form:form id="inputForm" modelAttribute="emergencyMaintenance" action="${ctx}/emergency/emergencyMaintenance/save" method="post" class="form-horizontal">
                                <div class="form-group">
                                	<label class="col-sm-2 control-label">箱号*</label>
                                    <div class="col-sm-8"><input type="text" class="form-control required 11Length isTankCode" name="tankCode" id="tankcode"></div>
                                   <div class="col-sm-2">
										 <div class="checkbox checkbox-inline">
											 <input type="checkbox"  id="isValidateTankCode" name="isValidateTankCode" checked="checked"/>
						                     <label for="isValidateTankCode"> 是否验证箱号</label>
					                     </div>
									</div>
                                </div>
                                <div class="hr-line-dashed"></div>
                                <div class="form-group"><label class="col-sm-2 control-label">客户 *</label>
                                    <div class="col-sm-8">
	                                    <select name="client.id" class="form-control m-b required" id="clientId">
	                                    	<option value="">请选择客户</option>
	                                        <c:forEach items="${clientList}" var="client">
												<option value="${client.id}">${client.companyChineseName}</option>
											</c:forEach>
	                                    </select>
	                                    <script type="text/javascript">
	                                    	$(document).ready(function(){
	                                    		$("#clientId").change(function(){
	                                    			if($(this).val()!=""){
	                                    				//Ajax获取该客户公司的员工列表
												        $.ajax({
												        	type:"get",
												        	url:"${ctx}/client/clientEmployee/"+$(this).val()+"/employees",
												        	dataType:'json',
												        	success:function(data){
												        		$("#clientContacterId").empty();
												        		$("#clientContacterId").append('<option value="">请选择联系人</option>');
												        		$(data).each(function(i,item){
												        			$("#clientContacterId").append('<option value="'+item.id+'">'+item.chineseName+'</option>');
												        		});
												        	}
												        });
	                                    			}
	                                    		});
	                                    	});
	                                    </script>
                                    </div>
                                </div>
                                <div class="hr-line-dashed"></div>
                                <div class="form-group"><label class="col-sm-2 control-label">联系人 *</label>
                                    <div class="col-sm-8">
	                                    <select name="clientContacter.id" class="form-control m-b" id="clientContacterId">
	                                    	<option value="">请选择联系人</option>
	                                    </select>
                                    </div>
                                </div>
                                <div class="hr-line-dashed"></div>
                                <div class="form-group"><label class="col-sm-2 control-label">指派给 *</label>
                                    <div class="col-sm-8">
                                    	 <select name="assignToUser.id" class="form-control m-b required">
                                    	 	<option value="">请选择指派者</option>
	                                        <c:forEach items="${userList}" var="user">
												<option value="${user.id}">${user.name}</option>
											</c:forEach>
	                                    </select>
                                    </div>
                                </div>
                                <div class="hr-line-dashed"></div>
                                <div class="form-group">
									<label class="control-label col-sm-2" for="remarks">备注:</label>
									<div class="col-sm-8">
										<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="form-control input-sm"/>
									</div>
								</div>
                                <div class="hr-line-dashed"></div>
                                <div class="form-group">
                                    <div class="col-sm-4 col-sm-offset-2">
                                        <input id="btnSubmit" class="btn btn-primary btn-sm" type="submit" value="保 存"/>&nbsp;
										<input id="btnCancel" class="btn btn-default btn-sm" type="button" value="返 回" onclick="history.go(-1)"/>
                                    </div>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
		<%@include file="/WEB-INF/views/include/footer.jsp" %>
	</div>
</body>
</html>
