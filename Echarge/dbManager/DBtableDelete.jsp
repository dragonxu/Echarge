<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ page import="com.Echarge.admin.*"%>
<%@ page import="com.Echarge.DBtable.*"%>
<%
	//���session���鿴�û��Ƿ��½
	Admin a = (Admin) session.getAttribute("admin");
	if (a == null) {
		response.sendRedirect("../Admin_Login.jsp");
		return;
	}
%>

<%
	String tableName = request.getParameter("tableName");
	String url = request.getParameter("from");
	DBtable.deleteTable(tableName);
	out.println("ɾ���ɹ���");
	response.sendRedirect("DB_Backup.jsp");
%>

<html>
	<head>
		<title>ɾ�����ݿ��</title>
	</head>
	<body>
		<center>		
		</center>
	</body>
</html>
