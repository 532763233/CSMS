<%--
  Created by IntelliJ IDEA.
  User: 槐序十四
  Date: 2020/6/17
  Time: 21:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="./css/style.css">
  <link rel="stylesheet" href="./css/select.css">
  <title>选课管理系统</title>
  <style>
    body{
      background-image: url(imgs/123.jpg);
      background-repeat: no-repeat;
      background-size: 100% auto;
    }
  </style>
</head>

<body>
<div class="container" id="container">
  <div class="form-container sign-up-container">
    <form name="form1" action="" method="post">
      <h1>注 册</h1>
      <select class="select" name="select">
        <option value="student">学生</option>
        <option value="teacher">教师</option>
        <option value="admin">管理员</option>
      </select>
      <input name="name" type="text" placeholder="姓名" required="required" />
      <input name="username" type="text" placeholder="用户名"  required="required"/>
      <input name="password" type="password" placeholder="密码"  required="required"/>
      <div class="code">
        <input type="text" style="width: 218px;"value="" placeholder="请输入验证码（不区分大小写）" class="incode" required="required">
        <canvas id="canvas" width="100" height="43"></canvas>
        <button class="btn" id="sub">提交</button>
      </div>
    </form>
  </div>
  <div class="form-container sign-in-container">
    <form action="/login" method="post">
      <h1>登 录</h1>
      <select class="select" name="select">
        <option value="student">学生</option>
        <option value="teacher">教师</option>
        <option value="admin">管理员</option>
      </select>
      <input name="username" type="text" placeholder="用户名"  required="required"/>
      <input name="password" type="password" placeholder="密码"  required="required"/>
      <a href="/forget.jsp">忘记密码？</a>
      <button>登录</button>
    </form>
  </div>
  <div class="overlay-container">
    <div class="overlay">
      <div class="overlay-panel overlay-left">
        <h1>已有账号？</h1>
        <p>请使用您的账号进行登录</p>
        <button class="ghost" id="signIn">登录</button>
      </div>
      <div class="overlay-panel overlay-right">
        <h1>没有账号？</h1>
        <p>立即注册加入我们，和我们一起开始旅程吧。</p>
        <button class="ghost" id="signUp">注册</button>
      </div>
    </div>
  </div>
</div>
<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
<script src="./js/code.js"></script>
<script>

    const signUpButton = document.getElementById('signUp');
    const signInButton = document.getElementById('signIn');
    const container = document.getElementById('container');

    signUpButton.addEventListener('click', () => container.classList.add('right-panel-active'));
    signInButton.addEventListener('click', () => container.classList.remove('right-panel-active'));
</script>
</body>

</html>
