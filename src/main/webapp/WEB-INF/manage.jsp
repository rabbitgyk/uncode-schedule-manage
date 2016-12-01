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
	    <script type="text/javascript" src="<%=basePath%>static/jquery-1.11.1/jquery.min.js"></script>
	    <script type="text/javascript" src="<%=basePath%>static/bootstrap-3.3.0/js/bootstrap.min.js"></script>
	    <style>
	        .table th,.table td{
	            text-align: center;
	        }
	        .table>thead>tr>th, .table>tbody>tr>th, .table>tfoot>tr>th, .table>thead>tr>td, .table>tbody>tr>td, .table>tfoot>tr>td{
	            vertical-align: middle;
	        }
	        .blog-masthead .container{
	            width: 970px;
	        }
	        .table caption{
	            font-size:18px;
	            font-weight:bold;
	        }
	        .table-bordered > thead > tr > th{
	            border-bottom-width: 1px;
	        }
	        .add-btn{
	            float:right;
	            border: none;
	            border-radius: 3px;
	            background: #2a6496;
	            color: #fff;
	            font-weight: normal;
	            font-size: 14px;
	            width: 60px;
	            height: 30px;
	            line-height: 30px;
	            padding: 0;
	        }
	    </style>
		<script>
		    $(function () {
		        $(".spe-td").each(function () {
		            var td1 = $(this).html().split('$');
		            $(this).html(td1[0]+"$.........$"+td1[td1.length-1]);
		        })
		        $(".blog-nav-item").click(function(){
		            $(this).addClass("active").siblings().removeClass("active");
		            var dj = $(this).index();
		            $(".sign-div .container").eq(dj).show().siblings().hide();
		        })
		        $.
		    })
		</script>
	</head>

	<body>
    <div class="blog-masthead">
        <div class="container">
            <nav class="blog-nav">
                <a class="blog-nav-item active" href="#">Home</a>
                <a class="blog-nav-item" href="#">New features</a>
            </nav>
        </div>
    </div>
    <div class="sign-div">
        <div class="container">
            <h2 class="text-center">uncode schedule 任务调度系统管理界面</h2>
            <table class="table table-bordered table-condensed table-hover">
                <caption>集群节点</caption>
                <thead>
                    <tr>
                        <th>序号</th>
                        <th>名称</th>
                        <th>调度节点</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>192.168.7.231$B6A47BA82F4C44389D8D066F571D51D8$1000000001</td>
                        <td>是</td>
                    </tr>
                </tbody>

            </table>
            <table class="table table-bordered table-condensed table-hover">
                <caption>定时任务列表<button class="add-btn">添加</button></caption>
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
                    <tr>
                        <td>1</td>
                        <td>simpleUncodeTask</td>
                        <td>uncodePrint2</td>
                        <td>quartz/spring task</td>
                        <td>0/60 * * * * ?</td>
                        <td>null</td>
                        <td>5000</td>
                        <td class="spe-td">172.16.67.147$720E691633A4499B9BDFEB8A7F4FB0D0$1000000001</td>
                        <td>0</td>
                        <td>112233</td>
                        <td><a href="javascript:void (0)">删除</a></td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>simpleUncodeTask</td>
                        <td>uncodePrint2</td>
                        <td>quartz/spring task</td>
                        <td>0/60 * * * * ?</td>
                        <td>null</td>
                        <td>5000</td>
                        <td class="spe-td">123.16.67.147$720E691633A4499B9BDFEB8A7F4FB0D0$1000000001</td>
                        <td>0</td>
                        <td>112233</td>
                        <td><a href="javascript:void (0)">删除</a></td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>simpleUncodeTask</td>
                        <td>uncodePrint2</td>
                        <td>quartz/spring task</td>
                        <td>0/60 * * * * ?</td>
                        <td>null</td>
                        <td>5000</td>
                        <td class="spe-td">156.16.67.147$720E691633A4499B9BDFEB8A7F4FB0D0$1000000001</td>
                        <td>0</td>
                        <td>112233</td>
                        <td><a href="javascript:void (0)">删除</a></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="container" style="display: none">
            <h2 class="text-center">监控界面</h2>
            <table class="table table-bordered table-condensed table-hover">
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
                <tr>
                    <td>1</td>
                    <td>simpleUncodeTask</td>
                    <td>uncodePrint2</td>
                    <td>quartz/spring task</td>
                    <td>0/60 * * * * ?</td>
                    <td>5000</td>
                    <td>
                        <select>
                            <option>172.16.67.147</option>
                            <option>132.56.67.147</option>
                            <option>156.34.67.147</option>
                        </select>
                    </td>
                    <td><a href="javascript:void (0)">执行</a></td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>simpleUncodeTask</td>
                    <td>uncodePrint2</td>
                    <td>quartz/spring task</td>
                    <td>0/60 * * * * ?</td>
                    <td>5000</td>
                    <td>
                        <select>
                            <option>172.16.67.147</option>
                            <option>132.56.67.147</option>
                            <option>156.34.67.147</option>
                        </select>
                    </td>
                    <td><a href="javascript:void (0)">执行</a></td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>simpleUncodeTask</td>
                    <td>uncodePrint2</td>
                    <td>quartz/spring task</td>
                    <td>0/60 * * * * ?</td>
                    <td>5000</td>
                    <td>
                        <select>
                            <option>172.16.67.147</option>
                            <option>132.56.67.147</option>
                            <option>156.34.67.147</option>
                        </select>
                    </td>
                    <td><a href="javascript:void (0)">执行</a></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
