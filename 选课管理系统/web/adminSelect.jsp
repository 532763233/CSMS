<%--
  Created by IntelliJ IDEA.
  User: 槐序十四
  Date: 2020/6/18
  Time: 22:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>adminSelect</title>
    <link rel="stylesheet" href="layui/css/layui.css" media="all">
    <script src="./js/jquery-1.8.3.min.js"></script>
</head>
<body>

<div class="demoTable" id="layuisearch">
    搜索ID：
    <div class="layui-inline">
        <input class="layui-input" name="id" id="demoReload" autocomplete="off">
    </div>
    <button class="layui-btn" data-type="reload">搜索</button>
</div>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container" id="layerDemo">
        <button class="layui-btn "  lay-event="add">添加管理员</button>
    </div>
</script>

<script src="layui/layui.all.js" charset="utf-8"></script>
<script src="./js/gettime.js" charset="utf-8"></script>

<script>

    layui.use(['layer', 'table','element'], function(){
        var table = layui.table;
        var element = layui.element;
        table.render({
            elem: '#test'
            ,url:'/selectServlet?type=admin'
            ,height: '960'
            ,toolbar: '#toolbarDemo'
            ,title: '管理员数据表'
            ,cols: [[
                {field:'id', title:'ID', width:80, fixed: 'left', sort: true}
                ,{field:'name', title:'姓名', width:120, sort: true}
                ,{field:'username', title:'用户名', width:130}
                ,{field:'password', title:'密码', width:130}
                ,{field:'telephone', title:'电话号码', width:180}
                ,{field:'email', title:'邮箱', width:180}
                ,{field:'date', title:'生日', width:200}
                ,{field:'sex', title:'性别', width:100, sort: true}
                ,{field:'signature', title:'个性签名', width:689}
                // ,{field:'email', title:'邮箱', width:150, edit: 'text', templet: function(res){
                //     return '<em>'+ res.email +'</em>'
                //   }}
            ]]
            ,id: 'testReload'
            ,page: true
        });

        //工具栏事件
        table.on('toolbar(test)', function(obj){
            switch(obj.event){
                case 'add':
                    layer.open({
                        type: 1
                        ,title: false //不显示标题栏
                        ,closeBtn: true
                        ,area: '409px;'
                        ,shade: 0.8
                        ,btnAlign: 'c'
                        ,moveType: 0 //拖拽模式，0或者1
                        ,content: '<div style="padding: 50px; line-height: 22px; background-color: #393D49; text-align: center; font-weight: 300;"> <h2 style="color: #fff;margin-bottom: 30px">添加管理员</h2><form name="form1" class="layui-form layui-form-pane" action="/addServlet?type=admin&time='+now+'&admin='+window.parent.id+'-'+window.parent.name+'" method="post"> <div class="layui-form-item"> <label class="layui-form-label">姓名</label> <div class="layui-input-inline"> <input type="text" name="name" lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input"> </div> </div> <div class="layui-form-item"> <label class="layui-form-label">用户名</label> <div class="layui-input-inline"> <input type="text" name="username" lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input"> </div> </div> <div class="layui-form-item"> <label class="layui-form-label">密码</label> <div class="layui-input-inline"> <input type="password" name="password" lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input"> </div> </div> <div class="layui-form-item"> <button class="layui-btn" lay-submit="" lay-filter="demo2">添加</button> </div> </form> </div>'

                    });
                    break;
            };
        });

        $('#layuisearch .layui-btn').on('click', function(){
            var inputVal = $('.layui-input').val()
            table.reload('testReload', {
                url: '/selectServlet?type=admin&value='+inputVal+''
                ,where: {
                    id : inputVal
                }
                ,page: {
                    curr: 1
                }
            });
        })

    });
</script>
</body>
</html>
