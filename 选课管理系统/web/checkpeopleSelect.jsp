<%--
  Created by IntelliJ IDEA.
  User: 槐序十四
  Date: 2020/6/19
  Time: 22:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>application</title>
    <style>

    </style>
    <link rel="stylesheet" href="./layui/css/layui.css" >
    <script src="./js/jquery-1.8.3.min.js"></script>
    <script src="./layui/layui.all.js"></script>
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
        <button class="layui-btn " lay-event="allpass" >批量同意</button>
        <button class="layui-btn " lay-event="delete" >批量拒绝</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="pass">同意</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">拒绝</a>
</script>

<script src="layui/layui.all.js" charset="utf-8"></script>
<script src="./js/gettime.js" charset="utf-8"></script>

<script>

    layui.use(['layer', 'table'], function(){
        var table = layui.table;

        table.render({
            elem: '#test'
            ,url:'/selectServlet?type=checkpeople'
            ,height: '960'
            ,toolbar: '#toolbarDemo'
            ,title: '注册申请表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID', width:80, fixed: 'left', unresize: true, sort: true}
                ,{field:'type', title:'身份', width:130, sort: true}
                ,{field:'name', title:'姓名', width:130, sort: true}
                ,{field:'username', title:'用户名', width:150}
                ,{field:'password', title:'密码', width:150}
                // ,{field:'email', title:'邮箱', width:150, edit: 'text', templet: function(res){
                //     return '<em>'+ res.email +'</em>'
                //   }}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}
            ]]
            ,id: 'testReload'
            ,page: true
        });

        //工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'allpass':
                    var data = checkStatus.data;
                    layer.confirm('确认同意这'+data.length+'份申请吗？', function(){
                        var arr=[];
                        for(var i=0;i<data.length;i++){
                            arr.push(data[i].id);
                        }
                        window.location.href="/passServlet?time="+now+"&admin="+window.parent.id+"-"+window.parent.name+"&id="+arr.toString();
                    });
                    break;
                case 'delete':
                    var data = checkStatus.data;
                    layer.confirm('真的要拒绝这'+data.length+'份申请吗？', function(){
                        var arr=[];
                        for(var i=0;i<data.length;i++){
                            arr.push(data[i].id);
                        }
                        window.location.href="/deleteServlet?type=checkpeople&txt=拒绝&time="+now+"&admin="+window.parent.id+"-"+window.parent.name+"&id="+arr.toString();
                    });
                    break;
            };
        });
        //监听工具条
        table.on('tool(test)', function(obj){
            var data = obj.data;
            switch (obj.event) {
                case 'del':
                    layer.confirm('真的要拒绝'+data.name+'的申请吗？', function(){
                        window.location.href="/deleteServlet?type=checkpeople&txt=拒绝&time="+now+"&admin="+window.parent.id+"-"+window.parent.name+"&id="+data.id;
                    });
                    break;
                case 'pass':
                    layer.confirm('确认要通过'+data.name+'的申请吗？', function(){
                        window.location.href="/passServlet?time="+now+"&admin="+window.parent.id+"-"+window.parent.name+"&id="+data.id;
                    });
                    break;
            }
        });

        $('#layuisearch .layui-btn').on('click', function(){
            var inputVal = $('.layui-input').val()
            table.reload('testReload', {
                url: '/selectServlet?type=checkpeople&value='+inputVal+''
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
