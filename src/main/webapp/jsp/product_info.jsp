<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html>

<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>会员登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css"
          type="text/css"/>
    <script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"
            type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"
            type="text/javascript"></script>
    <!-- 引入自定义css文件 style.css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>

    <style>
        body {
            margin-top: 20px;
            margin: 0 auto;
        }

        .carousel-inner .item img {
            width: 100%;
            height: 300px;
        }
    </style>
</head>

<body>

<jsp:include page="head.jsp"/>


<div class="container">
    <div class="row">
        <div style="border: 1px solid #e4e4e4;width:930px;margin-bottom:10px;margin:0 auto;padding:10px;margin-bottom:10px;">
            <a href="${pageContext.request.contextPath}/showIndex.do">首页&nbsp;&nbsp;&gt;</a>
            <a href="${pageContext.request.contextPath}/productList?cid=${product.category.cid}&pageId=0">${requestScope.product.category.cname}&nbsp;&nbsp;&gt;</a>
            <a>${product.name}</a>
        </div>

        <div style="margin:0 auto;width:950px;">
            <div class="col-md-6">
                <img style="opacity: 1;width:400px;height:350px;" title="" class="medium"
                     src="${pageContext.request.contextPath}/${product.image}">
            </div>

            <div class="col-md-6">
                <div><strong>${product.name}</strong></div>
                <div style="border-bottom: 1px dotted #dddddd;width:350px;margin:10px 0 10px 0;">
                    <div>编号：${product.pid}</div>
                </div>

                <div style="margin:10px 0 10px 0;">亿家价: <strong
                        style="color:#ef0101;">￥：${product.shopPrice}元</strong> 参 考 价：
                    <del>￥${product.marketPrice}元</del>
                </div>

                <div style="margin:10px 0 10px 0;">促销: <a target="_blank"
                                                          title="限时抢购 (2014-07-30 ~ 2015-01-01)"
                                                          style="background-color: #f07373;">限时抢购</a>
                </div>

                <form action="${pageContext.request.contextPath}/add2Car.do" method="get">
                    <div style="padding:10px;border:1px solid #e7dbb1;width:330px;margin:15px 0 10px 0;;background-color: #fffee6;">
                        <div style="margin:5px 0 10px 0;">白色</div>

                        <input type="text" value="${product.pid}" name="pid"
                               hidden="true">
                        <div style="border-bottom: 1px solid #faeac7;margin-top:20px;padding-left: 10px;">
                            购买数量:
                            <input id="quantity" name="count" value="1" maxlength="4" size="10"
                                   type="text"></div>

                        <div style="margin:20px 0 10px 0;;text-align: center;">

                            <input style="background: url('${pageContext.request.contextPath}/images/product.gif') no-repeat scroll 0 -600px rgba(0, 0, 0, 0);height:36px;width:127px;"
                                   value="加入购物车" type="submit">
                            &nbsp;收藏商品
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="clear"></div>
        <div style="width:950px;margin:0 auto;">


            <div style="background-color:#d3d3d3;width:900px;">
                <table class="table table-bordered">
                    <tbody>
                    <tr class="active">
                        <th><strong>商品详情</strong></th>
                    </tr>
                    <tr class="warning">
                        <th>${requestScope.product.desc}</th>
                    </tr>
                    </tbody>
                </table>
            </div>


            <div style="background-color:#d3d3d3;width:900px;">
                <table class="table table-bordered">
                    <tbody>
                    <tr class="active">
                        <th><strong>商品评论</strong></th>
                    </tr>
                    <tr class="warning">
                        <th>暂无商品评论信息 <a>[发表商品评论]</a></th>
                    </tr>
                    </tbody>
                </table>
            </div>

            <div style="background-color:#d3d3d3;width:900px;">
                <table class="table table-bordered">
                    <tbody>
                    <tr class="active">
                        <th><strong>商品咨询</strong></th>
                    </tr>
                    <tr class="warning">
                        <th>暂无商品咨询信息 <a>[发表商品咨询]</a></th>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>

<jsp:include page="history.jsp"/>
<jsp:include page="foot.jsp"/>


</body>

</html>