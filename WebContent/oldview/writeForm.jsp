<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"></head>
<html>
<head>
<title>�Խ���</title>
</head>
<%
	int num =0, ref=0, re_step=0, re_level=0;
	String boardid = request.getParameter("boardid");
	if(boardid==null) boardid = "1";

	if(request.getParameter("num")!=null){
	num = Integer.parseInt(request.getParameter("num")) ;
	ref = Integer.parseInt(request.getParameter("ref")) ;
	re_step = Integer.parseInt(request.getParameter("re_step")) ;
	re_level = Integer.parseInt(request.getParameter("re_level")) ;
	}
%>
<p class="w3-left"  style="padding-left:30px;"></p>
<div class="w3-container">

<center><b>�۾���</b>
<br>
<form method="post" name="writeform" action="<%=request.getContextPath() %>/view/writePro.jsp" >
<input type="hidden" name="boardid" value="<%=boardid %>">
<input type="hidden" name="num" value="<%=num %>">
<input type="hidden" name="ref" value="<%=ref %>">
<input type="hidden" name="re_level" value="<%=re_level %>">
<input type="hidden" name="re_step" value="<%=re_step %>">



<table class="w3-table-all"  style="width:70%;" >
   <tr>
    <td align="right" colspan="2" >
	    <a href="list.jsp"> �۸��</a> 
   </td>
   </tr>
   <tr>
    <td  width="70"   align="center">�� ��</td>
    <td  width="330">
       <input type="text" size="10" maxlength="10" name="writer"></td>
  </tr>
  <tr>
    <td  width="70"   align="center" >�� ��
    </td>
    <td width="330">
 
 	<%if(request.getParameter("num")==null) {%>
       <input type="text" size="40" maxlength="50" name="subject"> <!-- ������ ��� -->
       <%}else{ %>
	   <input type="text" size="40" maxlength="50" name="subject" value="[���]">	 <!-- ����� ��� -->
	   <%} %>
   
   </td>
  </tr>
  <tr>
    <td  width="70"   align="center">Email</td>
    <td  width="330">
       <input type="text" size="40" maxlength="30" name="email" ></td>
  </tr>
  <tr>
    <td  width="70"   align="center" >�� ��</td>
    <td  width="330" >
     <textarea name="content" rows="13" cols="40"></textarea> </td>
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
     
</form>  </center></div>  




</body>
</html>      
