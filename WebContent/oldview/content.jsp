<%@page import="board.BoardDataBean"%>
<%@page import="board.BoardDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>�Խ���</title>
</head>
<%String boardid = request.getParameter("boardid");
	if(boardid==null) boardid = "1";%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	if(pageNum==null || pageNum==""){
		pageNum = "1";	}
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	try{
		BoardDBBean dbPro = BoardDBBean.getInstance();
		BoardDataBean article = dbPro.getArticle(num, boardid, "content");
		int ref = article.getRef();
		int re_step = article.getRe_step();
		int re_level = article.getRe_level();
%>
<body>
<center><br><br><b>�۳��� ����</b>
<div class="container">
<table class="w3-table-all" style="width: 80%;">
	<tr height="30">
		<td width="125" align="center">�۹�ȣ</td>
		<td width="125" align="center"><%=article.getNum() %></td>
		<td width="125">��ȸ��</td>
		<td width="125" align="center"><%=article.getReadcount() %></td>
	</tr>
	<tr height="30">
		<td width="125">�ۼ���</td>
		<td width="125" align="center"><%=article.getWriter() %></td>
		<td width="125" align="center">�ۼ���</td>
		<td align="center" width="125" align="center"><%=sdf.format(article.getReg_date()) %></td>
	</tr>
	<tr height="30">
		<td align="center" width="125">������</td>
		<td align="center" width="375" colspan="3"><%=article.getSubject() %></td>
	</tr>
	<tr height="30">
		<td align="center" width="125">�۳���</td>
		<td align="left" width="375" colspan="3"><pre><%=article.getContent() %></pre></td>
	</tr>
	<tr height="30">
		<td colspan="4" class="w3-center">
		<input type="button" value="�ۼ���" onclick="document.location.href='updateForm.jsp?num=<%=article.getNum() %>&pageNum=<%=pageNum %>'">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="�ۻ���" onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum() %>&pageNum=<%=pageNum %>'">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="��۾���" onclick="document.location.href='writeForm.jsp?num=<%=num %>&ref=<%=ref %>&re_step=<%=re_step %>&re_level=<%=re_level %>&pageNum=<%=pageNum %>'">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="�۸��" onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
		</td>
	</tr>
</table>	
	
	<%
	}catch(Exception e){} %>

</div>
</center>
</body>
</html>