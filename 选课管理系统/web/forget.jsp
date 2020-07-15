<%--
  Created by IntelliJ IDEA.
  User: 槐序十四
  Date: 2020/6/27
  Time: 13:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/select.css">
    <script src="./js/jquery-1.8.3.min.js"></script>
    <title>找回密码</title>
    <style>
        body {
            background-image: url(imgs/123.jpg);
            background-repeat: no-repeat;
            background-size: 100% auto;
        }
        .sign-in-container{
            left: 180px;
        }
        .quest {
            background: #eee;
            border: none;
            margin: 5px 0;
            width: 100%;
            height: 42px;
            margin-top: 30px;
            border-radius: 0%;
            text-indent: 10px;
        }
    </style>
</head>

<body>
<div class="container" id="box1" style="background-color: rgb(255,73,58)">
    <div class="form-container sign-in-container">
        <form action="/forget" name="b_form">
            <h1>找回密码</h1>
            <select class="select" name="type">
                <option value="student">学生</option>
                <option value="teacher">教师</option>
                <option value="admin">管理员</option>
            </select>
            <input type="text" name="username" required="required" placeholder="用户名" />
            <div class="code">
                <input type="text" style="width: 218px;" required="required" value="" placeholder="请输入验证码（不区分大小写）" class="incode">
                <canvas id="canvas" width="100" height="43"></canvas>
                <button class="btn" id="sub">提交</button>
            </div>
        </form>
    </div>
</div>

<div class="container" id="box2" style="display: none;background-color: rgb(255,73,58)">
    <div class="form-container sign-in-container">
        <form action="/checkQuest?type=admin" name="b_form">
            <h1>密保找回</h1>
            <input type="text" name="type" value="<%=request.getAttribute("type")%>" style="visibility: hidden" />
            <select class="select quest" required="required" name="quest" id="quest" value="">
                <option value="">请选择密保问题</option>
            </select>
            <input type="text" name="ans" required="required" placeholder="请输入回答" />
            <input type="text" name="id" value="<%=request.getAttribute("id")%>" style="visibility: hidden" />
            <button class="btn">提交</button>
        </form>
    </div>
</div>

<div class="container" id="box3" style="display: none;background-color: rgb(255,73,58)">
    <div class="form-container sign-in-container">
        <form action="/passUpdate" name="c_form">
            <h1>修改密码</h1>
            <input type="text" name="id" value="<%=request.getAttribute("id")%>" style="visibility: hidden" />
            <input type="password" name="password" id="password" placeholder="输入新密码" />
            <input type="password" id="confirmPassword" placeholder="确新密码" onblur="validate()"><span id="tishi"></span>
            <input type="text" name="type" value="<%=request.getAttribute("type")%>" style="visibility: hidden" />
            <button class=" btn" id="button" style="display: none;">提交</button>
        </form>
    </div>
</div>
<script src="./js/code.js"></script>
<script>

    window.onload=function(){

        switch ('<%=request.getAttribute("forget")%>') {
            case '0':
                alert("用户名不存在或密保问题未设置！");
                break;
            case '1':
                document.getElementById("box2").style.display="none";
                document.getElementById("box3").style.display="none";
                document.getElementById("box1").style.display="block";
                break;
            case '2':
                document.getElementById("box1").style.display="none";
                document.getElementById("box3").style.display="none";
                document.getElementById("box2").style.display="block";

                var obj = document.getElementById("quest");
                switch('<%=request.getAttribute("quest1")%>'){
                case '1': obj.add(new Option("你的故乡是哪里？","1"));
                    break;
                case  '2': obj.add(new Option("你母校的名字？","1"));
                    break;
                case '3': obj.add(new Option("你父亲的职业？","1"));
                    break;
            }
                switch('<%=request.getAttribute("quest2")%>'){
                    case '1': obj.add(new Option("你小学班主任的姓名？","2"));
                        break;
                    case  '2': obj.add(new Option("你的初恋女友？","2"));
                        break;
                    case '3': obj.add(new Option("你养的第一条宠物？","2"));
                        break;
                }
                switch('<%=request.getAttribute("quest3")%>'){
                    case '1': obj.add(new Option("你最喜欢的书？","3"));
                        break;
                    case  '2': obj.add(new Option("你的梦想是什么？","3"));
                        break;
                    case '3': obj.add(new Option("你平时做什么运动？","3"));
                        break;
                }
                break;
            case '3':
                document.getElementById("box1").style.display="none";
                document.getElementById("box2").style.display="none";
                document.getElementById("box3").style.display="block";
                break;
            case '4':
                alert("密保问题回答错误！")
                break;
        }

    }
    function validate() {
        var pwd1 = document.getElementById("password").value;
        var pwd2 = document.getElementById("confirmPassword").value;

// 对比两次输入的密码
        if (pwd1 == pwd2) {
            document.getElementById("tishi").innerHTML = "<span style='color: green;font-size: 12px;font-weight: bold'>Same password twice</span>";
            document.getElementById("button").style.display="block";
        }
        else {
            document.getElementById("tishi").innerHTML = "<span style='color: red;font-size: 12px;font-weight: bold'>Two different passwords</span>";
            document.getElementById("button").style.display="none";
        }
    }
</script>
</body>

</html>