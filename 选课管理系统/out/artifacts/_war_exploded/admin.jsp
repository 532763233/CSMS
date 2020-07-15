<%--
  Created by IntelliJ IDEA.
  User: 槐序十四
  Date: 2020/6/18
  Time: 14:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>选课管理系统</title>
    <link rel="stylesheet" href="./layui/css/layui.css">
</head>
<body class="layui-layout-body">

<%
    String type= (String) session.getAttribute("type");
%>

<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">选课管理系统</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">

        </ul>

        <input type="text" id="name" value="<%=session.getAttribute("name")%>" style="visibility:hidden;">
        <input type="text" id="id" value="<%=session.getAttribute("id")%>" style="visibility:hidden;">
        <input type="text" id="type" value="<%=type%>" style="visibility:hidden;">

        <ul class="layui-nav layui-layout-right" style="right: 230px;">
            <i class='layui-icon' style="font-size: 30px;float: left;padding-top: 13px;padding-right: 5px">&#xe68d;</i>
            <input type="text" id="whh" readonly="readonly" style="padding-top: 20px;width:210px;border: 0;background-color: rgb(35,38,46);color: white;">
        </ul>
        <ul class="layui-nav layui-layout-right">

            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="//tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg" class="layui-nav-img">
                    <%=session.getAttribute("name")%>
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:;" onclick="change('information')">基本资料</a></dd>
                    <dd><a href="javascript:;" onclick="change('safe')">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="/logout">退出登录</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black" id="admin" style="visibility: hidden">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域 -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">人员管理</a>
                    <dl class="layui-nav-child">
                        <dd class="layui-this"><a href="javascript:;" onclick="change('admin')">管理员管理</a></dd>
                        <dd><a href="javascript:;" onclick="change('student')">学生管理</a></dd>
                        <dd><a href="javascript:;" onclick="change('teacher')">教师管理</a></dd>
                        <dd><a href="javascript:;" onclick="change('checkpeople')">注册申请</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="javascript:;">课程管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" onclick="change('course')">课程目录</a></dd>
                        <dd><a href="javascript:;" onclick="change('sc')">学生选课</a></dd>
                        <dd><a href="javascript:;"onclick="change('checkcourse')">申请列表</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="javascript:;">系统管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" onclick="change('log')">操作日志</a></dd>
                    </dl>
                </li>

            </ul>
        </div>
    </div>

    <div class="layui-side layui-bg-black" id="student" style="visibility: hidden">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域 -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">选课管理</a>
                    <dl class="layui-nav-child">
                        <dd class="layui-this"><a href="javascript:;" onclick="change('able')">选课列表</a></dd>
                        <dd><a href="javascript:;" onclick="change('ed')">已选课程</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="javascript:;">选课情况</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">饼状图</a></dd>
                        <dd><a href="javascript:;">柱状图</a></dd>
                    </dl>
                </li>

            </ul>
        </div>
    </div>

    <div class="layui-side layui-bg-black" id="teacher" style="visibility: hidden">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域 -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">授课管理</a>
                    <dl class="layui-nav-child">
                        <dd class="layui-this"><a href="javascript:;"onclick="change('teachable')">可授课程</a></dd>
                        <dd><a href="javascript:;"onclick="change('teach')">教授课程</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="javascript:;">课程管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;"onclick="change('slist')">学生目录</a></dd>
                    </dl>
                </li>

            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">

            <iframe src="" frameborder="0" id="demoAdmin" style="width: 100%; height: 1040px"></iframe>

        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © 532763233@qq.com - 黄成炜
    </div>
</div>
<script src="./layui/layui.all.js" charset="utf-8"></script>
<script>

    var name = my$("name").value;
    var id = my$("id").value;
    var type = my$("type").value;

    window.onload=function () {
        getTime();
        switch (type) {
            case  'admin': my$("demoAdmin").src="adminSelect.jsp";
                break;
            case  'teacher':my$("demoAdmin").src="teachableSelect.jsp";
                break;
            case  'student': my$("demoAdmin").src="ableSelect.jsp";
                break;
        }
        my$("<%=type%>").style.visibility = "visible";

    }
    function login() {
        window.location.href='/logout';
    }

    function my$(id) {
        return document.getElementById(id);
    }

    function change(type) {
        my$("demoAdmin").src=type+"Select.jsp";
    }

    function getTime(){
        var time = new Date();
        var year = time.getFullYear();
        var month = (time.getMonth()+1).toString().padStart(2,'0');
        var date = time.getDate().toString().padStart(2,'0');//系统时间月份中的日
        var day = time.getDay();//系统时间中的星期值
        var weeks = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
        var week = weeks[day];//显示为星期几
        var hour = time.getHours().toString().padStart(2,'0');
        var minutes = time.getMinutes().toString().padStart(2,'0');
        var seconds = time.getSeconds().toString().padStart(2,'0');

        var getday=year+"年"+month+"月"+date+"日 "+week;
        var gettime=hour+":"+minutes+":"+seconds;
        var now = getday+" "+gettime;
        my$("whh").value=now;

    }setInterval("getTime()","1000");



</script>
</body>
</html>
