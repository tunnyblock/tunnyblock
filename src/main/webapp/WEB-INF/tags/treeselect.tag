<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="隐藏域名称（ID）"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="隐藏域值（ID）"%>
<%@ attribute name="labelName" type="java.lang.String" required="true" description="输入框名称（Name）"%>
<%@ attribute name="labelValue" type="java.lang.String" required="true" description="输入框值（Name）"%>
<%@ attribute name="title" type="java.lang.String" required="true" description="选择框标题"%>
<%@ attribute name="url" type="java.lang.String" required="true" description="树结构数据地址"%>
<%@ attribute name="checked" type="java.lang.Boolean" required="false" description="是否显示复选框"%>
<%@ attribute name="extId" type="java.lang.String" required="false" description="排除掉的编号（不能选择的编号）"%>
<%@ attribute name="notAllowSelectRoot" type="java.lang.Boolean" required="false" description="不允许选择根节点"%>
<%@ attribute name="notAllowSelectParent" type="java.lang.Boolean" required="false" description="不允许选择父节点"%>
<%@ attribute name="module" type="java.lang.String" required="false" description="过滤栏目模型（只显示指定模型，仅针对CMS的Category树）"%>
<%@ attribute name="selectScopeModule" type="java.lang.Boolean" required="false" description="选择范围内的模型（控制不能选择公共模型，不能选择本栏目外的模型）（仅针对CMS的Category树）"%>
<%@ attribute name="allowClear" type="java.lang.Boolean" required="false" description="是否允许清除"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否限制选择，如果限制，设置为disabled"%>
<%@ attribute name="nodesLevel" type="java.lang.String" required="false" description="菜单展开层数"%>
<%@ attribute name="nameLevel" type="java.lang.String" required="false" description="返回名称关联级别"%>

<input id="${id}Id" name="${name}" class="${cssClass}" type="hidden" value="${value}"${disabled eq 'true' ? ' disabled=\'disabled\'' : ''}/>
<input id="${id}Name" name="${labelName}" readonly="readonly" type="text" value="${labelValue}" maxlength="50"${disabled eq "true"? " disabled=\"disabled\"":""}" class="${cssClass}" style="${cssStyle}"/>
<script type="text/javascript">
	$(document).ready(function(){
		var zNodes = [];
		
		//加载数据
		$.ajax({
             type: "GET",
             url: "${ctx}${url}",
             data:{module:"${module}",extId:"${extId}",selectIds:$("#${id}Id").val()},
             dataType: "json",
             success: function(data){
             	zNodes=data;
             }
         });
         
         //点击事件
		$("#${id}Name").click(function(){
		BootstrapDialog.show({
			title:"选择${title}",
            message: function(dialog){
            	var $message = $('<div><ul id="treeData" class="ztree"></ul></div>');
                return $message;
            },
            onshown:function(dialog){
            	var setting = {					
					data: {
						simpleData: {
							enable: true
						}
					}
				};
				if ("${checked}"){
					setting = {
						check: {
							enable: true
						},					
						data: {
							simpleData: {
								enable: true
							}
						}
					};
				}
				$.fn.zTree.init($("#treeData"), setting, zNodes);
            },
            buttons: [{
                label: '确定',
                cssClass: 'btn-primary btn-sm',
                action: function(dialog) {
                   var zTree = $.fn.zTree.getZTreeObj("treeData");
                   var ids = [], names = [], nodes = [];
                   if ("${checked}"){
                       nodes = zTree.getCheckedNodes();
                   }else{
                        nodes = zTree.getSelectedNodes();
                   }
                   for(var i=0; i<nodes.length; i++){
                       ids.push(nodes[i].id);
                       names.push(nodes[i].name);
                   }
                   $("#${id}Id").val(ids);
				   $("#${id}Name").val(names);
                   dialog.close();
                }
            },
            {
                label: '取消',
                cssClass: 'btn-default btn-sm',
                action: function(dialog) {
                   dialog.close();
                }
            }]
        });
	});
	});
</script>
