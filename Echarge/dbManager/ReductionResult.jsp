<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ page import="java.io.InputStreamReader"
	import="java.io.IOException"
	import="java.io.LineNumberReader"%>
<%	
	String path =null;
	String url = "http://localhost/dbManager/DB_Reduction.jsp";
	String action = request.getParameter("action");
	if (action != null && action.trim().equals("DB_Reduction")) {
		Runtime rt = Runtime.getRuntime();
		rt.exec("cmd /c mysqladmin -uroot -proot create charge");
		path = request.getParameter("path");//·��
		String command = "cmd /c mysql -uroot -h 10.22.78.218 -proot charge < " + path;
		try {
			Process process = rt.exec(command);
			InputStreamReader ir = new InputStreamReader(process .getInputStream());
			LineNumberReader input = new LineNumberReader(ir);
			String line;
			while ((line = input.readLine()) != null){
				System.out.println(line);
			}
			input.close();
			//out.println("�ļ�charge.sql�ѵ��뵽���ݿ���");
		} catch (IOException e) {
			e.printStackTrace();
		}
		//response.sendRedirect("DB_Reduction.jsp");
	}
%>
<html>
	<head>
		<title>����</title>
	</head>
	<body>
		<center>
			·��<%=path%>�е�sql�ļ��ѵ��뵽���ݿ���!
			<br>
			<span id="delay" style="background:red">3</span>���Ӻ���ת����һҳ��, ����������������� �Լ���ת
			<br>
			<a href="<%=url%>"><%=url%></a>
		</center>
		<script type="text/javascript">	
			
			var delay = 3;
			function goBack() {
				document.getElementById("delay").innerHTML=delay;
				delay --;
				if(delay == 0) 
					document.location.href='<%=url%>';
				else 
					setTimeout(goBack, 2000);
			}
			goBack();
		</script>
	</body>
</html>
