<%@ page import="java.sql.Connection" %>
<%@ page import="util.DBHelper" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: 槐序十四
  Date: 2020/6/22
  Time: 17:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>s_list</title>
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

</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs " lay-event="del">查看</a>
</script>

<script src="layui/layui.all.js" charset="utf-8"></script>

<script>
    layui.use(['layer', 'table','laydate','form'], function(){
        var table = layui.table,
            laydate = layui.laydate,
            form = layui.form;

        table.render({
            elem: '#test'
            ,url:'/selectServlet?type=slist&search='+window.parent.id+''
            ,height: '960'
            ,toolbar: '#toolbarDemo'
            ,title: '学生信息表'
            ,cols: [[
                {field:'id', title:'ID', width:145, fixed: 'left', unresize: true, sort: true}
                ,{field:'s_id', title:'学生学号', width:150, sort: true}
                ,{field:'s_name', title:'学生姓名', width:220, sort: true}
                ,{field:'c_name', title:'课程姓名', width:229, sort: true}
                ,{field:'time_start', title:'课程开始时间', width:270, sort: true}
                ,{field:'time_end', title:'课程结束时间', width:270, sort: true}
                ,{field:'t_id', title:'教师编号', width:150, sort: true}
                ,{field:'t_name', title:'教师姓名', width:220, sort: true}

                // ,{field:'email', title:'邮箱', width:150, edit: 'text', templet: function(res){
                //     return '<em>'+ res.email +'</em>'
                //   }}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}
            ]]
            ,id: 'testReload'
            ,page: true
        });

        //工具栏事件

        //监听工具条
        table.on('tool(test)', function(obj){
            var data = obj.data;
            switch (obj.event) {
                case 'del':
                    layer.open({
                        type: 1
                        ,title: false //不显示标题栏
                        ,closeBtn: true
                        ,area: '500px;'
                        ,shade: 0.8
                        ,btnAlign: 'c'
                        ,moveType: 0 //拖拽模式，0或者1
                        ,content: '<div style=" padding: 50px; line-height: 22px; background-color: #393D49;font-weight: 300;text-align: center;">    <h2 style="color: #fff;margin-bottom: 30px;margin-top:60px">查看信息</h2>    <form style="margin-left: 32px" class="layui-form layui-form-pane" action=""  method="post">       <div class="layui-form-item">            <label class="layui-form-label">学生信息</label>            <div class="layui-input-inline" style="width: 233px;">                <input id="user1" type="text" name="student" lay-verify="required"  autocomplete="off"  class="layui-input" readonly="readonly" >      </div>      </div>    <div class="layui-form-item">            <label class="layui-form-label">课程名称</label>            <div class="layui-input-inline" style="width: 233px;">                <input type="text" name="c_name" lay-verify="required" value="'+data.c_name+'" autocomplete="off"     readonly="readonly"  class="layui-input">            </div>        </div>        <div class="layui-form-item">            <div class="layui-block">                <label class="layui-form-label">课程时间</label>                <div class="layui-input-inline" style="width: 100px;">                    <input type="text" name="timestart" lay-verify="required" id="date1" autocomplete="off" class="layui-input"    readonly="readonly"    value="'+data.time_start+'">                </div>                <div class="layui-form-mid" style="color: #fff;">至</div>                <div class="layui-input-inline" style="width: 100px;">                    <input type="text" name="timeend" lay-verify="required" id="date2" autocomplete="off" class="layui-input"  readonly="readonly" value="'+data.time_end+'">                </div>            </div>        </div>        <div class="layui-form-item">            <label class="layui-form-label">任课老师</label>            <div class="layui-input-inline" style="width: 233px;">                <input id="user" type="text" name="teacher" lay-verify="required"  autocomplete="off"  class="layui-input" readonly="readonly" >   </div>  </div>      </form></div>'
                        ,success: function(){

                            $("#user").val(window.parent.id+"-"+window.parent.name);
                            $("#user1").val(data.s_id+"-"+data.s_name);

                            form.render();

                        }
                    });
                    break;

            }
        });

        $('#layuisearch .layui-btn').on('click', function(){
            var inputVal = $('.layui-input').val()
            table.reload('testReload', {
                url: '/selectServlet?type=sc&value='+inputVal+''
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

