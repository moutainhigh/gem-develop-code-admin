﻿<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>币种交易对列表</title>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<script type="text/javascript">
	  	$(function() {
	  		$('#dataGrid').datagrid({
				url : '${ctx}/biz/currencyTradePair/list',
				method: 'POST',
				title : '',
				iconCls : '',
				fit : true,
				fitColumns : true,
				pagination : true,
				rownumbers:true,
				pageSize : 20,
				pageList : [ 10,20,30 ],
				nowarp : false,
				border : false,
				idField : 'pairId',
				sortName : '',
				sortOrder : '',
				remotesort: true,
				singleSelect:true,
				toolbar:'#toolDiv',
				frozenColumns : [ [ {
					title : '编号',
					field : 'pairId',
					hidden : true
				} ] ],
				columns : [ [ 
					{
						title : '交易对',
						field : 'pairSymbol',
						width : 150,
						align : 'center'
					},
					{
						title : '币种表的currency_id',
						field : 'currencyId',
						width : 150,
						align : 'center'
					},
					{
						title : '币种平台交易手续费',
						field : 'serviceCharge',
						width : 160,
						align : 'center'
					},
					{
						title : '币种表的token_id',
						field : 'currencyTokenId',
						width : 160,
						align : 'center'
					},
					{
						title : '媒介币平台服务手续费',
						field : 'tokenServiceCharge',
						width : 160,
						align : 'center'
					},
					{
						title : '交易价格上限',
						field : 'tradeMaxPrice',
						width : 150,
						align : 'center'
					},
					{
						title : '交易价格下限',
						field : 'tradeMinPrice',
						width : 150,
						align : 'center'
					},
					{
						title : '交易数量下限',
						field : 'tradeNumberLowerLimit',
						width : 150,
						align : 'center'
					},
					{
						title : '是否启用',
						field : 'isEnable',
						width : 150,
						align : 'center',
						formatter : function(value, row, index)
						 {
							if(value=="0")
							{
								return "<font>否</font>";
							}if(value=="1")
							{
								return "<font>是</font>";
							}
							return value;
						}
					},
					{
						title : '是否推荐',
						field : 'isElite',
						width : 150,
						align : 'center',
						formatter : function(value, row, index)
						 {
							if(value=="0")
							{
								return "<font>否</font>";
							}if(value=="1")
							{
								return "<font>是</font>";
							}
							return value;
						}
					},
					{
						title : '创建时间',
						field : 'createTime',
						width : 160,
						align : 'center',
						formatter :function (value,row,index){
							if (value != null) {
								var currentDate = new Date(value);
								return currentDate.toLocaleDateString();
							}
							return value;
						}
					},
					{
						title : '更新时间',
						field : 'updatedTime',
						width : 160,
						align : 'center',
						formatter :function (value,row,index){
							if (value != null) {
								var currentDate = new Date(value);
								return currentDate.toLocaleDateString();
							}
							return value;
						}
					},
				{
					title : '操作',
					field : '_opt',
					align : 'center',
					width : 100,
					formatter:function (value, row, index){
                        var a = '';var b = '';var c = '';
                        var div = '<div class="dropdown-table" data-row="'+index+'"><a class="dropdown-toggle" href="javascript:;"><i class="fa fa-gear"></i></a>';
						<shiro:hasPermission name="biz:currencyTradePair:view">
							a = '<li><a href="javaScript:void(0);" onclick="detail(\'详情\',\'${ctx}/biz/currencyTradePair/info?id='+row.pairId+'\',null,null)"><i class="fa fa-info-circle"></i>详情</a></li>';
						</shiro:hasPermission>
						<shiro:hasPermission name="biz:currencyTradePair:update">
							b = '<li><a href="javaScript:void(0);" onclick="update(\'修改\',\'${ctx}/biz/currencyTradePair/toUpdate?id='+row.pairId+'\',\'dataGrid\',null,null);"><i class="fa fa-edit"></i>修改</a></li>';
						</shiro:hasPermission>
						<shiro:hasPermission name="biz:currencyTradePair:delete">
							c = '<li><a href="javaScript:void(0);" onclick="deleterow('+row.pairId+')"><i class="fa fa-trash-o"></i>删除</a></li>';
						</shiro:hasPermission>
                        div = '<div class="dropdown-table" data-row="'+index+'"><a class="dropdown-toggle" href="javascript:;"><i class="fa fa-gear"></i></a><ul class="u-menu">' + a + b + c + '</ul></div>';
            			return div;
					}
				}
				] ],
				onClickRow : function(rowIndex, rowData) {
				}
			}).datagrid('getPager').pagination({
				showPageList : true,
				showRefresh : true
			});
	  	});
	  	function reloadTable(){
	  		try{	
				$('#dataGrid').datagrid('reload');	
			}catch(ex){
			}
	  	}
  		function deleterow(id){
            createdialog('删除确认 ', '确定删除该记录吗 ?', '${ctx}/biz/currencyTradePair/delete?id='+id,'dataGrid');
        }
  		function bustripsearch(){
			var queryParams=$('#dataGrid').datagrid('options').queryParams;
			$('#toolDivNew').find('*').each(function(){
				queryParams[$(this).attr('name')]=$(this).val();
			});
			$('#dataGrid').datagrid({url:'${ctx}/biz/currencyTradePair/list',pageNumber:1});
		}
		function searchReset(){ 
			$("#toolDivNew").find(":input").val("");bustripsearch();
		}
		function toAdd(){
			add('新增','${ctx}/biz/currencyTradePair/toAdd','dataGrid',800,500);
		}
	</script>
  </head>
   <body class="psflow-panpel-body">
	  	<table id="dataGrid"></table>
		<div id="toolDiv" style="padding:2px 5px;">
			<div class="psflow-panpel-maintitle">
				<h2 class="psflow-panpel-title"><span>币种交易对管理</span></h2>
			</div>
			<div class="psflow-panpel-tooldiv">
				<div class="tooldiv" id="toolDivNew">
		   			<shiro:hasPermission name="biz:currencyTradePair:view">
		   			<span>是否启用:</span>
		   			<select name="currencyTradePairVO.isEnable">
		   				<option value="">--请选择--</option>
		   				<option value="0">否</option>
	   					<option value="1">是</option>
		   			</select>
		   			<span>是否推荐:</span>
		   			<select name="currencyTradePairVO.isElite">
		   				<option value="">--请选择--</option>
		   				<option value="0">否</option>
	   					<option value="1">是</option>
		   			</select>
		   			<a href="javaScript:void(0);" class="u-btn" onclick="bustripsearch();"><i class="fa fa-search"></i>查询</a>
	        		<a href="javaScript:void(0);" class="u-btn u-btn-cgray" onclick="searchReset();" ><i class="fa fa-refresh"></i>重置</a>
		   			</shiro:hasPermission>
		   			<shiro:hasPermission name="biz:currencyTradePair:add">
			      		<a href="javaScript:void(0);" class="u-btn u-btn-cg" plain="true" id="addBtn" onclick="toAdd();"><i class="fa  fa-fw fa-plus"></i>添加</a>
			      	</shiro:hasPermission>
				</div>
			</div>
		</div>
  </body>
</html>
