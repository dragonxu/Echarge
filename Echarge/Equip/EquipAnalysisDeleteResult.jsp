<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ page import="com.Echarge.admin.*"%>
<%@ page import="com.Echarge.Analysis.*"%>

<%
	//���session���鿴�û��Ƿ��½
	Admin a = (Admin) session.getAttribute("admin");
	if (a == null) {
		response.sendRedirect("../Admin_Login.jsp");
		return;
	}
%>

<%
	String equipNo = request.getParameter("equipNo");
//	String url = request.getParameter("from");
	Analysis.delete(equipNo);
	out.println("ɾ���ɹ���");
	response.sendRedirect("EquipAnalysis.jsp");
%>

<html>
	<head>
		<title>ɾ��ʹ�÷���</title>
	</head>
	<body>
		<center>		
		</center>
		<script type="text/javascript">	
			parent.main.location.reload();			
		</script>
	</body>
</html>
