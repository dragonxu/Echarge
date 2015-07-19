<%@ page language="java" contentType="text/html;charset=gb2312" import="java.util.*"%>
<%@ page import="com.Echarge.admin.*" %>
<%@ page import="com.Echarge.User.*" %>
<%
	//���session���鿴�û��Ƿ��½
	Admin a = (Admin) session.getAttribute("admin");
	if (a == null) {
		response.sendRedirect("../Admin_Login.jsp");
		return;
	}
%>
<%
	String action = request.getParameter("action");
	if (action != null && action.trim().equals("SearchUser")) {
		String clientAccount = request.getParameter("clientAccount");
		User u = null;
		try {
			u = User.checkBlacklist(clientAccount);
		} catch (Exception e) {
			out.println(e.getMessage());
			return;
		}
		session.setAttribute("User", u);
		response.sendRedirect("BlackUserInfo.jsp");
	}
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<title>Echarge �������� - ���ҿͻ�</title>
		<link href="../css/login.css" rel="stylesheet" type="text/css" />
		<link href="../css/page_bottom.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="../js/jquery.validate.js"></script>
		<link href="../Admin/styles/main.css" rel="stylesheet" type="text/css" />
		<link href="../Admin/styles/general.css" rel="stylesheet" type="text/css" />	
	
		<script>

	$(function() {

		$('#f').validate( {
			rules : {
				clientAccount : {
					required : true,
					rangelength : [ 3, 12 ]
				}
			},
			messages : {
				clientAccount : {
					required : "�˺Ų���Ϊ��",
					rangelength : "�˺�ӦΪ3-12λ֮��",
					remote : "�˺��ѱ�ռ��"
				}
			},
			errorPlacement : function(error, element) {
				error.appendTo(element.next().find("span"));
			}
		});
	});
</script>
	<script language="javascript">
document.form1.clientAccount.focus;
function CheckForm(){
 var theform = document.form1;
 
 if (theform['clientAccount'].value == "") {
    alert("�˺Ų���Ϊ��!");
  	theform.clientAccount.focus();
  	return false;
 }
 return true;
}
</script>
</head>
<body>
		<table style="table-layout: fixed;" align="center" border="0" cellpadding="0" cellspacing="0" width="97%">
			<tbody>
				<tr>
				<td class="nav" align="left" nowrap="nowrap" width="100%">
					<h1>
							<span class="action-span"></span><span>Echarge ��������  - ���ҿͻ�</span>
						</h1>
				</td>
				</tr>
			</tbody>
		</table>
		<br/>

		<div class="fill_message">
			<form name="form1" method="post" action="UserSearchBlacklist.jsp" id="f">
			<input type="hidden" name="action" value="SearchUser" />
				<table class="tab_login">
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							�ͻ��˺�:
						</td>
						<td>
							<input name="clientAccount" type="text" id="txtclientAccount" class="text_input" />
							<div class="text_left" id="clientAccountValidMsg">
								<p>
									�ͻ��˺ſ�����СдӢ����ĸ�����ġ�������ɣ�����3��12���ַ���һ������Ϊһ���ַ���
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
				</table>
				
				<br/>
				<table align="center">
				<tr>
					<td align="center">
						<input type="submit" value="�ύ"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="reset" value="����" />
					</td>
				</tr>
				</table>
			</form>
		</div>
</body>
</html>