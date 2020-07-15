<%--
  Created by IntelliJ IDEA.
  User: 槐序十四
  Date: 2020/6/18
  Time: 22:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>teacherSelect</title>
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
        <button class="layui-btn "  lay-event="add" >添加教师</button>
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

    layui.use(['layer', 'table'], function(){
        var table = layui.table;

        table.render({
            elem: '#test'
            ,url:'/selectServlet?type=teacher'
            ,height: '960'
            ,toolbar: '#toolbarDemo'
            ,title: '教师信息表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID', width:80, fixed: 'left', unresize: true, sort: true}
                ,{field:'name', title:'姓名', width:120, sort: true}
                ,{field:'username', title:'用户名', width:130}
                ,{field:'password', title:'密码', width:130}
                ,{field:'telephone', title:'电话号码', width:180}
                ,{field:'email', title:'邮箱', width:180}
                ,{field:'date', title:'生日', width:200}
                ,{field:'sex', title:'性别', width:100, sort: true}
                ,{field:'signature', title:'个性签名', width:488}
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
                                              ,area: '409px;'
                                              ,shade: 0.8
                                              ,btnAlign: 'c'
                                              ,moveType: 0 //拖拽模式，0或者1
                                              ,content: '<div style="padding: 50px; line-height: 22px; background-color: #393D49; text-align: center; font-weight: 300;"> <h2 style="color: #fff;margin-bottom: 30px">添加教师</h2><form name="form1" class="layui-form layui-form-pane" action="/addServlet?type=teacher&time='+now+'&admin='+window.parent.id+'-'+window.parent.name+'" method="post"> <div class="layui-form-item"> <label class="layui-form-label">姓名</label> <div class="layui-input-inline"> <input type="text" name="name" lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input"> </div> </div> <div class="layui-form-item"> <label class="layui-form-label">用户名</label> <div class="layui-input-inline"> <input type="text" name="username" lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input"> </div> </div> <div class="layui-form-item"> <label class="layui-form-label">密码</label> <div class="layui-input-inline"> <input type="password" name="password" lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input"> </div> </div> <div class="layui-form-item"> <button class="layui-btn" lay-submit="" lay-filter="demo2">添加</button> </div> </form> </div>'

                                          });
                              break;
                          case 'delete':
                              var data = checkStatus.data;
                              layer.confirm('真的要删除这'+data.length+'名教师吗？', function(){
                                  var arr=[];
                                  for(var i=0;i<data.length;i++){
                                      arr.push(data[i].id);
                                  }
                                  window.location.href="/deleteServlet?type=teacher&getday="+getday+"&time="+now+"&admin="+window.parent.id+"-"+window.parent.name+"&id="+arr.toString();
                              });
                              break;
                    };
                });
        //监听工具条
        table.on('tool(test)', function(obj){
            var data = obj.data;
            switch (obj.event) {
                case 'del':
                    layer.confirm('真的要删除教师'+data.name+'吗？', function(){
                    window.location.href="/deleteServlet?type=teacher&getday="+getday+"&time="+now+"&admin="+window.parent.id+"-"+window.parent.name+"&id="+data.id;
                    });
                    break;
                case 'edit':
                    layer.open({
                        type: 1
                        ,title: false //不显示标题栏
                        ,closeBtn: true
                        ,area: '409px;'
                        ,shade: 0.8
                        ,btnAlign: 'c'
                        ,moveType: 0 //拖拽模式，0或者1
                        ,content: '<div style="padding: 50px; line-height: 22px; background-color: #393D49; text-align: center; font-weight: 300;"> <h2 style="color: #fff;margin-bottom: 30px">修改教师信息</h2><form name="form1" class="layui-form layui-form-pane" action="/updateServlet?type=teacher&id='+data.id+'&time='+now+'&admin='+window.parent.id+'-'+window.parent.name+'" method="post"> <div class="layui-form-item"> <label class="layui-form-label">姓名</label> <div class="layui-input-inline"> <input type="text" name="name" lay-verify="required" value="'+data.name+'" placeholder="请输入姓名" autocomplete="off" class="layui-input"> </div> </div> <div class="layui-form-item"> <label class="layui-form-label">用户名</label> <div class="layui-input-inline"> <input type="text" name="username" lay-verify="required" value="'+data.username+'" placeholder="请输入用户名" autocomplete="off" class="layui-input"> </div> </div> <div class="layui-form-item"> <label class="layui-form-label">密码</label> <div class="layui-input-inline"> <input type="password" name="password" lay-verify="required" value="'+data.password+'" placeholder="请输入密码" autocomplete="off" class="layui-input"> </div> </div> <div class="layui-form-item"> <button class="layui-btn" lay-submit="" lay-filter="demo2">修改</button> </div> </form> </div>'

                    });
                    break;
            }
        });

        $('#layuisearch .layui-btn').on('click', function(){
            var inputVal = $('.layui-input').val()
            table.reload('testReload', {
                url: '/selectServlet?type=teacher&value='+inputVal+''
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