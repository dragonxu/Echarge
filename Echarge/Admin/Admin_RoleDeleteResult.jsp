<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ page import="com.Echarge.admin.*"%>
<%@ page import="com.Echarge.Role.*"%>

<%
	//���session���鿴�û��Ƿ��½
	Admin a = (Admin) session.getAttribute("admin");
	if (a == null) {
		response.sendRedirect("../Admin_Login.jsp");
		return;
	}
%>

<%
	String roleName = request.getParameter("roleName");
	roleName = new String(roleName.getBytes("iso-8859-1"),"gbk");
	String url = request.getParameter("from");
	try {
		Role r = Role.checkName(roleName);
	} catch (UserNotFoundException e) {
		out.println(e.getMessage());
		return;
	}
	Role.deleteRoleName(roleName);
	out.println("ɾ���ɹ���");
	response.sendRedirect("Admin_RoleList.jsp");
%>

<html>
	<head>
		<title>ɾ���û�</title>
	</head>
	<body>
		<center>		
		</center>
	</body>
</html>
