<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ page import="java.io.InputStreamReader"
	import="java.io.IOException"
	import="java.io.LineNumberReader"%>
<%
	String backupPath = request.getParameter("path"); 
	String bTime = request.getParameter("bTime"); 
	String url = "DB_Backup.jsp";
	//out.println(bTime);
/*	String action = request.getParameter("action");
	if (action != null && action.trim().equals("DB_Backup")) {
		String backupPath = request.getParameter("path");
		String command = "cmd /c mysqldump -uroot -proot --add-locks --opt charge> " + backupPath + "charge.sql";
		try {
			Process process = Runtime.getRuntime().exec(command);
			InputStreamReader ir = new InputStreamReader(process .getInputStream());
			LineNumberReader input = new LineNumberReader(ir);
			String line;
			while ((line = input.readLine()) != null){
				System.out.println(line);
			}
			input.close();
			//out.println("���ݿ��ѵ������ļ�charge.sql��");
		} catch (IOException e) {
			e.printStackTrace();
		}
		//response.sendRedirect("DB_Backup.jsp");
		//response.setHeader("Refresh","2;URL=DB_Backup.jsp");
	}
	*/
%>
<html>
	<head>
		<title>����</title>
	</head>
	<body>
		<center>
			���ݿ��ѵ�����·��<%=backupPath%>��!
			<br>
			<span id="delay" style="background:red">3</span>���Ӻ���ת����һҳ��, ����������������� �Լ���ת
			<br>
			<a href="<%=url%>"><%=url%></a>
		</center>
		<script type="text/javascript">	
			
			var delay = 3;
			function goBack() {
				document.getElementById("delay").innerHTML=delay;
				delay--;
				if(delay == 0) 
					document.location.href="DB_Backup.jsp";
				else 
					setTimeout(goBack, 1000);
			}
			goBack();
		</script>
	</body>
</html>
