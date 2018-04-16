<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
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

        <div style="margin:0 auto; margin-top:10px;width:950px;">
            <strong>我的订单</strong>
            <table class="table table-bordered">

                <c:forEach items="${requestScope.page.list}" var="order">
                    <tbody>
                    <tr class="success">
                        <th colspan="3">
                            订单编号:${order.oid}
                        
                            <a href="${pageContext.request.contextPath}/orderRemove?oid=${order.oid}" style="color: red">删除订单</a>
                        </th>
                        
                        <c:if test="${order.state == 0}">
                            <th>
                                <a href="#"></a>
                            </th>
                        </c:if>

                        <c:if test="${order.state == 1}">
                            <th>
                                <a href="${pageContext.request.contextPath}/Recruitment">物流查询</a>
                            </th>
                        </c:if>

                        <c:if test="${order.state == -1}">
                            <th>
                                <a href="${pageContext.request.contextPath}/Recruitment"></a>
                            </th>
                        </c:if>
                        

                        <c:if test="${order.state == 1}">
                            <th>
                                <a href="${pageContext.request.contextPath}/orderReturn?oid=${order.oid}">申请退款</a>
                            </th>
                        </c:if>

                        <c:if test="${order.state == 0}">
                            <th>
                                <a href="${pageContext.request.contextPath}/orderReturn?oid=${order.oid}"></a>
                            </th>
                        </c:if>
                        
                        <c:if test="${order.state == -1}">
                            <th>
                                <span style="color: #8c8c8c">已退款</span>
                            </th>
                        </c:if>

                    </tr>
                    <tr class="warning">
                        <th>图片</th>
                        <th>商品</th>
                        <th>价格</th>
                        <th>数量</th>
                        <th>小计</th>
                    </tr>

                    <c:forEach items="${order.orderItems}" var="item">
                        <tr class="active">
                            <td width="60" width="40%">
                                <input type="hidden" name="id" value="22">
                                <img src="${pageContext.request.contextPath}/${item.product.image}"
                                     width="70" height="60">
                            </td>
                            <td width="30%">
                                <a target="_blank">${item.product.name}</a>
                            </td>
                            <td width="20%">
                                ￥${item.product.shop_price}
                            </td>
                            <td width="10%">
                                    ${item.count}
                            </td>
                            <td width="15%">
                                <span class="subtotal">￥${item.subtotal}</span>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <tr class="success">
                        </th>
                        <c:if test="${order.state == 0}">
                            <th>
                                订单状态:<span style="color: red">待付款</span>
                            </th>
                        </c:if>

                        <c:if test="${order.state != 0}">
                            <th>
                                订单状态:<span style="color: green">已付款</span>
                            </th>
                        </c:if>
                        <th>
                        <th colspan="1"></th>
                        
                        <th>订单总价</th>
                        <th>￥${order.total}
                            <c:if test="${order.state == 0}">
                                <a href="${pageContext.request.contextPath}/orderPay?oid=${order.oid}">付款</a>
                            </c:if>
                        </th>
                    </tr>

                    <tr>
                        <th colspan="5" height="5px"></th>
                    </tr>
                </c:forEach>

            </table>
        </div>
    </div>
    <div style="width:380px;margin:0 auto;margin-top:50px;">
        <ul class="pagination" style="text-align:center; margin-top:10px;">


            <c:if test="${requestScope.page.start >= 0 && requestScope.page.end > 0}">


                <%--如果显示页是第一页，index = 0，那么后退的箭头无效--%>
                <c:if test="${requestScope.page.index == 0}">
                    <li class="disabled">
                        <a href="#" aria-label="Previous"><span
                                aria-hidden="true">&laquo;</span></a>
                    </li>
                </c:if>


                <%--如果显示的非第一页，则后退箭头有效, cid = requestScopre.cid, pageId = index - 1 --%>
                <c:if test="${requestScope.page.index != 0}">
                    <li>
                        <a href="${pageContext.request.contextPath}/orderList?pageId=${requestScope.page.index - 1}"
                           aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
                </c:if>


                <c:forEach begin="${requestScope.page.start}" end="${requestScope.page.end - 1}"
                           var="i"
                           step="1">
                    <%--在选择的时候，如果用户选择的控件，需要变色显示
                        判断用户选择的控件索引号： index == i ?
                    --%>
                    <c:if test="${requestScope.page.index == i}">
                        <li class="active"><a
                                href="${pageContext.request.contextPath}/orderList?pageId=${i}">${i + 1}</a>
                        </li>
                    </c:if>


                    <c:if test="${requestScope.page.index != i}">
                        <li>
                            <a href="${pageContext.request.contextPath}/orderList?pageId=${i}">${i + 1}</a>
                        </li>
                    </c:if>


                </c:forEach>


                <%--如果是最后一页的时候，则前进的箭头无效--%>
                <c:if test="${requestScope.page.index == requestScope.page.total - 1}">
                    <li class="disabled">
                        <a href="#" aria-label="Next"><span aria-hidden="true">&raquo;</span></a>
                    </li>
                </c:if>


                <c:if test="${requestScope.page.index != requestScope.page.total - 1}">
                    <li>
                        <a href="${pageContext.request.contextPath}/orderList?pageId=${requestScope.page.index + 1}"
                           aria-label="Next"><span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>


            </c:if>
        </ul>
    </div>


    <jsp:include page="foot.jsp"/>
</body>


</html>