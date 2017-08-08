<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--
<%@ page import="java.util.*"  %>

<%@ page import="com.model2.mvc.service.domain.Product" %>
<%@ page import="com.model2.mvc.common.Search" %>
<%@page import="com.model2.mvc.common.Page"%>
<%@page import="com.model2.mvc.common.util.CommonUtil"%>

<%	//Product���� Ư���� ��
	String auth = request.getParameter("menu"); 
	 System.out.println("listProdut.jsp���� request.getParameter('menu')�� : "+request.getParameter("menu"));
	 if(auth==null){
	 		auth = "search";
	 		System.out.println("auth�� "+auth);
	 }
%>

<%
	List<Product> list= (List<Product>)request.getAttribute("list");
	Page resultPage=(Page)request.getAttribute("resultPage");	
	Search search = (Search)request.getAttribute("search");
	
	//==> null �� ""(nullString)���� ����
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());	
%>
--%>
 
<html>
<head>
<title>��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
function fncGetProductList(currentPage) {
	document.getElementById("currentPage").value = currentPage;
   	document.detailForm.submit();		
}

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/product/listProduct?menu=${param.menu }&sortBy=${param.sortBy}" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					
						<c:if test="${param.menu =='manage'}">
							��ǰ ����
						</c:if>
						<c:if test="${param.menu =='search'}">
							��ǰ �����ȸ
						</c:if>
						<c:if test="${param.menu !='search' && param.menu !='manage'}">
							menu�� ã�� ���߽��ϴ�.
						</c:if>
					
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
					<option value="0" ${!empty search.searchCondition && search.searchCondition==0 ? "selected":"" }>��ǰ��ȣ</option>
					<option value="1"  ${!empty search.searchCondition && search.searchCondition==1 ? "selected":"" }>��ǰ��</option>
					<option value="2" ${!empty search.searchCondition && search.searchCondition==2? "selected":"" }>��ǰ����</option>
			</select>
			<input type="text" name="searchKeyword"  
						 value="${! empty search.searchKeyword ? search.searchKeyword : ""}"   
						 class="ct_input_g" style="width:200px; height:19px" />
		</td>
	
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetProductList('1');">�˻�</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >
				��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����&nbsp; 
						<a href="/product/listProduct?menu=${param.menu }&sortBy=desc">��</a>
						<a href="/product/listProduct?menu=${param.menu }&sortBy=asc">��</a>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
<%--
	for(int i=0; i<list.size(); i++) {
		Product vo = list.get(i);	
--%>	
<c:set var="i" value="0"/>
<c:forEach var="product" items="${list }">
	<c:set var="i" value="${i+1 }"/>
	<tr class="ct_list_pop">
		<td align="center">${i }</td>
		<td></td>
		<td align="left">
			<c:if test="${ sessionScope.user.role=='admin' || empty product.proTranCode}">
				<a href="/product/getProduct?prodNo=${product.prodNo }&menu=${param.menu}">
			</c:if>
				${product.prodName}</a>
		</td>
		<td></td>
		<td align="right">${product.priceAmount}�� &nbsp;&nbsp;</td>
		<td></td>
		<td align="center">${product.manuDate}</td>
		<td></td>
		<td align="center">	
		
		
			<c:if test="${empty product.proTranCode}">
					�Ǹ���
			</c:if>
			<c:if test="${!empty product.proTranCode}">
			
				<c:if test="${sessionScope.user.role=='admin'}">
					<c:choose >
						<c:when test="${product.proTranCode=='1  ' }">
							���ſϷ� &nbsp; <a href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=2">����ϱ�</a>
						</c:when>
						<c:when test="${product.proTranCode=='2  ' }">
							����� 
						</c:when>
						<c:otherwise>
							��ۿϷ�
						</c:otherwise>
					</c:choose>				
					</c:if>	
						
					<c:if test="${empty sessionScope.user || sessionScope.user.role=='user'}">
						������
					</c:if>	
				</c:if>


		</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	</c:forEach>
	
	
	
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		<input type="hidden" id="currentPage" name ="currentPage" value=""/>
				<jsp:include page="../common/productPageNavigator.jsp"/>	
    	</td>
	</tr>
</table>

</form>

</div>
</body>
</html>
