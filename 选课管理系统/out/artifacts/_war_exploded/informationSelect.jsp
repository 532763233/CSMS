<%@ page import="java.sql.Connection" %>
<%@ page import="util.DBHelper" %>
<%@ page import="java.awt.*" %><%--
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
    <title>information</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="./layui/css/layui.css"  media="all">
    <script src="./js/jquery-1.8.3.min.js"></script>
</head>
<body>

<form id="myform" class="layui-form layui-form-pane" action="" method="post" style="margin-left: 520px;margin-top: 233px">

    <div class="layui-form-item">
        <label class="layui-form-label">ID</label>
        <div class="layui-input-inline">
            <input id="id" name="id" value="<%=session.getAttribute("id")%>" type="text" style="width: 588px;"  readonly="readonly"  autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">姓名</label>
        <div class="layui-input-inline">
            <input id="name" name="name" value="<%=session.getAttribute("name")%>" type="text" style="width: 588px;" readonly="readonly" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-inline">
            <input id="username" name="username" value="<%=session.getAttribute("username")%>" type="text" style="width: 588px;"  readonly="readonly" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">手机号码</label>
            <div class="layui-input-inline">
                <input type="tel" name="telephone" placeholder="请输入手机号码" value="<%=session.getAttribute("telephone")%>" style="width: 588px;"   lay-verify="required|phone" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">邮箱</label>
            <div class="layui-input-inline">
                <input type="text" name="email" placeholder="请输入邮箱" value="<%=session.getAttribute("email")%>" style="width: 588px;" lay-verify="required|email" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">生日</label>
        <div class="layui-input-inline">
            <select name="year" id="year">
                <option value="">请选择年</option>
                <% for (int i = 2020; i >1960 ; i--) { %>
                        <option value="<%=i%>"><%=i%>年</option>
                <% } %>
            </select>
        </div>

        <div class="layui-input-inline">
            <select name="moth" id="moth">
                <option value="">请选择月</option>
                <% for (int i = 1; i <13 ; i++) { %>
                <option value="<%=i%>"><%=i%>月</option>
                <% } %>
            </select>
        </div>
        <div class="layui-input-inline">
            <select name="day" id="day">
                <option value="">请选择日</option>
                <% for (int i = 1; i <32 ; i++) { %>
                <option value="<%=i%>"><%=i%>日</option>
                <% } %>
            </select>
        </div>
    </div>

    <div class="layui-form-item" id="IsPurchased">
        <label class="layui-form-label">性别</label>
        <input type="radio" name="sex" value="男" title="男" checked="">
        <input type="radio" name="sex" value="女" title="女">
    </div>

    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label" style="width: 696px;">个性签名</label>
        <div class="layui-input-block">
            <textarea style="width: 696px;" id="signature" name="signature" placeholder="请输入内容" class="layui-textarea" ></textarea>
        </div>
    </div>

    <div class="layui-form-item">
        <button id="submit" style="margin-left: 300px;" lay-submit=""  class="layui-btn" >保存</button>
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

        var time="<%=session.getAttribute("date")%>";
        var year=parseInt(time.split("-")[0]);
        var moth=parseInt(time.split("-")[1]);
        var day=parseInt(time.split("-")[2]);

        if (time!=null && time!="") {
            $('#year').val(year);
            $('#moth').val(moth);
            $('#day').val(day);
        }
        $("input[name=sex][value='男']").attr("checked", '<%=session.getAttribute("sex")%>' == '男' ? true : false);
        $("input[name=sex][value='女']").attr("checked",  '<%=session.getAttribute("sex")%>' == '女'  ? true : false);
        $('#signature').val('<%=session.getAttribute("signature")%>');
        layui.form.render();

        $("#submit").click(function(){
            var date = $('#year').val()+"-"+$('#moth').val()+"-"+$('#day').val();
            var sex = $('#IsPurchased input[name="sex"]:checked ').val()
            var type = '<%=session.getAttribute("type")%>';
            var newUrl = "/setInfo?type="+type+"&date="+date+"&sex="+sex;
            $("#myform").attr('action',newUrl);
            $("#myform").submit();
        })

    });

</script>

</body>
</html>