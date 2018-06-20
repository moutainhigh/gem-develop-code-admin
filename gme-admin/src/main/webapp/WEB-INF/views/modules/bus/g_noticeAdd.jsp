<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title>通知公告新增</title>
	<%@ include file="/WEB-INF/views/include/head.jsp"%> 
	<script type="text/javascript">
	  $(function(){$("#formobj").Validform({
		  tiptype:4,
		  btnSubmit:"#btn_sub",
		  btnReset:"#btn_reset",
		  ajaxPost:true,
		  callback:function(data){
		   var win = frameElement.api.opener;
		   if(data.success==true){
			  frameElement.api.close();win.tip(data.msg);
		   }else{
		   	 tip(data.msg);
			 return false;
		   }
		   win.reloadTable();
		 }
		});});
	</script>
	<script type="text/javascript">
		var editor;  
	    $(function() {  
	          editor = KindEditor.create('textarea[name="g_notice.txt_id_cn"]',{resizeType : 1,width:"117%",height:"200px",afterChange:function(){  
	              this.sync();  
	           },afterBlur:function(){  
	               this.sync();  
	           }});  
	    });  
	</script>
	<script type="text/javascript">
		var editor;  
	    $(function() {  
	          editor = KindEditor.create('textarea[name="g_notice.txt_id_en"]',{resizeType : 1,width:"117%",height:"200px",afterChange:function(){  
	              this.sync();  
	           },afterBlur:function(){  
	               this.sync();  
	           }});  
	    });  
	</script>
  </head>
  <body>
  	<form id="formobj" action="${ctx}/bus/g_notice/add" name="formobj" method="post" class="form-horizontal">
 		<input type="hidden" id="btn_sub" class="btn_sub">
 		<div class="control-group">
        	<label class="control-label Validform_label">类型<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<select name = "g_notice.type">
	        		<option value="1">官方公告</option>
	        		<option value="2">行业资讯</option>
	        	</select>
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">标题<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_notice.title_cn" value="" class="inputxt" datatype="*1-300"  type="text">
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">标题(英文)<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_notice.title_en" value="" class="inputxt" datatype="*1-300"  type="text">
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">内容<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<textarea rows="3" style="width:400px;" name="g_notice.txt_id_cn"></textarea>  
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">内容(英文)<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<textarea rows="3" style="width:400px;" name="g_notice.txt_id_en"></textarea>  
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">来源<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_notice.source" value="" class="inputxt" datatype="*1-200"  type="text">
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">操作人编号<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_notice.sys_uid" value="" class="inputxt" datatype="n1-36"  type="text">
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">操作人名称<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_notice.sys_name" value="" class="inputxt" datatype="*1-50"  type="text">
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">备注<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_notice.remark" value="" class="inputxt" datatype="*1-50"  type="text">
	        </div>
      	</div>
	</form>
  </body>
</html>
