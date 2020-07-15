<%@ page import="java.sql.Connection" %>
<%@ page import="util.DBHelper" %>
<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: 槐序十四
  Date: 2020/6/20
  Time: 1:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>courseSelect</title>
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
        <button class="layui-btn "  lay-event="add" >添加课程</button>
        <button class="layui-btn " lay-event="delete" >批量删除</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script src="layui/layui.all.js" charset="utf-8"></script>
<script src="./js/gettime.js" charset="utf-8"></script>

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
                ,{field:'choice', title:'是否可选', width:150, sort: true}
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
                        ,area: '500px;'
                        ,shade: 0.8
                        ,btnAlign: 'c'
                        ,moveType: 0 //拖拽模式，0或者1
                        ,content: '<div style=" padding: 50px; line-height: 22px; background-color: #393D49;font-weight: 300;text-align: center;">    <h2 style="color: #fff;margin-bottom: 30px;margin-top:60px">添加课程信息</h2>    <form style="margin-left: 32px" class="layui-form layui-form-pane" action="/courseAdd?type=course&time='+now+'&admin='+window.parent.id+'-'+window.parent.name+'"  method="post">        <div class="layui-form-item">            <label class="layui-form-label">课程名称</label>            <div class="layui-input-inline" style="width: 233px;">                <input type="text" name="c_name" lay-verify="required" placeholder="请输入课程名称" autocomplete="off"                       class="layui-input">            </div>        </div>        <div class="layui-form-item">            <div class="layui-block">                <label class="layui-form-label">课程时间</label>                <div class="layui-input-inline" style="width: 100px;">                    <input type="text" name="timestart" lay-verify="required" id="date1" autocomplete="off" class="layui-input"                           placeholder="点击选择日期">                </div>                <div class="layui-form-mid" style="color: #fff;">至</div>                <div class="layui-input-inline" style="width: 100px;">                    <input type="text" name="timeend" lay-verify="required" id="date2" autocomplete="off" class="layui-input"                           placeholder="点击选择日期">                </div>            </div>        </div>        <div class="layui-form-item">            <label class="layui-form-label">可选人数</label>            <div class="layui-input-inline" style="width: 233px;">                <input type="text" name="num" lay-verify="required" placeholder="请输入人数" autocomplete="off"                       class="layui-input">            </div>        </div>        <div class="layui-form-item">            <label class="layui-form-label">选择老师</label>            <div class="layui-input-inline" style="width: 233px;">                <input type="checkbox" name="open" lay-skin="switch" lay-filter="switchTest" lay-text="选择|取消">            </div>        </div>        <div class="layui-form-item" id="teacher" style="display:none;">            <label class="layui-form-label">教师</label>            <div class="layui-input-inline" style="width: 233px;">                <select name="teacher" id="myselect"  lay-search="">                    <option value="">直接选择或搜索选择</option>                    <%                        try {                            Connection connection = DBHelper.getConnection();                            String sql = "select id,name from teacher;";                            ResultSet rs = connection.createStatement().executeQuery(sql);                            while (rs.next()){                    %>                            <option value="<%=rs.getString("id")%>-<%=rs.getString("name")%>"><%=rs.getString("id")%>-<%=rs.getString("name")%></option>                    <%                            }                        } catch (Exception e) {                            e.printStackTrace();                        }                    %>                </select>            </div>        </div>        <div class="layui-form-item" style="margin-left: 80px;height:120px">            <div class="layui-input-inline">                <button class="layui-btn" lay-submit="" lay-filter="demo2" style="width: 100px;">添加</button>            </div>        </div>    </form></div>'
                        ,success: function(){
                            form.render();
                            laydate.render({
                                elem: '#date2'
                            });
                            laydate.render({
                                elem: '#date1'
                            });

                            form.on('switch(switchTest)', function () {

                                if (this.checked) {
                                    document.getElementById("teacher").style.display = "block";
                                    $("#myselect option:first").prop("selected", 'selected');
                                    form.render('select');
                                }
                                else document.getElementById("teacher").style.display = "none";

                            });
                        }
                     });
                    break;
                case 'delete':
                    var data = checkStatus.data;
                    layer.confirm('真的要删除这'+data.length+'门课程吗？', function(){
                        var arr=[];
                        for(var i=0;i<data.length;i++){
                            arr.push(data[i].id);
                        }
                        window.location.href="/deleteServlet?type=course&time="+now+"&admin="+window.parent.id+"-"+window.parent.name+"&id="+arr.toString();
                    });
                    break;
            };
        });
        //监听工具条
        table.on('tool(test)', function(obj){
            var data = obj.data;
            switch (obj.event) {
                case 'del':
                    layer.confirm('真的要删除课程'+data.c_name+'吗？', function(){
                        if (getday>=data.time_start && getday<=data.time_end){
                            alert("该课程正在进行中，无法删除！")
                        }else {
                            window.location.href="/deleteServlet?type=course&time="+now+"&admin="+window.parent.id+"-"+window.parent.name+"&id="+data.id;
                        }
                    });
                    break;
                case 'edit':
                    layer.open({
                        type: 1
                        ,title: false //不显示标题栏
                        ,closeBtn: true
                        ,area: '500px;'
                        ,shade: 0.8
                        ,btnAlign: 'c'
                        ,moveType: 0 //拖拽模式，0或者1
                        ,content: '<div style="padding: 50px; line-height: 22px; background-color: #393D49; text-align: center; font-weight: 300;height:500px" >    <h2 style="color: #fff;margin-bottom: 30px;margin-top:100px">修改选课信息</h2>    <form style="margin-left: 32px" name="form1" class="layui-form layui-form-pane" action="/courseUpdate?type=course&id='+data.id+'&time='+now+'&admin='+window.parent.id+'-'+window.parent.name+'"      method="post">      <div class="layui-form-item"> <label class="layui-form-label">课程名称</label>        <div class="layui-input-inline" style="width: 233px;">          <input type="text" name="c_name" lay-verify="required" value="'+data.c_name+'" placeholder="请输入姓名"            autocomplete="off" class="layui-input">        </div>      </div>      <div class="layui-form-item">        <div class="layui-block">          <label class="layui-form-label">课程时间</label>          <div class="layui-input-inline" style="width: 100px;">            <input type="text" name="time_start" lay-verify="required" id="date1" autocomplete="off" class="layui-input"              placeholder="点击选择日期" value="'+data.time_start+'">          </div>          <div class="layui-form-mid" style="color: #fff;">至</div>          <div class="layui-input-inline" style="width: 100px;">            <input type="text" name="time_end" lay-verify="required" id="date2" autocomplete="off" class="layui-input"              placeholder="点击选择日期" value="'+data.time_end+'">          </div>        </div>      </div>      <div class="layui-form-item"> <label class="layui-form-label">可选人数</label>        <div class="layui-input-inline" style="width: 233px;">          <input type="text" name="selectable" lay-verify="required" value="'+data.selectable+'" placeholder="请输入人数"            autocomplete="off" class="layui-input"> </div>      </div>      <div class="layui-form-item"> <label class="layui-form-label">选择老师</label>        <div class="layui-input-inline" style="width: 233px;">          <select name="teacher" id="myselect" lay-filter="change"  lay-search="" onmousedown="if(this.options.length>3){this.size=4}" onblur="this.size=0" onchange="this.size=0;gradeChange(this.options[this.options.selectedIndex].text)">            <option value="">直接选择或搜索选择</option>            <%            try {                Connection connection = DBHelper.getConnection();                String sql = "select id,name from teacher;";                ResultSet rs = connection.createStatement().executeQuery(sql);                while (rs.next()){        %>                <option value="<%=rs.getString("id")%>-<%=rs.getString("name")%>"><%=rs.getString("id")%>-<%=rs.getString("name")%></option>        <%                }            } catch (Exception e) {                e.printStackTrace();            }        %>          </select> </div>      </div>   <div class="layui-form-item" id="checkbox">            <label class="layui-form-label">是否可选</label>            <div class="layui-input-inline" style="width: 233px;">                <input type="checkbox" name="open" lay-skin="switch" lay-filter="switchTest" lay-text="是|否">            </div>        </div>   <div class="layui-form-item">        <button class="layui-btn" lay-submit="" lay-filter="demo2">修改</button>      </div>    </form>  </div>'
                        ,success: function(){

                            var testText = data.t_id+"-"+data.t_name;
                            if (data.choice) {
                                $("input[type='checkbox'][name='open']").prop("checked", true);
                            }else{
                                $("input[type='checkbox'][name='open']").prop("checked", false);
                            }

                            form.on('select(change)', function(data){
                                var val=data.value;
                                if(val==""){
                                    $("#checkbox").css("display","none");
                                }else {
                                    $("#checkbox").css("display", "block");
                                }
                            });

                            $("#myselect").find("option").each(function() {
                                if ($(this).text() == testText) {
                                    $(this).attr("selected", true);
                                } else {
                                    $(this).attr("selected", false);
                                }
                            });

                            if($("#myselect option:selected").text()=="直接选择或搜索选择"){
                                $("#checkbox").css("display","none");
                            }else {
                                $("#checkbox").css("display", "block");
                            }

                            form.render();
                            laydate.render({
                                elem: '#date2'
                            });
                            laydate.render({
                                elem: '#date1'
                            })
                        }
                    });
                    break;
            }
        });

        $('#layuisearch .layui-btn').on('click', function(){
            var inputVal = $('.layui-input').val()
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
