<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>预录单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic}/bootstrap-autocomplete/bootstrap3-typeahead.js"></script>
	<script type="text/javascript" src="${ctxStatic}/js/simplejsmap.js"></script>
	<script type="text/javascript">
		
		/*
		集装箱校验码校验规则：
		集装箱号由4位公司代码和7位数字组成（如CBHU3202732），其中第七位数字就是校验码。首先将公司代码转换为数字，去掉11及其倍数，连加除以11，其余数为校验位。 
		A=10 B=12 C=13 D=14 E=15 F=16 G=17 H=18 I=19 J=20 K=21 L=23 M=24  
		N=25 O=26 P=27 Q=28 R=29 S=30 T=31 U=32 V=34 W=35 X=36 Y=37 Z=38  
		
		标准箱号构成基本概念：采用ISO6346（1995）标准。标准集装箱箱号由11位编码组成，包括三个部分：
		1、 第一部分由4位英文字母组成。前三位代码 (Owner Code) 主要说明箱主、经营人，第四位代码说明集装箱的类型。列如CBHU 开头的标准集装箱是表明箱主和经营人为中远集运。
		2、 第二部分由6位数字组成。是箱体注册码（Registration Code）, 用于一个集装箱箱体持有的唯一标识。3、 第三部分为校验码（Check Digit）由前4位字母和6位数字经过校验规则运算得到，
		用于识别在校验时是否发生错误。即第11位数字。 根据校验规则箱号的每个字母和数字都有一个运算的对应值。箱号的前10位字母和数字的对应值从0到Z对应数值为0到38，11、22、33不能对11取模数，所以要除去。.
		2、第N位的箱号对应值再分别乘以2的（N－1）次方 （N＝1，2，3………..10）
		例如：箱号为CBHU3202732的集装箱它的第1位代码为C，
		它的代码值＝代码的对应值×2的（1－1）次方 ＝13×1＝13。
		类推第2位代码为B
		它的代码值＝代码的对应值×2的（2－1 ）次方＝12×2＝24 以此类推得到箱号前10位代码的代码值,将前10位的代码值乘积累加后对11取模箱号为CBHU3202732的集装箱前10位箱号的代码累加值＝4061，取11的模后为2，
		就是这个箱号第11位的识别码的数值。
		以此类推，就能得到校验码。
		*/
		
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
		
			
		$(document).ready(function() {
			$("#tankcode").focus();
			$("#inputForm").validate();
			
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
			
			//客户公司
			$("#clientName").typeahead({
				source:$.parseJSON('${clientList}'),
				autoSelect: true
			}).change(function(){
				var current = $(this).typeahead("getActive");
			    if (current) {
			        $(this).val(current.name);
			        $("#clientId").val(current.id);
			        //Ajax获取该客户公司的员工列表
			        $.ajax({
			        	type:"get",
			        	url:"${ctx}/client/clientEmployee/"+current.id+"/employees",
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

			//前装货物自动填充
			var $input = $('#autocompleteInput');
			$input.typeahead({
				source:$.parseJSON('${cleanGoodsList}'),
				autoSelect: true
			}); 
			$input.change(function() {
			    var current = $input.typeahead("getActive");
			    if (current) {
			        $(this).val(current.name);
			        $("#cleanGoodsId").val(current.id);
			        $("#dangerousGoodsCode").val(current.dangerousGoodsCode);
			    }
			});
			
			//时间控件
			$("#expectedApproachTime").datepicker({
				format:'yyyy-mm-dd',
				startDate: 'today',
				language: "zh-CN"
			});
		});
	</script>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
                <div class="col-lg-12">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>新建预录单</h5>
                        </div>
                        <div class="ibox-content">
							<form:form id="inputForm" modelAttribute="preorder" action="${ctx}/process/preorder/save" method="post" class="form-horizontal">
								<form:hidden path="id"/>
								<div class="form-group">
									<label class="control-label col-sm-2" for="name">箱号*:</label>
									<div class="col-sm-8">
										<input id="tankcode" type="text" maxlength="200" class="form-control input-sm required 11Length isTankCode" 
											name="tank.tankCode" value="${empty preorder.tank?'':preorder.tank.tankCode}" onblur="upCaseTankCode();"/>
										<script type="text/javascript">
											function upCaseTankCode(){
												var $tankCode = $("#tankcode");
												$tankCode.val($tankCode.val().toUpperCase());
											}
										</script>
									</div>
									<div class="col-sm-2">
										 <div class="checkbox checkbox-inline">
											 <input type="checkbox"  id="isValidateTankCode" name="isValidateTankCode" checked="checked"/>
						                     <label for="isValidateTankCode"> 是否验证箱号</label>
					                     </div>
									</div>
								</div>
								<div class="hr-line-dashed"></div>
								<div class="form-group">
									<label class="control-label col-sm-2" for="name">客户归属:</label>
									<div class="col-sm-8">
										<input id="clientName" type="text" maxlength="200" class="form-control input-sm required" value="${empty preorder.client?'':preorder.client.companyChineseName}" name="client.companyChineseName"/>
										<input id="clientId" type="hidden" value="${empty preorder.client?'':preorder.client.id}" name="client.id">
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-2" for="name">联&nbsp;系&nbsp;人:</label>
									<div class="col-sm-8">
										<select name="clientContacter.id" id="clientContacterId" class="form-control input-sm required">
											<option value="">请选择联系人</option>
										</select>
									</div>
								</div>
								 <div class="hr-line-dashed"></div>
								<div class="form-group">
									<label class="control-label col-sm-2" for="name">前&nbsp;装&nbsp;货:</label>
									<div class="col-sm-2">
										<input id="autocompleteInput" type="text" maxlength="200" class="form-control input-sm typeahead" value="${empty preorder.cleanGoods?'':preorder.cleanGoods.name}" name="cleanGoods.name"/>
										<input id="cleanGoodsId" type="hidden" value="${empty preorder.cleanGoods?'':preorder.cleanGoods.id}" name="cleanGoods.id"/>
									</div>
									<div class="col-sm-2">
										<input id="dangerousGoodsCode" type="text" maxlength="200" class="form-control input-sm" name="cleanGoods.dangerousGoodsCode" value="${empty preorder.cleanGoods?'':preorder.cleanGoods.dangerousGoodsCode}"/>
									</div>
								</div>
								<div class="hr-line-dashed"></div>
								<div class="form-group">
									<label class="control-label col-sm-2" for="name">预计进场时间:</label>
									<div class="col-sm-8">
										<fmt:formatDate value="${preorder.expectedApproachTime}" pattern="yyyy-MM-dd" var="expectedApproachTimeStr"/>
										<form:input id="expectedApproachTime" path="expectedApproachTime" type="text" maxlength="200" 
											class="form-control input-sm" readonly="true" value="${expectedApproachTimeStr}"/>
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-2" for="name">进场目的*:</label>
									<div class="col-sm-8">
										<c:forEach var="item" items="${allApproachAimList}" varStatus="varStatus">
											<div class="checkbox checkbox-inline">
						                       <form:checkbox path="approachAimIdList" value="${item.id}" label="${item.name }" cssClass="required"/>
						                    </div>
						                    <c:if test="${varStatus.index%6==5}">
						                    	<br/>
						                    </c:if>
										</c:forEach>
									</div>
								</div>
								<div class="hr-line-dashed"></div>
								<div class="form-group">
									<label class="control-label col-sm-2" for="remarks">备注:</label>
									<div class="col-sm-8">
										<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="form-control input-sm"/>
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-2"></label>
									<div class="col-sm-8">
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
