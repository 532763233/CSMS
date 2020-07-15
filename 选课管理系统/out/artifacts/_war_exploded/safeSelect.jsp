<%--
  Created by IntelliJ IDEA.
  User: 槐序十四
  Date: 2020/6/26
  Time: 13:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>safe</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="./layui/css/layui.css"  media="all">
    <script src="./js/jquery-1.8.3.min.js"></script>
</head>
<body>

<form id="myform" class="layui-form layui-form-pane video_in" action="" method="post"
      style="margin-left: 520px;margin-top: 233px">

    <div class="layui-form-item">
        <label class="layui-form-label">ID</label>
        <div class="layui-input-inline">
            <input id="id" name="id" value="<%=session.getAttribute("id")%>" type="text" style="width: 588px;"  readonly="readonly"  autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-inline">
            <input id="username" name="username" value="<%=session.getAttribute("username")%>" type="text" style="width: 588px;"  readonly="readonly" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">密码</label>
        <div class="layui-input-inline">
            <input id="password" name="password" value="<%=session.getAttribute("password")%>" type="text" style="width: 588px;" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item" >
        <label class="layui-form-label">安全问题1</label>
        <div class="layui-input-inline" style="width: 588px;">
            <select name="quest1" id="quest1" lay-search="" lay-verify="required">
                <option value="">直接选择或搜索选择</option>
                <option value="1">你的故乡是哪里？</option>
                <option value="2">你母校的名字？</option>
                <option value="3">你父亲的职业？</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">回答1</label>
        <div class="layui-input-inline">
            <input name="ans1" lay-verify="required" value="<%=session.getAttribute("ans1")%>" placeholder="请输入安全问题1的回答" type="text" style="width: 588px;" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">安全问题2</label>
        <div class="layui-input-inline"  style="width: 588px;">
            <select name="quest2" id="quest2" lay-search="" lay-verify="required">
                <option value="">直接选择或搜索选择</option>
                <option value="1">你小学班主任的姓名？</option>
                <option value="2">你的初恋对象？</option>
                <option value="3">你养的第一条宠物？</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">回答2</label>
        <div class="layui-input-inline">
            <input name="ans2" lay-verify="required" value="<%=session.getAttribute("ans2")%>" lay-verify="required" placeholder="请输入安全问题2的回答" type="text" style="width: 588px;" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">安全问题3</label>
        <div class="layui-input-inline" style="width: 588px;">
            <select name="quest3" id="quest3" lay-search="" lay-verify="required">
                <option value="">直接选择或搜索选择</option>
                <option value="1">你最喜欢的书？</option>
                <option value="2">你的梦想是什么？</option>
                <option value="3">你平时做什么运动？</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">回答3</label>
        <div class="layui-input-inline">
            <input name="ans3" lay-verify="required" value="<%=session.getAttribute("ans3")%>" placeholder="请输入安全问题3的回答" type="text" style="width: 588px;" autocomplete="off"
                   class="layui-input">
        </div>
    </div>


    <div class="layui-form-item">
        <button id="submit" style="margin-left: 300px;" lay-submit="" class="layui-btn">保存</button>
    </div>
</form>

<%--<input type="button" value="hahah" onclick="function hh() {
    alert(        $('#year').val());
}
hh()">--%>

<script src="./layui/layui.all.js" charset="utf-8"></script>

<script>
    window.onload=function(){
        if ('<%=request.getAttribute("login")%>'=='1'){
            alert("保存成功,请重新登录！")
            parent.login();
        }else if ('<%=request.getAttribute("login")%>'=='2'){
            alert("保存失败！")
        }
    }

    layui.use(['form', 'layedit', 'laydate'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate;

            $('#quest1').val('<%=session.getAttribute("quest1")%>');
            $('#quest2').val('<%=session.getAttribute("quest2")%>');
            $('#quest3').val('<%=session.getAttribute("quest3")%>');

        layui.form.render();

        $("#submit").click(function(){
            var type = '<%=session.getAttribute("type")%>';
            var newUrl = "/setSafe?type="+type;
            $("#myform").attr('action',newUrl);
            $("#myform").submit();
        })

    });

</script>

</body>
</html>
