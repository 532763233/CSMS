<%@ page import="java.sql.Connection" %>
<%@ page import="util.DBHelper" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.awt.*" %>
<%@ page import="javafx.scene.Parent" %>
<%--
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
    <title>teachable</title>
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
        <button class="layui-btn "  lay-event="add" >发布课程</button>
        <button class="layui-btn " lay-event="delete" >批量教授</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="del">教授</a>
</script>

<script src="layui/layui.all.js" charset="utf-8"></script>

<script>
    layui.use(['layer', 'table','laydate','form'], function(){
        var table = layui.table
            ,laydate = layui.laydate
            ,form = layui.form;

        table.render({
            elem: '#test'
            ,url:'/selectServlet?type=course'
            ,height: '960'
            ,toolbar: '#toolbarDemo'
            ,title: '课程信息表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID', width:100, fixed: 'left', unresize: true, sort: true}
                ,{field:'c_name', title:'课程姓名', width:208, sort: true}
                ,{field:'time_start', title:'课程开始时间', width:250, sort: true}
                ,{field:'time_end', title:'课程结束时间', width:250, sort: true}
                ,{field:'t_id', title:'教师编号', width:150, sort: true}
                ,{field:'t_name', title:'教师姓名', width:200, sort: true}
                ,{field:'num', title:'已选人数', width:150, sort: true}
                ,{field:'selectable', title:'可选人数', width:150}
                ,{field:'choice', title:'是否可选', width:150}
                // ,{field:'email', title:'邮箱', width:150, edit: 'text', templet: function(res){
                //     return '<em>'+ res.email +'</em>'
                //   }}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}
            ]]
            , initSort: {field:'t_id', type:'asc'}
            ,id: 'testReload'
            ,page: true
        });

        //工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'add':
                    layer.open({
                        type: 1
                        ,title: false //不显示标题栏
                        ,closeBtn: true
                        ,area: '500px;'
                        ,shade: 0.8
                        ,btnAlign: 'c'
                        ,moveType: 0 //拖拽模式，0或者1
                        ,content: '<div style=" padding: 50px; line-height: 22px; background-color: #393D49;font-weight: 300;text-align: center;">    <h2 style="color: #fff;margin-bottom: 30px;margin-top:60px">添加课程信息</h2>    <form style="margin-left: 32px" class="layui-form layui-form-pane" action="/courseAdd?type=apply&return=teachable&mold=申请发布这门课程"  method="post">        <div class="layui-form-item">            <label class="layui-form-label">课程名称</label>            <div class="layui-input-inline" style="width: 233px;">                <input type="text" name="c_name" lay-verify="required" placeholder="请输入课程名称" autocomplete="off"                       class="layui-input">            </div>        </div>        <div class="layui-form-item">            <div class="layui-block">                <label class="layui-form-label">课程时间</label>                <div class="layui-input-inline" style="width: 100px;">                    <input type="text" name="timestart" lay-verify="required" id="date1" autocomplete="off" class="layui-input"                           placeholder="点击选择日期">                </div>                <div class="layui-form-mid" style="color: #fff;">至</div>                <div class="layui-input-inline" style="width: 100px;">                    <input type="text" name="timeend" lay-verify="required" id="date2" autocomplete="off" class="layui-input"                           placeholder="点击选择日期">                </div>            </div>        </div>        <div class="layui-form-item">            <label class="layui-form-label">可选人数</label>            <div class="layui-input-inline" style="width: 233px;">                <input type="text" id="num" name="num" lay-verify="required" placeholder="请输入人数" autocomplete="off"        class="layui-input">            </div>        </div>       <div class="layui-form-item">            <label class="layui-form-label">任课老师</label>            <div class="layui-input-inline" style="width: 233px;">                <input id="user" type="text" name="teacher" lay-verify="required"  autocomplete="off"  class="layui-input" readonly="readonly" >            </div>        </div>      <div class="layui-form-item layui-form-text" style="width: 340px;"><label class="layui-form-label">理由</label><div class="layui-input-block"><textarea placeholder="请输入内容" class="layui-textarea" name="reason"></textarea></div></div>  <div class="layui-form-item" style="margin-left: 80px;height:120px">            <div class="layui-input-inline">                <button class="layui-btn" lay-submit="" lay-filter="demo2" style="width: 100px;">添加</button>            </div>        </div>    </form></div>'
                        ,success: function(){

                            $("#user").val(window.parent.id+"-"+window.parent.name);

                            form.render();
                            laydate.render({
                                elem: '#date2'
                            });
                            laydate.render({
                                elem: '#date1'
                            });

                        }
                    });
                    break;
                case 'delete':
                    var data = checkStatus.data;
                    layer.confirm('确认要执教这'+data.length+'门课程吗？', function(){
                        var arr=[],brr=[],crr=[],drr=[],err=[],frr=[];
                        for(var i=0;i<data.length;i++){
                            arr.push(data[i].id);
                            brr.push(data[i].c_name);
                            crr.push(data[i].time_start);
                            drr.push(data[i].time_end);
                            err.push(data[i].selectable);
                            frr.push(data[i].choice);
                        }
                        var teacher = window.parent.id + "-" + window.parent.name;
                        window.location.href = "/courseUpdate?return=teachable&type=course&id=" + arr.toString() + "&c_name=" + brr.toString() + "&time_start=" + crr.toString() + "&time_end=" + drr.toString() + "&teacher=" + teacher + "&selectable=" + err.toString() + "&open=" + frr.toString() + "";
                    });
                    break;
            }
        });
        //监听工具条
        table.on('tool(test)', function(obj){
            var data = obj.data;
            switch (obj.event) {
                case 'del':
                    layer.confirm('确认要执教课程'+data.c_name+'吗？', function(){

                            var teacher = window.parent.id + "-" + window.parent.name;
                            if(data.t_id != null){
                                alert("该课程已有教师执教！")
                            }else {
                                window.location.href = "/courseUpdate?return=teachable&type=course&id=" + data.id + "&c_name=" + data.c_name + "&time_start=" + data.time_start + "&time_end=" + data.time_end + "&teacher=" + teacher + "&selectable=" + data.selectable + "&open=" + data.choice + "";
                            }

                    });
                    break;

            }
        });

        $('#layuisearch .layui-btn').on('click', function(){
            var inputVal = $('.layui-input').val();
            table.reload('testReload', {
                url: '/selectServlet?type=course&value='+inputVal+''
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

