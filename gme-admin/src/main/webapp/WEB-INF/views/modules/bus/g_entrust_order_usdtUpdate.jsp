<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title>委托订单表（g_entrust_order_usdt）
功能描述：存储币币交易的委托单历史记录。每个交易区生成一张委托订单表。entrust_order_id
修改</title>
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
  </head>
  <body>
  	<form id="formobj" action="${ctx}/bus/g_entrust_order_usdt/update" name="formobj" method="post" class="form-horizontal">
 		<input type="hidden" id="btn_sub" class="btn_sub">
 		<div class="control-group">
        	<label class="control-label Validform_label">委托单号；<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_entrust_order_usdt.order_id" value="${item.order_id}" class="inputxt"  datatype="*1-"  type="text">
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">用户编号；<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_entrust_order_usdt.uid" value="${item.uid}" class="inputxt"  datatype="*1-"  type="text">
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">交易对编号；币种交易对表（g_currency_trade_pair）<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_entrust_order_usdt.pair_id" value="${item.pair_id}" class="inputxt"  datatype="*1-"  type="text">
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">交易类型；1-买入;2-卖出;<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_entrust_order_usdt.entrust_type" value="${item.entrust_type}" class="inputxt"  datatype="*1-"  type="text">
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">下单日期；<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_entrust_order_usdt.order_time" value="${item.order_time}" class="inputxt"  datatype="*1-"  type="text">
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">价格(USDT)；这个价格就是USDT的价格<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_entrust_order_usdt.entrust_price" value="${item.entrust_price}" class="inputxt"  datatype="*1-"  type="text">
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">订单量；交易币种的挂单量<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_entrust_order_usdt.entrust_amount" value="${item.entrust_amount}" class="inputxt"  datatype="*1-"  type="text">
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">已成交数量；<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_entrust_order_usdt.finished_amount" value="${item.finished_amount}" class="inputxt"  datatype="*1-"  type="text">
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">未成交数量；<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_entrust_order_usdt.unfinished_amount" value="${item.unfinished_amount}" class="inputxt"  datatype="*1-"  type="text">
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">订单状态；1-委托中;2-全部成交;3-部分成交;4撤销;<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_entrust_order_usdt.order_status" value="${item.order_status}" class="inputxt"  datatype="*1-"  type="text">
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">订单完成日期；委托下单日期 / 格式:yyyy-MM-dd HH:ss:mm<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_entrust_order_usdt.order_finished_time" value="${item.order_finished_time}" class="inputxt"  datatype="*1-"  type="text">
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">备注<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_entrust_order_usdt.remark" value="${item.remark}" class="inputxt"  datatype="*1-50"  type="text">
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">数据表版本,默认1<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_entrust_order_usdt.version" value="${item.version}" class="inputxt"  datatype="*1-"  type="text">
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">创建时间格式:yyyy-MM-dd HH:ss:mm<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_entrust_order_usdt.create_time" value="${item.create_time}" class="inputxt"  datatype="*1-"  type="text">
	        </div>
      	</div>
 		<div class="control-group">
        	<label class="control-label Validform_label">更新时间格式:yyyy-MM-dd HH:ss:mm<font color='red'>*</font>：</label>
	        <div class="controls">
	        	<input name="g_entrust_order_usdt.updated_time" value="${item.updated_time}" class="inputxt"  datatype="*1-"  type="text">
	        </div>
      	</div>
		<input type="hidden" name="g_entrust_order_usdt.entrust_order_id" value="${item.entrust_order_id}"/>
	</form>
  </body>
</html>
