<%@ page language="java" contentType="text/html;charset=gb2312"  pageEncoding="GB18030"%>
<%@ page import="com.Echarge.admin.*" %>
<%@ page import="com.Echarge.User.*" %>
<%@ page import="java.util.*"%>
<%
	//���session���鿴�û��Ƿ��½
	Admin a = (Admin) session.getAttribute("admin");
	if (a == null) {
		response.sendRedirect("../Admin_Login.jsp");
		return;
	}
%>
<%	
	User u = (User) session.getAttribute("User");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="Cache-Control" content="no-cache, must-revalidate" />
	<meta http-equiv="expires" content="Wed, 26 Feb 1970 08:21:57 GMT" />
	<title>�綯�������ܳ��ϵͳ</title>
	<link href="../Admin/styles/general.css" rel="stylesheet" type="text/css" />
	<link href="../Admin/styles/main.css" rel="stylesheet" type="text/css" />
</head>
<body>
<h1>
<span class="action-span"></span><span>Echarge ��������  - �ͻ���Ϣ</span>
</h1>
<div class="list-div">
<table cellspacing='1' cellpadding='3' border="0">
  <tr>
    <th colspan="4" align="center"  class="tab-front">������Ϣ</th>
  </tr>
  <tr>
    <td width="20%" align="right" >�˺ţ�</td>
    <td width="30%" ><%=u.getClientAccount()%></td>
    <td width="20%" align="right" >������</td>
    <td width="30%" ><%=u.getClientName()%></td>
  </tr>
  <tr>
	<td align="right" >���룺</td>
    <td >*******</td>
    <td align="right" ></td>
    <td ></td>
  </tr>
</table>
<table cellspacing='1' cellpadding='3' border="0">
  <tr>
    <th colspan="4" class="tab-front" align="center">��ϸ��Ϣ</th>
  </tr>
  <tr>
    <td width="20%" align="right">�Ա�</td>
    <td width="30%"><%=u.getClientSex()%></td>
    <td width="20%" align="right">�����ַ��</td>
    <td width="30%"><%=u.getClientEmail()%></td>
  </tr>
  <tr>
    <td align="right">֤�����ͣ�</td>
    <td><%=u.getCardType()%></td>
    <td align="right">֤�����룺</td>
    <td><%=u.getCardNum()%></td>
  </tr>
  <tr>
    <td align="right">�̶��绰��</td>
    <td><%=u.getClientTel()%></td>
    <td align="right">�ƶ��绰��</td>
    <td><%=u.getClientPhone()%></td>
  </tr>
  <tr>
    <td align="right">סַ��</td>
    <td><%=u.getClientAddress()%></td>
    <td align="right" ></td>
    <td ></td>
  </tr>
</table>
<table cellspacing='1' cellpadding='3' border="0">
  <tr>
    <th colspan="4" align="center"  class="tab-front">�˻���Ϣ</th>
  </tr>
  <tr>
    <td width="20%" align="right" >��</td>
    <td width="30%" ><%=u.getCardBalance()%></td>
    <td width="20%" align="right" >����������<br /></td>
    <td width="30%" >
    	<input type="button" value="��������" style="width:160px;" onclick="javascript:window.location.href ='UserState.jsp';"/>
    </td>
  </tr>
  <tr>
	<td align="right" >״̬��</td>
    <td ><%=u.getClientState()%></td>
    <td align="right" ></td>
    <td ></td>
  </tr>
  <tr>
    <td align="right">ע��ʱ�䣺</td>
    <td ><%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(u.getRDate())%></td>
    <td align="right" ></td>
    <td ></td>
  </tr>
</table>
</div>
<div id="footer"></div>
</body>
</html>