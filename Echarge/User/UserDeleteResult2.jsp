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
	String clientAccount = request.getParameter("clientAccount");
//	String url = request.getParameter("from");
	try {
		User u = User.checkAccount(clientAccount);
	} catch (Exception e) {
		out.println(e.getMessage());
		return;
	}
	User.deleteAccount(clientAccount);
	out.println("ɾ���ɹ���");
	response.sendRedirect("UserList.jsp");
%>

<html>
	<head>
		<title>ɾ���ͻ�</title>
	</head>
	<body>
		<center>		
		</center>
		<script type="text/javascript">	
			parent.main.location.reload();			
		</script>
	</body>
</html>
