<%@ page import="java.sql.Connection" %>
<%@ page import="util.DBHelper" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: 槐序十四
  Date: 2020/6/23
  Time: 19:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ableSelect</title>
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
        <button class="layui-btn " lay-event="delete" >批量选课</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="del">选课</a>
</script>

<script src="layui/layui.all.js" charset="utf-8"></script>

<script>
    layui.use(['layer', 'table','laydate','form'], function(){
        var table = layui.table,
            laydate = layui.laydate,
            form = layui.form;

        table.render({
            elem: '#test'
            ,url:'/selectServlet?type=course&search=choice&value=1'
            ,height: '960'
            ,toolbar: '#toolbarDemo'
            ,title: '选课信息表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID', width:100, fixed: 'left', unresize: true, sort: true}
                ,{field:'c_name', title:'课程姓名', width:208, sort: true}
                ,{field:'time_start', title:'课程开始时间', width:250, sort: true}
                ,{field:'time_end', title:'课程结束时间', width:250, sort: true}
                ,{field:'t_id', title:'教师编号', width:150, sort: true}
                ,{field:'t_name', title:'教师姓名', width:200, sort: true}
                ,{field:'num', title:'已选人数', width:150, sort: true}
                ,{field:'selectable', title:'可选人数', width:150, sort: true}
                ,{field:'choice', title:'是否可选', width:150}
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
                case 'delete':
                    var data = checkStatus.data;
                    layer.confirm('确定要选择这'+data.length+'门课吗？', function(){
                        var arr=[],brr=[],crr=[],drr=[],err=[];
                        for(var i=0;i<data.length;i++){
                            arr.push(data[i].c_name);
                            brr.push(data[i].time_start);
                            crr.push(data[i].time_end);
                            drr.push(data[i].t_id);
                            err.push(data[i].t_name);
                        }
                        window.location.href="/addsc?type=sc&return=able&txt=选课&c_name="+arr.toString()+"&time_start="+brr.toString()+"&time_end="+crr.toString()+"&t_id="+drr.toString()+"&t_name="+err.toString()+"&s_id="+window.parent.id+"&s_name="+window.parent.name+"";
                    });
                    break;
            };
        });
        //监听工具条
        table.on('tool(test)', function(obj){
            var data = obj.data;
            switch (obj.event) {
                case 'del':
                    layer.confirm('确定要选择课程'+data.c_name+'吗？', function(){
                        window.location.href="/courseAdd?type=sc&return=able&txt=选课&c_name="+data.c_name+"&time_start="+data.time_start+"&time_end="+data.time_end+"&teacher="+data.t_id+"-"+data.t_name+"&student="+window.parent.id+"-"+window.parent.name+"";
                    });
                    break;
            }
        });

        $('#layuisearch .layui-btn').on('click', function(){
            var inputVal = $('.layui-input').val()
            table.reload('testReload', {
                url: '/selectServlet?type=able&value='+inputVal+''
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
