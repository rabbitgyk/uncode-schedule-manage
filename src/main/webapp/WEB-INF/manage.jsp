<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = path + "/";
	//String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
		<title>uncode schedule manage</title>

		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="Cache-Control" content="no-store" />
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Expires" content="0" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
	    <title>page</title>
	    <link type="text/css" rel="stylesheet" href="<%=basePath%>static/bootstrap-3.3.0/css/blog.css">
	    <link type="text/css" rel="stylesheet" href="<%=basePath%>static/bootstrap-3.3.0/css/bootstrap.min.css">
	    <link type="text/css" rel="stylesheet" href="<%=basePath%>static/css/extraCSS.css">
	    <script type="text/javascript" src="<%=basePath%>static/jquery-1.11.1/jquery.min.js"></script>
	    <script type="text/javascript" src="<%=basePath%>static/bootstrap-3.3.0/js/bootstrap.min.js"></script>
		<script>
		
			function onLoadPage(){
	    		$.ajax({
		        	type:"get",
		        	async:"true",
		        	url:"<%=basePath%>main/tasks",
		        	error : function(request) {
		    			alert("error!");
		    		},
		    		success:function(data){
		    			var arr = new Array();
	    				$("#table2 tbody").empty();
	    				for(var i=0;i<data.length;i++){
	    					num = i+1;
	    					var tr = "<tr><td>"+num+"</td><td class='targetBean'>"+data[i].targetBean+"</td><td class='targetMethod'>"+data[i].targetMethod+"</td>"+
		    						"<td>"+data[i].type+"</td><td>"+data[i].cronExpression+"</td><td>"+data[i].lastRunningTimeShow+"</td>"+
		    						"<td>"+data[i].period+"</td><td class='spe-td'>"+data[i].currentServer+"</td><td>"+data[i].runTimes+"</td>"+
		    						"<td>"+data[i].lastRunningTimeShow+"</td><td><a href='javascript:void(0)' onclick='delTask($(this))'>删除</a></td></tr>";
		    				$("#table2 tbody").append(tr);
		    				arr.push(data[i].currentServer);
	    				}
	    				$(".spe-td").mouseover(function(){
	    					var inx = $(this).index();
	    				}); 
	    				$(".spe-td").each(function () {
	    		            var td1 = $(this).html().split('$');
	    		            $(this).html(td1[0]+"$.........$"+td1[td1.length-1]);
	    		        });
		    		}
		        }); 
	    	};
	    	
	    	function pageLoading(){
	    		$.ajax({
		        	type:"get",
		        	async:"true",
		        	url:"<%=basePath%>main/tasks",
		        	error : function(request) {
		    			alert("error!");
		    		},
		    		success:function(data){
		    			var arr = new Array();
	    				$("#table3 tbody").empty();
	    				$.ajax({
	    					type:"get",
				        	async:"true",
				        	url:"<%=basePath%>main/server/ips",
				        	error : function(request) {
				    			alert("error!");
				    		},
				    		success:function(data){
				    			for(var i=0;i<data.length;i++){
				    				var options = "<option>"+data[i]+"</option>";
				    				sel = $(".sel");
				    				sel.append(options);
				    			}
				    			
				    		}
	    				})
	    				for(var i=0;i<data.length;i++){
	    					num = i+1;
	    					var tr = "<tr><td>"+num+"</td><td class='targetBeanS'>"+data[i].targetBean+"</td><td class='targetMethodS'>"+data[i].targetMethod+"</td>"+
		    						"<td>"+data[i].type+"</td><td>"+data[i].cronExpression+"</td>"+
		    						"<td>"+data[i].period+"</td><td><select class='sel'></select></td>"+
		    						"<td class='del-tr'><a href='javascript:void (0)' data-toggle='modal' data-target='#myModal2' onclick='showSetTask($(this))'>执行</a></td></tr>";
		    				$("#table3 tbody").append(tr);
		    				arr.push(data[i].currentServer);
	    				}
		    		}
		    	})
		    };
		
		    $(function () {
			    //初始化页面
		    	onLoadPage();
		    	//
		    	$("#item1").click(function(){
		    		onLoadPage();
		    	});
		    	//
		    	$("#item2").click(function(){
		    		pageLoading();
		    	});
		    	//集群节点表格初始化
		        $.ajax({
					type:"get",
		        	async:"true",
		        	url:"<%=basePath%>main/servers",
		        	error : function(request) {
		    			alert("error!");
		    		},
		    		success:function(data){
		    			for(var i=0;i<data.length;i++){
		    				if(data[i].isLeader=="1"){
		    					isLeader = "是";
		    				}else{
		    					isLeader = "否";
		    				}
	    					num = i+1;
	    					var tr = "<tr><td>"+num+"</td><td>"+data[i].serverName+"</td><td>"+isLeader+"</td></tr>";
		    				$("#table1 tbody").append(tr);
	    				}
		    		}
				});
		        $(".blog-nav-item").click(function(){
		            $(this).addClass("active").siblings().removeClass("active");
		            var dj = $(this).index();
		            $(".sign-div .container").eq(dj).show().siblings().hide();
		        });
		        /* $("#myModal").on('show.bs.modal', function(event){
				    var button = $(event.relatedTarget); 
					var titleData = button.data('title'); 
				    var modal = $(this)
			       	modal.find('.modal-title').text(titleData + '定时任务');
			  		}); */
		    });
		    
		    // 删除任务
		    function delTask(aLabel){
		    	var targetBean =  aLabel.parents("tr").find(".targetBean").text();
				var targetMethod = aLabel.parents("tr").find(".targetMethod").text();
		    	$.ajax({
		    		type:"get",
		        	async:"true",
		        	data:{targetBean:targetBean,targetMethod:targetMethod},
		        	url:"<%=basePath%>main/task/del",
		        	error : function(request) {
		    			alert("error!");
		    		},
		    		success:function(data){
		    			if(data.returnCode=="0000"){
		    				//trs[ins].remove();
		    				onLoadPage();
		    			}else{
		    				alert(data.returnMsg);
		    			}
		    		}
		    	});
		    }
		    
		    //新增定时任务
		   function formSubmit(){
				$.ajax({
					type:"post",
		        	async:"true",
		        	data:{targetBean:$("#bean").val(),targetMethod:$("#method").val(),cronExpression:$("#cronExpression").val(),periodShow:$("#period").val(),startTimeShow:$("#startTime").val(),params:$("#param").val()},
		        	url:"<%=basePath%>main/task",
		        	error : function(request) {
		    			alert("error!");
		    		},
		    		success:function(data){
		    			if(data.returnCode=="0000"){
		    				$(".modal-dialog").hide();
			    			$("#myModal").hide();
			    			onLoadPage();
		    			}else{
		    				alert(data.returnMsg);
		    			}
		    		}
				});
			}
		    
		    // 展示执行定时任务弹框的时候，取值并展示
		    function showSetTask(taskRow){
		    	var targetBean =  taskRow.parents("tr").find(".targetBeanS").text();
				var targetMethod = taskRow.parents("tr").find(".targetMethodS").text();
				$("#beanS").attr("value",targetBean);
				$("#methodS").attr("value",targetMethod);
				// 执行节点赋值
				var ip =  taskRow.parents("tr").find(".sel").val();
				$("#executeUrlFront").html("http://"+ip+":");
		    }
		    
		    // 执行任务方法
		    function executeTask(){
		    	var executeUrl = $("#executeUrlFront").html() + $("#executeUrlS").val() + $("#executeUrlEnd").html();
		    	$.ajax({
					type:"post",
		        	async:"true",
		        	data:{bean:$("#beanS").val(),method:$("#methodS").val(),params:$("#paramS").val(),executeUrl:executeUrl},
		        	url:"<%=basePath%>main/task/execute",
		        	error : function(request) {
		    			alert("error!");
		    		},
		    		success:function(data){
		    			if(data.returnCode=="0000"){
		    				$(".modal-dialog").hide();
			    			$("#myModal").hide();
			    			onLoadPage();
		    			}else{
		    				alert(data.returnMsg);
		    			}
		    		}
				});
		    }
		    
		</script>
	</head>

	<body>
    <div class="blog-masthead">
        <div class="container">
            <nav class="blog-nav">
                <a class="blog-nav-item active" href="#" id="item1">Home</a>
                <a class="blog-nav-item" href="#" id="item2">Manual</a>
            </nav>
        </div>
    </div>
    <div class="sign-div">
        <div class="container">
            <h2 class="text-center">uncode schedule 任务调度系统管理界面</h2>
            <table class="table table-bordered table-condensed table-hover" id="table1">
                <caption>集群节点</caption>
                <thead>
                    <tr>
                        <th>序号</th>
                        <th>名称</th>
                        <th>调度节点</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <table class="table table-bordered table-condensed table-hover" id="table2">
                <caption>定时任务列表<button class="add-btn" data-toggle="modal" data-target="#myModal" data-title="新增">添加</button></caption>
                <thead>
                    <tr>
                        <th>序号</th>
                        <th>目标bean</th>
                        <th>目标方法</th>
                        <th>类型</th>
                        <th>cron表达式</th>
                        <th>开始时间</th>
                        <th>周期(毫秒)</th>
                        <th>执行节点</th>
                        <th>执行次数</th>
                        <th>最近执行时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <div class="container" style="display: none">
            <h2 class="text-center">手动执行界面</h2>
            <table class="table table-bordered table-condensed table-hover" id="table3">
                <caption>定时任务列表</caption>
                <thead>
                <tr>
                    <th>序号</th>
                    <th>目标bean</th>
                    <th>目标方法</th>
                    <th>类型</th>
                    <th>cron表达式</th>
                    <th>周期(毫秒)</th>
                    <th>执行节点</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                
                </tbody>
            </table>
        </div>
    </div>
    
    <div id="myModal" class="modal fade in" style="display: none;" aria-hidden="false">
	         <div class="modal-dialog">
	             <div class="modal-content">
	                 <div class="modal-header">
	                     <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                     <h4 class="modal-title">新增定时任务</h4>
	                 </div>
	                 <div class="modal-body">
	 					<div class="container">
	 						<form id="addform" method="post" action="/uncode-schedule-manage/uncode/schedule" class="form-horizontal">
	 						<div class="row">
	 							<div class="col-md-6">
	 									<div class="form-group">
	 										<label class="col-sm-4 control-label" for="bean">bean名称<span style="color:red">*</span></label>
	 										<div class="col-sm-6">
	 											<input id="bean" name="targetBean" class="form-control" required="" type="text">
	 										</div>
	 									</div>
	 									<div class="form-group">
	 										<label class="col-sm-4 control-label" for="method">方法名称<span style="color:red">*</span></label>
	 										<div class="col-sm-6">
	 											<input id="method" name="targetMethod" class="form-control" required="" type="text">
	 										</div>
	 									</div>
	 									<div class="form-group">
	 										<label class="col-sm-4 control-label" for="cronExpression">corn表达式</label>
	 										<div class="col-sm-6">
	 											<input id="cronExpression" name="cronExpression" class="form-control" required="" type="text">
	 										</div>
	 									</div>
	 									<div class="form-group">
	 										<label class="col-sm-4 control-label" for="period">周期（毫秒）</label>
	 										<div class="col-sm-6">
	 											<input id="period" name="periodShow" class="form-control" required="" type="text">
	 										</div>
	 									</div>
	 									<div class="form-group">
	 										<label class="col-sm-4 control-label" for="startTime">开始时间</label>
	 										<div class="col-sm-6">
	 											<input id="startTime" name="startTimeShow" class="form-control" required="" type="text">
	 										</div>
	 									</div>
	 									<div class="form-group">
	 										<label class="col-sm-4 control-label" for="param">参数(字符串)</label>
	 										<div class="col-sm-6">
	 											<input id="param" name="param" class="form-control" required="" type="text">
	 										</div>
	 									</div>
	              		   				<div class="modal-footer">
	               		      				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	               		      				<button type="button" onclick="formSubmit()" class="btn btn-primary">保存</button>
	             	    				</div>
	                 				</div>
	                 			</div>
	 							</form>
	         				</div>
	         			</div>
	         		</div>
	     	</div>
	 	</div>
	 	
	 	
	 	<div id="myModal2" class="modal fade in" style="display: none;" aria-hidden="false">
	         <div class="modal-dialog">
	             <div class="modal-content">
	                 <div class="modal-header">
	                     <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                     <h4 class="modal-title">定时任务</h4>
	                 </div>
	                 <div class="modal-body">
	 					<div class="container">
	 						<form id="addform" method="post" action="/uncode-schedule-manage/uncode/schedule" class="form-horizontal">
	 						<div class="row">
	 							<div class="col-md-6">
	 									<div class="form-group">
	 										<label class="col-sm-2 control-label" for="beanS">bean名称</label>
	 										<div class="col-sm-10">
	 											<input id="beanS" name="bean" class="form-control" type="text" readonly="readonly" >
	 										</div>
	 									</div>
	 									<div class="form-group">
	 										<label class="col-sm-2 control-label" for="methodS">方法名称</label>
	 										<div class="col-sm-10">
	 											<input id="methodS" name="method" class="form-control" type="text" readonly="readonly" >
	 										</div>
	 									</div>
	 									<div class="form-group">
	 										<label class="col-sm-2 control-label" for="paramS">参数</label>
	 										<div class="col-sm-10">
	 											<input id="paramS" name="param" class="form-control" type="text" placeholder="可传入一个参数">
	 										</div>
	 									</div>
	 									<div class="form-group">
	 										<label class="col-sm-2 control-label" for="param">执行url</label>
	 										<div class="input-group col-sm-10">
												<span class="input-group-addon" id="executeUrlFront">http://192.168.7.230:</span>
												<input id="executeUrlS" name="executeUrl" class="form-control" type="text" placeholder="端口/项目名称">
												<span class="input-group-addon" id="executeUrlEnd">/schedule/manual</span>
											</div>
	 									</div>
										<div class="modal-footer">
	               		      				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	               		      				<button type="button" onclick="executeTask()" class="btn btn-primary">执行</button>
	             	    				</div>
	                 				</div>
	                 			</div>
	 							</form>
	         				</div>
	         			</div>
	         		</div>
	     	</div>
	 	</div>
	 	
	 	
	<div class="modal-backdrop fade in" style="display:none;" id="modal-mask"></div>
</body>
<script>
$(function(){
	
})
</script>
</html>
