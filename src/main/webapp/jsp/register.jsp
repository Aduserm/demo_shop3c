<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>会员注册</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css"
        type="text/css"/>
  <script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"
          type="text/javascript"></script>
  <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"
          type="text/javascript"></script>
  <!-- 引入自定义css文件 style.css -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>
</head>
<style>
  body {
    margin-top: 20px;
    margin: 0 auto;
  }

  .carousel-inner .item img {
    width: 100%;
    height: 300px;
  }

  .container .row div {
    /* position:relative;
    float:left; */
  }

  font {
    color: #3164af;
    font-size: 18px;
    font-weight: normal;
    padding: 0 10px;
  }
</style>
</head>
<body>

<jsp:include page="head.jsp"/>
<div class="container"
     style="width:100%;background:url('${pageContext.request.contextPath}/image/regist_bg.jpg');">
  <div class="row">

    <div class="col-md-2"></div>


    <div class="col-md-8"
         style="background:#fff;padding:40px 80px;margin:30px;border:7px solid #ccc;">
      <font>会员注册</font>USER REGISTER<span style="color: red" id="warn"></span>
      <form class="form-horizontal" style="margin-top:5px;" method="post">
        <div class="form-group">
          <label for="username" class="col-sm-2 control-label">用户名</label>
          <div class="col-sm-6">
            <input type="text" class="form-control" id="username" placeholder="请输入用户名"
                   name="username">
          </div>
          <span id="username_msg" class="username_msg"></span>
        </div>

        <div class="form-group">
          <label for="password" class="col-sm-2 control-label">密码</label>
          <div class="col-sm-6">
            <input type="password" class="form-control" id="password" placeholder="请输入密码"
                   name="password">
          </div>
        </div>
        <div class="form-group">
          <label for="confirmpwd" class="col-sm-2 control-label">确认密码</label>
          <div class="col-sm-6">
            <input type="password" class="form-control" id="confirmpwd" placeholder="请输入确认密码">
          </div>
        </div>
        <div class="form-group">
          <label for="email" class="col-sm-2 control-label">Email</label>
          <div class="col-sm-6">
            <input type="email" class="form-control" id="email" placeholder="Email" name="email">
          </div>
          <span id="email_msg" class="username_msg"></span>
        </div>
        <div class="form-group">
          <label for="name" class="col-sm-2 control-label">姓名</label>
          <div class="col-sm-6">
            <input type="text" class="form-control" id="name" placeholder="请输入姓名" name="name">
          </div>
        </div>
        <div class="form-group opt">
          <label for="man" class="col-sm-2 control-label">性别</label>
          <div class="col-sm-6">
            <label class="radio-inline">
              <input type="radio" name="sex" id="man" value="man"> 男
            </label>
            <label class="radio-inline">
              <input type="radio" name="sex" id="women" value="women"> 女
            </label>
          </div>
        </div>
        <div class="form-group">
          <label for="birthday" class="col-sm-2 control-label">出生日期</label>
          <div class="col-sm-6">
            <input type="date" class="form-control" id="birthday" name="birthday">
          </div>
        </div>

        <div class="form-group">
          <label for="code" class="col-sm-2 control-label">验证码</label>
          <div class="col-sm-3">
            <input type="text" class="form-control" id="code" name="code">

          </div>
          <div class="col-sm-2">
            <img src="${pageContext.request.contextPath}/user/verification.do"
                 onclick="changeImg(this)"/>
          </div>

        </div>

        <div class="form-group">
          <div class="col-sm-offset-2 col-sm-10">
            <input type="button" width="100" value="注册" name="submit" id="btnSubmit" border="0"
                   style="background: url('${pageContext.request.contextPath}/images/register.gif') no-repeat scroll 0 0 rgba(0, 0, 0, 0);
                           height:35px;width:100px;color:white;">
          </div>
        </div>
      </form>
    </div>

    <div class="col-md-2"></div>

  </div>
</div>


<jsp:include page="foot.jsp"/>

</body>
<script type="text/javascript">

  function changeImg(obj) {
    obj.src = "${pageContext.request.contextPath}/user/verification.do?i=" + Math.random();
  }

  $("#username").blur(function () {
    $Uname = $(this).val();

    console.log($Uname);
    $.get("/user/check.do", "username=" + $Uname, function (d) {
      if (d == 1) {
        console.log(d);
        $("#username_msg").html("<p style='color:lawngreen'>用户名可以使用");
        $("#btnSubmit").disabled = false;
      } else if (d == 0) {
        $("#username_msg").html("<p style='color:red'>用户名已被占用");
        $("#btnSubmit").disabled = true;
      }
    })
  });

  $("#btnSubmit").click(function () {
    $.get("${pageContext.request.contextPath}/user/register.do",
        {
          username: $("#username").val(),
          password: $("#password").val(),
          name: $("#name").val(),
          email: $("#email").val(),
          birthday: $("#birthday").val(),
          code: $("#code").val(),
          sex: $("input[name='sex']:checked").val()
        },

        function (d) {
          if (d == -1) {
            $("#warn").html("验证码错误，请输入正确的验证码");
          } else if (d == 0) {
            $("#warn").html("确认密码有误，请确认两次密码是否一致");
          } else {
            $("#warn").html("");
            var o = d;
            console.log(o.msg);
            location.href = "/jsp/msg.jsp?msg=" + o.msg + "&address=" + o.address;
          }
        },
        "json"
    )
  })

</script>
</html>




