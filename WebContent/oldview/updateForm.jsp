<%@page import="board.BoardDataBean"%>
<%@page import="board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"></head>
<%
	String boardid = request.getParameter("boardid");
	if(boardid==null) boardid = "1";
	String pageNum = request.getParameter("pageNum");
	if(pageNum==null || pageNum==""){
		pageNum = "1"; } %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	try{
		BoardDBBean dbPro = BoardDBBean.getInstance();
		BoardDataBean
		article = dbPro.getArticle(num, boardid, "update");
%>
</head>
<body>
<div class="w3-container"><center><b>�ۼ���</b>
<br>
<form method="post" name="writeform" action="<%=request.getContextPath() %>/view/updatePro.jsp" >
<input type="hidden" name="num" value="<%=num %>">
<input type="hidden" name="boardid" value="<%=boardid %>">
<input type="hidden" name="pageNum" value="<%=pageNum %>">



<table class="w3-table-all"  style="width:70%;" >
   <tr>
    <td align="right" colspan="2" >
	    <a href="list.jsp"> �۸��</a> 
   </td>
   </tr>
   <tr>
    <td  width="70"   align="center">�� ��</td>
    <td  width="330">
       <input type="text" size="10" maxlength="10" name="writer" value="<%=article.getWriter() %>"></td>
  </tr>
  <tr>
    <td  width="70"   align="center" >�� ��
    </td>
    <td width="330">
 
 
       <input type="text" size="40" maxlength="50" name="subject" value="<%=article.getSubject() %>">
	
   
   </td>
  </tr>
  <tr>
    <td  width="70"   align="center">Email</td>
    <td  width="330">
       <input type="text" size="40" maxlength="30" name="email" value="<%=article.getEmail() %>"></td>
  </tr>
  <tr>
    <td  width="70"   align="center" >�� ��</td>
    <td  width="330" >
     <textarea name="content" rows="13" cols="40"><%=article.getContent() %></textarea> </td>
  </tr>
  <tr>
    <td  width="70"   align="center" >��й�ȣ</td>
    <td  width="330" >
     <input type="password" size="8" maxlength="12" name="passwd"> 
	 </td>
  </tr>
<tr>      
 <td colspan=2  align="center"> 
  <input type="submit" value="�۾���" >  
  <input type="reset" value="�ٽ��ۼ�">
  <input type="button" value="��Ϻ���" OnClick="window.location='list.jsp'">
</td></tr></table>    
     
</form>  </center>
	
	</div>
	<%
	}catch(Exception e){} %>

</body>
</html>