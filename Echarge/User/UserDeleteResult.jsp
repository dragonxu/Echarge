<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ page import="com.Echarge.admin.*"%>
<%@ page import="com.Echarge.User.*"%>

<%
	//���session���鿴�û��Ƿ��½
	Admin a = (Admin) session.getAttribute("admin");
	if (a == null) {
		response.sendRedirect("../Admin_Login.jsp");
		return;
	}
%>

<%
int ID = Integer.parseInt(request.getParameter("ID"));
String url = request.getParameter("from");
User.delete(ID);
	response.sendRedirect("UserList.jsp");
%>

<html>
	<head>
		<title>ɾ���ͻ�</title>
	</head>
	<body>
		<center>
			ɾ���ɹ�!			
		</center>
		<script type="text/javascript">	
			parent.main.location.reload();			
		</script>
	</body>
</html>
