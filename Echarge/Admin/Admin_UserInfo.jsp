<%@ page language="java" contentType="text/html;charset=gb2312" %>
<%@ page import="com.Echarge.admin.*" %>
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
	String loginName = request.getParameter("loginName");
	Admin b = null;
	try {
		b = Admin.checkName(loginName);
	} catch (UserNotFoundException e) {
		out.println(e.getMessage());
		return;
	}
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
	<link href="styles/general.css" rel="stylesheet" type="text/css" />
	<link href="styles/main.css" rel="stylesheet" type="text/css" />
</head>
<body>
<h1>
<span class="action-span"></span><span>Echarge ��������  - �û���Ϣ</span></h1>
<div class="list-div">
<table cellspacing='1' cellpadding='3' border="0">
  <tr>
    <th colspan="4" align="center"   class="tab-front">������Ϣ</th>
  </tr>
  <tr>
    <td width="20%" align="right"  >�û��˺ţ�</td>
    <td width="30%"  ><%=loginName%></td>
    <td width="20%" align="right"  >�û�������</td>
    <td width="30%"  ><%=a.getAdminName()%></td>
  </tr>
  <tr>
	<td align="right"  >���룺</td>
    <td  >*******</td>
    <td align="right"  >����������</td>
    <td  >
    	<input type="button" value="�޸�����" style="width:160px;" 
    	onclick="javascript:window.location.href ='Admin_ModiPSW.jsp?loginName=<%=b.getLoginName()%>';"/>
    </td>
  </tr>
</table>
<table cellspacing='1' cellpadding='3' border="0">
  <tr>
    <th colspan="4" class="tab-front" align="center">��ϸ��Ϣ</th>
  </tr>
  <tr>
    <td width="20%" align="right">�û����ͣ�</td>
    <td width="30%"><%=b.getAdminType()%></td>
    <td width="20%" align="right">�����ַ��</td>
    <td width="30%"><%=b.getAdminEmail()%></td>
  </tr>
  <tr>
    <td align="right">סַ��</td>
    <td><%=b.getAdminAddress()%></td>
    <td align="right">�ƶ��绰��</td>
    <td><%=b.getPhoneNum()%></td>
  </tr>
  <tr>
    <td align="right">ע��ʱ�䣺</td>
    <td><%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(b.getAddDate())%></td>
    <td align="right"  >����������</td>
    <td  >
    	<input type="button" value="�޸ĸ�����Ϣ" style="width:160px;" 
    	onclick="javascript:window.location.href ='Admin_ModiUser.jsp?loginName=<%=b.getLoginName()%>';"/>
    </td>
  </tr>
</table>
</div>
<div id="footer"></div>
</body>
</html>