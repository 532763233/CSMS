<%--
  Created by IntelliJ IDEA.
  User: 槐序十四
  Date: 2020/6/24
  Time: 15:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>log</title>
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
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中行数据</button>
        <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>
        <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="del">查看</a>
</script>

<script src="layui/layui.all.js" charset="utf-8"></script>

<script>
    layui.use(['layer', 'table','element'], function(){
        var table = layui.table;
        var element = layui.element;
        table.render({
            elem: '#test'
            ,url:'/selectServlet?type=log'
            ,height: '960'
            ,toolbar: '#toolbarDemo'
            ,title: '管理员数据表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID', width:100, fixed: 'left', unresize: true, sort: true}
                ,{field:'admin_id', title:'操作人编号', width:100, sort: true}
                ,{field:'admin_name', title:'操作人姓名', width:180, sort: true}
                ,{field:'type', title:'操作类型', width:180, sort: true, templet: function (data) {
                        switch(data.type){
                            case "添加":return "<div style='color:green;font-weight: bold'><i class='layui-icon' style='margin-right:10px'>&#xe61f;</i>"+data.type+"</div>";
                                break;
                            case "修改":return "<div style='color:rgb(0, 119, 255);font-weight: bold'><i class='layui-icon' style='margin-right:10px'>&#xe669;</i>"+data.type+"</div>";
                                break;
                            case "删除":return "<div style='color:rgb(255, 0, 0);font-weight: bold'><i class='layui-icon' style='margin-right:10px'>&#xe616;</i>"+data.type+"</div>";
                                break;
                            case "通过":return "<div style='color:green;font-weight: bold'><i class='layui-icon' style='margin-right:10px'>&#x1005;</i>"+data.type+"</div>";
                                break;
                            case "拒绝":return "<div style='color:yellow;font-weight: bold'><i class='layui-icon' style='margin-right:10px'>&#xe702;</i>"+data.type+"</div>";
                                break;
                        }
                }}
                ,{field:'time', title:'操作时间', width:250, sort: true}
                ,{field:'text', title:'具体内容', width:801}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}

            ]]
            ,id: 'testReload'
            , initSort: {field:'id', type:'desc'}
            ,page: true
        });

        //工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'getCheckData':
                    var data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                    break;
                case 'getCheckLength':
                    var data = checkStatus.data;
                    layer.msg('选中了：'+ data.length + ' 个');
                    break;
                case 'isAll':
                    layer.msg(checkStatus.isAll ? '全选': '未全选');
                    break;
            };
        });

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
                        ,content: '<div style=" padding: 50px; line-height: 22px; background-color: #393D49;font-weight: 300;text-align: center;">    <h2 style="color: #fff;margin-bottom: 30px;margin-top:60px">查看</h2>    <form style="margin-left: 32px" class="layui-form layui-form-pane" action=""  method="post">        <div class="layui-form-item">            <label class="layui-form-label">操作人</label>            <div class="layui-input-inline" style="width: 233px;">                <input type="text" name="c_name" lay-verify="required" value="'+data.admin_id+'-'+data.admin_name+'" autocomplete="off"     readonly="readonly"  class="layui-input">            </div>        </div>            <div class="layui-form-item">            <label class="layui-form-label">操作类型</label>            <div class="layui-input-inline" style="width: 233px;">                <input id="user" type="text"  lay-verify="required" value="'+data.type+'" autocomplete="off"  class="layui-input" readonly="readonly" >            </div>        </div>     <div class="layui-form-item">            <label class="layui-form-label">操作时间</label>            <div class="layui-input-inline" style="width: 233px;">                <input id="user" type="text"  lay-verify="required" value="'+data.time+'" autocomplete="off"  class="layui-input" readonly="readonly" >            </div>        </div>    <div class="layui-form-item layui-form-text" style="width: 340px;"><label class="layui-form-label">具体内容</label><div class="layui-input-block"><textarea id="text" class="layui-textarea" name="reason" readonly="readonly" style="height: 200px"></textarea></div></div>     </form></div>'
                        ,success: function(){
                            $('#text').val(data.text);
                        }
                    });
                    break;

            }
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
