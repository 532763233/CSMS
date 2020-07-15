<%@ page import="java.sql.Connection" %>
<%@ page import="util.DBHelper" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: 槐序十四
  Date: 2020/6/21
  Time: 16:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>scSelect</title>
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
        <button class="layui-btn "  lay-event="add" >添加选课信息</button>
        <button class="layui-btn " lay-event="delete" >批量删除</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script src="layui/layui.all.js" charset="utf-8"></script>
<script src="./js/gettime.js" charset="utf-8"></script>

<script>

    layui.use(['layer', 'table','laydate','form'], function(){
        var table = layui.table,
            laydate = layui.laydate,
            form = layui.form;

        table.render({
            elem: '#test'
            ,url:'/selectServlet?type=sc'
            ,height: '960'
            ,toolbar: '#toolbarDemo'
            ,title: '选课信息表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID', width:100, fixed: 'left', unresize: true, sort: true}
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
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'add':
                    layer.open({
                        type: 1
                        ,title: false //不显示标题栏
                        ,closeBtn: true
                        ,area: '480px;'
                        ,shade: 0.8
                        ,btnAlign: 'c'
                        ,moveType: 0 //拖拽模式，0或者1
                        ,content: '<div style=" padding: 50px; line-height: 22px; background-color: #393D49;font-weight: 300;text-align: center;">     <h2 style="color: #fff;margin-bottom: 30px;margin-top:60px">添加选课信息</h2>     <form style="margin-left: 35px" class="layui-form layui-form-pane" action="/courseAdd?type=sc&time='+now+'&admin='+window.parent.id+'-'+window.parent.name+'" method="post">         <div class="layui-form-item" id="teacher">             <label class="layui-form-label">课程名称</label>             <div class="layui-input-inline"><select name="c_name" lay-search="">                 <option value="">直接选择或搜索选择</option>                 <% try {                     Connection connection = DBHelper.getConnection();                     String sql = "select c_name from course where choice=true;";                     ResultSet rs = connection.createStatement().executeQuery(sql);                     while (rs.next()) { %>                 <option value="<%=rs.getString("c_name")%>"><%=rs.getString("c_name")%></option>                 <% }                 } catch (Exception e) {                     e.printStackTrace();                 } %></select></div>         </div>         <div class="layui-form-item" id="teacher">             <label class="layui-form-label">学生</label>             <div class="layui-input-inline"><select name="student" lay-search=""  onchange="gradeChange(this.options[this.options.selectedIndex].text)">                 <option value="">直接选择或搜索选择</option>                 <% try {                     Connection connection = DBHelper.getConnection();                     String sql = "select id,name from student;";                     ResultSet rs = connection.createStatement().executeQuery(sql);                     while (rs.next()) { %>                 <option value="<%=rs.getString("id")%>-<%=rs.getString("name")%>"><%=rs.getString("id")%>-<%=rs.getString("name")%></option>                 <% }                 } catch (Exception e) {                     e.printStackTrace();                 } %></select></div>         </div>          <div class="layui-form-item" style="margin-left: 80px;height:120px">             <div class="layui-input-inline">                 <button class="layui-btn" lay-submit="" lay-filter="demo2" style="width: 100px;">添加</button>             </div>         </div>     </form> </div>'
                        ,success: function(){
                            form.render();
                        }
                    });
                    break;
                case 'delete':
                    var data = checkStatus.data;
                    layer.confirm('真的要删除这'+data.length+'个选课信息吗？', function(){
                        var arr=[];
                        for(var i=0;i<data.length;i++){
                            arr.push(data[i].id);
                        }
                        window.location.href="/deleteServlet?type=sc&&time="+now+"&admin="+window.parent.id+"-"+window.parent.name+"&id="+arr.toString();
                    });
                    break;
            };
        });
        //监听工具条
        table.on('tool(test)', function(obj){
            var data = obj.data;
            switch (obj.event) {
                case 'del':
                    layer.confirm('真的要删除'+data.s_name+'选修课程'+data.c_name+'的记录吗？', function(){
                        window.location.href="/deleteServlet?type=sc&&time="+now+"&admin="+window.parent.id+"-"+window.parent.name+"&id="+data.id;
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

