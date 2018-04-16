<%--
  Created by IntelliJ IDEA.
  User: 13458
  Date: 2017/12/11
  Time: 9:54
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>快递</title>
    <link rel="stylesheet" href="${root}/css/bootstrap.min.css">
    <script type="text/javascript" src="${root}/js/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="${root}/js/bootstrap.min.js"></script>
</head>
<body>
<style>
    * {
        box-sizing: border-box;
    }

    .progressbar{
        min-height: 122px;
    }

    .detail-progressbar li {
        color: #909090;
        margin: 0;
        padding: 0;
        float: left;
        height: 100px;
        width: 257px;
        text-align: left;
        position: relative;
        display: inline-block;
    }

    .detail-progressbar .step-1-done,
    .detail-progressbar .step-2-done,
    .detail-progressbar .step-3-done,
    .detail-progressbar .step-4-current {
        background: url(${pageContext.request.contextPath}/img/20171219104246.png) no-repeat 4px 3px;
        color: #ff5a00;
    "
    }
</style>
<div>

    <jsp:include page="head.jsp"/>
    <div class="container">
        <ol class="breadcrumb">
            <li><a href="${pageContext.request.contextPath}/index">首页</a></li>
            <li><a href="${pageContext.request.contextPath}/orderList?pageId=0">我的订单</a></li>
            <li class="active">我的商品</li>
        </ol>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title" style="padding-left: 5%;">包裹信息</h3>
            </div>
            <div class="panel-body" style="padding: 5%;">
                <div style="" class="progressbar">
                    <ul class="detail-progressbar">
                        <li class="step-1-done">
                        </li>
                        <li class="step-2-done" style="background-position: -253px 3px;">
                        </li>
                        <li class="step-3-done" style="background-position: -515px 3px;">
                        </li>
                        <li class="step-4-current" style="background-position:-770px 3px;width: 80px;">
                        </li>
                    </ul>
                    <div style="" class="guoguo guoguo-step-4" data-spm-anchor-id="a2d00.7723416.0.i1.4a6c7977fLIqW2">
                        <!-- 76048496：签收悬浮球 类型：固定 尺寸：125x100-->
                        <a style="display:none!important" id="tanx-a-mm_12852562_1778064_83044015" data-backup="${pageContext.request.contextPath}/img/20171219104246.png"></a>
                        <ins id="ac_js86_mm_122491691_23000893_76048496" style="display: none;"></ins>
                    </div>
                </div>
                <div style="background: #F3F3F3;padding: 5%;">
                    <c:forEach items="${result.traces}" var="i">
                        <p>${i.acceptTime}&nbsp;&nbsp;${i.acceptStation}</p>
                    </c:forEach>
                </div>

                <div class="page-header">

                </div>
                <div class="form-inline">
                    <p style="font-size: 12px;">
                        运单号码： <span style="font-weight: bold;">468763158837</span>&nbsp;&nbsp;
                        物流公司： <span style="font-weight: bold;">申通快递</span>&nbsp;&nbsp;
                        客服电话： <span style="font-weight: bold;">95311</span>
                    </p>
                    <p style="font-size: 12px;">
                        卖家昵称： <span style="font-weight: bold;">malegod</span>
                    </p>
                    <p style="font-size: 12px;">
                        发货地址：&nbsp;&nbsp;
                        河南省郑州市二七区 &nbsp;
                        航海路新圃西街南段19号楼 &nbsp;
                        450000 &nbsp;
                        李佳 &nbsp;
                        18837157550
                    </p>
                    <p style="font-size: 12px;">
                        收货地址：&nbsp;&nbsp;
                        小母鸡，&nbsp;
                        13108070360，&nbsp;
                        浙江省温州市鹿城区浙江工贸职业技术学院717号，&nbsp;
                        43005
                    </p>
                </div>
            </div>

        </div>

    </div>

    <jsp:include page="foot.jsp"/>
</div>
</body>
</html>

