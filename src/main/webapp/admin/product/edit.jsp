<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false" %>

<HTML>
	<HEAD>
		<meta http-equiv="Content-Language" content="zh-cn">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<LINK href="${pageContext.request.contextPath}/WEB-INF/css/Style1.css" type="text/css" rel="stylesheet">
	</HEAD>
	
	<body>
		<!--  -->
		<form id="userAction_save_do" name="Form1"  enctype="multipart/form-data">
			<input type="hidden" name="pid" value="${requestScope.products.pid}">
			
			
			&nbsp;
			<table cellSpacing="1" cellPadding="5" width="100%" align="center" bgColor="#eeeeee" style="border: 1px solid #8ba7e3" border="0">
				<tr>
					<td class="ta_01" align="center" bgColor="#afd1f3" colSpan="4"
						height="26">
						<strong><STRONG>编辑商品</STRONG>
						</strong>
					</td>
				</tr>

				<tr>
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
						商品名称：
					</td>
					<td class="ta_01" bgColor="#ffffff">
						<input type="text" name="name" value="${requestScope.products.name}" id="name" class="bg"/>
					</td>
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
						是否热门：
					</td>
					<td class="ta_01" bgColor="#ffffff">

						<select id="is_hot" name="is_hot">
								<c:if test="${requestScope.products.is_hot == 1}">
									<option value="1" selected="selected">是</option>
									<option value="0">否</option>
								</c:if>

								<c:if test="${requestScope.products.is_hot != 1}">
									<option value="0"name="" selected="selected">否</option>
									<option value="1">是</option>
								</c:if>
						</select>
					</td>
				</tr>
				<tr>
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
						市场价格：
					</td>
					<td class="ta_01" bgColor="#ffffff">
						<input type="text" name="market_price" value="${requestScope.products.market_price}" id="market_price" class="bg"/>
					</td>
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
						商城价格：
					</td>
					<td class="ta_01" bgColor="#ffffff">
						<input type="text" name="shop_price" value="${requestScope.products.shop_price}" id="shop_price" class="bg"/>
					</td>
				</tr>
				<tr>
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
						商品图片：
					</td>
					<td class="ta_01" bgColor="#ffffff" colspan="3">
						<div>
							<img name="image" src="${pageContext.request.contextPath}/${requestScope.products.image}" alt="${requestScope.products.name}">
						</div>
						<input type="file" name="upload" id="image" />
					</td>
				</tr>
				<tr>
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
						所属分类：
					</td>
					
						<td class="ta_01" bgColor="#ffffff" colspan="3">
							
							<select id="cid" name="cid">
								<c:forEach items="${requestScope.list}" var="list">
									<c:if test="${requestScope.products.cid == list.cid}">
										<option value="${list.cid}" selected="selected">${list.cname}</option>
									</c:if>
									
									<c:if test="${requestScope.products.cid != list.cid}">
										<option value="${list.cid}"name="${list.cid}">${list.cname}</option>
									</c:if>
								</c:forEach>
							</select>
							
						</td>
					
				</tr>
				<tr>
					<td width="18%" align="center" bgColor="#f5fafe" class="ta_01">
						商品描述：
					</td>
					<td class="ta_01" bgColor="#ffffff" colspan="3">
						<textarea name="desc" id="desc" value="${requestScope.products.desc}" rows="5" cols="30">${requestScope.products.desc}</textarea>
					</td>
				</tr>
				<tr>
					<td class="ta_01" style="WIDTH: 100%" align="center"
						bgColor="#f5fafe" colSpan="4">
						<button type="button" id="userAction_save_do_submit" value="确定" onclick="update()" class="button_ok">
							&#30830;&#23450;
						</button>

						<FONT face="宋体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT>
						<button type="reset" value="重置" class="button_cancel">&#37325;&#32622;</button>

						<FONT face="宋体">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT>
						<INPUT class="button_ok" type="button" onclick="history.go(-1)" value="返回"/>
						<span id="Label1"></span>
					</td>
				</tr>
			</table>
		</form>
	</body>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"></script>

<script>
	function update() {
		$.ajax({
			type : "POST",
			url : "/updateProduct?pid=${requestScope.products.pid}",
			data : {
			    name : $("#name").val(),
				is_hot : $("#is_hot").val(),
                market_price : $("input[name='market_price']").val(),
                shop_price : $("input[name='shop_price']").val(),
				cid : $("#cid").val(),
				desc : $("#desc").val()
            },
			success : function () {
				location.href = "/productManage?pageId=0"
            }
			   });
    }
</script>
</HTML>