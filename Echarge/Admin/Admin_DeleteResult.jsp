<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ page import="com.Echarge.admin.*"%>

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
	//String url = request.getParameter("from");
	try {
		a = Admin.checkName(loginName);
	} catch (UserNotFoundException e) {
		out.println(e.getMessage());
		return;
	}
	Admin.deleteLoginName(loginName);
	out.println("ɾ���ɹ���");
	response.sendRedirect("Admin_UserList.jsp");
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
