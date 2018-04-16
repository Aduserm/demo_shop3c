<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
            width: 100%;
        }

        .carousel-inner .item img {
            width: 100%;
            height: 300px;
        }
    </style>
</head>

<body>

<jsp:include page="head.jsp"/>


<div class="row" style="width:1210px;margin:0 auto;">
    <div class="col-md-12">
        <ol class="breadcrumb">
            <li><a href="${pageContext.request.contextPath}/showIndex.do">首页</a></li>
        </ol>
    </div>

    <c:forEach items="${list}" var="pd">
        <div class="col-md-2">
            <a href="${pageContext.request.contextPath}/product/productInfo.do?pid=${pd.pid}">
                <img src="${pageContext.request.contextPath}/${pd.image}" width="170" height="170"
                     style="display: inline-block;">
            </a>
            <p><a href="${pageContext.request.contextPath}/product/productInfo.do?pid=${pd.pid}"
                  style='color: green'>${fn:substring(pd.name, 0, 12)}</a></p>
            <p><font color="#FF0000">商城价：&yen;${pd.shopPrice}</font></p>
        </div>
    </c:forEach>

</div>

<!--分页 -->

<nav aria-label="Page navigation" >
        <ul class="pagination" style="margin-left: 40%">
            <c:if test="${page.isFirstPage == true}">
                <li class="disabled">
                    <a href="/product/productList.do?pageNum=0&cid=${cid}" aria-label="Previous">
                        <span aria-hidden="true">首页</span>
                    </a>
                </li>
            </c:if>
            <c:if test="${page.isFirstPage != true}">
                <li>
                    <a href="/product/productList.do?pageNum=0&cid=${cid}" aria-label="Previous">
                        <span aria-hidden="true">首页</span>
                    </a>
                </li>
            </c:if>
            <c:if test="${page.isFirstPage == true}">
                <li class="disabled">
                    <a href="/product/productList.do?pageNum=${page.prePage}&cid=${cid}" aria-label="Previous">
                        <span aria-hidden="true">上一页</span>
                    </a>
                </li>
            </c:if>
            <c:if test="${page.isFirstPage != true}">
                <li>
                    <a href="/product/productList.do?pageNum=${page.prePage}&cid=${cid}" aria-label="Previous">
                        <span aria-hidden="true">上一页</span>
                    </a>
                </li>
            </c:if>
            <c:forEach begin="${page.navigateFirstPage}" end="${page.navigateLastPage}" var="item" step="1">
                <c:if test="${item == page.pageNum}">
                    <li class="active">
                        <a href="/product/productList.do?pageNum=${item}&cid=${cid}">${item}</a>
                    </li>
                </c:if>
                <c:if test="${item != page.pageNum}">
                    <li>
                        <a href="/product/productList.do?pageNum=${item}&cid=${cid}">${item}</a>
                    </li>
                </c:if>
            </c:forEach>
            <c:if test="${page.isLastPage == true}">
                <li class="disabled">
                    <a href="/product/productList.do?pageNum=${page.nextPage}&cid=${cid}" aria-label="Next">
                        <span aria-hidden="true">下一页</span>
                    </a>
                </li>
            </c:if>
            <c:if test="${page.isLastPage != true}">
                <li>
                    <a href="/product/productList.do?pageNum=${page.nextPage}&cid=${cid}" aria-label="Next">
                        <span aria-hidden="true">下一页</span>
                    </a>
                </li>
            </c:if>
            <c:if test="${page.isLastPage == true}">
                <li class="disabled">
                    <a href="/product/productList.do?pageNum=${page.pages}&cid=${cid}" aria-label="Next">
                        <span aria-hidden="true">尾页</span>
                    </a>
                </li>
            </c:if>
            <c:if test="${page.isLastPage != true}">
                <li>
                    <a href="/product/productList.do?pageNum=${page.pages}&cid=${cid}" aria-label="Next">
                        <span aria-hidden="true">尾页</span>
                    </a>
                </li>
            </c:if>
        </ul>
</nav>

<jsp:include page="history.jsp"/>

<jsp:include page="foot.jsp"/>

</body>

</html>