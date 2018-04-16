<%--
  Created by IntelliJ IDEA.
  User: wg
  Date: 2017/11/13
  Time: 14:12
  Description: 
--%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--
时间：2015-12-30
描述：菜单栏
-->
<div class="container-fluid">
    <div class="col-md-4">
        <a href="${pageContext.request.contextPath}/showIndex.do"><img src="${pageContext.request.contextPath}/img/logo2.png" /></a>
    </div>
    <div class="col-md-5">
        <img src="${pageContext.request.contextPath}/img/header.png" />
    </div>
    <div class="col-md-3" style="padding-top:20px">
        <ol class="list-inline">
            <c:if test="${empty sessionScope.user}">
                <li><a href="${pageContext.request.contextPath}/jsp/login.jsp">登录</a></li>
                <li><a href="${pageContext.request.contextPath}/jsp/register.jsp">注册</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/index.jsp">管理员登录</a></li>
            </c:if>

            <c:if test="${not empty sessionScope.user}">
                <li>欢迎回来: ${sessionScope.user.username}</li>
                <li><a href="${pageContext.request.contextPath}/user/loginOut.do">注销</a></li>
                <li><a href="${pageContext.request.contextPath}/shopCar">购物车</a></li>
                <li><a href="${pageContext.request.contextPath}/orderList?pageId=0&oid=0">我的订单</a></li>
            </c:if>
        </ol>
    </div>
</div>
<!--
时间：2015-12-30
描述：导航条
-->
<div class="container-fluid">
    <nav class="navbar navbar-inverse">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="${pageContext.request.contextPath}/showIndex.do">首页</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

                <ul class="nav navbar-nav" id="listOfNav">
                    <%--<c:forEach items="${requestScope.categories}" var="item">--%>
                    <%--<li><a href="#">${item.name}</a></li>--%>
                    <%--</c:forEach>--%>
                </ul>

                <form class="navbar-form navbar-right" role="search">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Search">
                    </div>
                    <button type="submit" class="btn btn-default">Submit</button>
                </form>

            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>
</div>

<script>
    // 数据是什么样子的格式
    // [{cid : xxx, name: yyy}, {cid: xxx, name : yyyy} .....]
    $.get(
        "/getCategory.do",
        "",
        function(dt, status, xhr) {
            for (var i = 0; i < dt.length; i++) {
                var o = dt[i];
                var cid = dt[i].cid;
                var name = dt[i].cname;
                $("#listOfNav").append("<li><a href=\"${pageContext.request.contextPath}/product/productList.do?pageNum=1&cid=" + cid + "\">" +
                                       name +"</a></li>")
            }
        },
        "json"
    );
</script>

