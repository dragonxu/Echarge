<%@ page language="java" contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.*"%>
<%@ page import="com.Echarge.admin.*" %>

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
	if (loginName == null) {
		loginName = a.getLoginName();
	}
	Admin b = null;
	try {
		b = Admin.checkName(loginName);
	} catch (UserNotFoundException e) {
		out.println(e.getMessage());
		return;
	}
	request.setCharacterEncoding("GBK");
	String action = request.getParameter("action");
	if (action != null && action.trim().equals("modiPwd")) {
		String loginPwd = request.getParameter("loginPwd");
		b.setLoginName(loginName);
		b.setLoginPwd(loginPwd);
		b.updatePassword();
		out.println("���ĳɹ�!");
		return;
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<title>Echarge �������� - �޸����� </title>
	
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<link href="../css/login.css" rel="stylesheet" type="text/css" />
		<link href="../css/page_bottom.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="../js/jquery.validate.js"></script>
		<link href="styles/main.css" rel="stylesheet" type="text/css" />
		<link href="styles/general.css" rel="stylesheet" type="text/css" />	
	
		<script>

	$(function() {

		$('#f').validate( {
			rules : {
				loginPwd : {
					required : true,
					rangelength : [ 4, 20 ]
				},
				checkPwd : {
					required : true,
					rangelength : [ 4, 20 ],
					equalTo : "#txtPassword"
				}
			},
			messages : {
				loginPwd : {
					required : "���벻��Ϊ��",
					rangelength : "����ӦΪ4-20λ֮��"
				},
				checkPwd : {
					required : "���벻��Ϊ��",
					rangelength : "����ӦΪ4-20λ֮��",
					equalTo : "�������벻һ��"
				}
			},
			errorPlacement : function(error, element) {
				error.appendTo(element.next().find("span"));
			}
		});
	});
</script>
	<script language="javascript">
		
        document.register.loginPwd.focus();
        function test(){
             var f=document.register;
             var newPsw1 = f.loginPwd.value;
             var newPsw2 = f.loginPwd2.value;
             if(newPsw1 == "" || newPsw2 == ""){
                  alert("�������Ϊ��!");
                  f.loginPwd.value='';
                  f.loginPwd2.value='';
                  f.loginPwd.focus();
                  return false;
             }
             if(newPsw1 != newPsw2){
                  alert("�����������벻һ��!");
                  f.loginPwd.value='';
                  f.loginPwd2.value='';
                  f.loginPwd.focus();
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
							<span class="action-span"></span><span>Echarge �������� - �޸�����</span>
						</h1>
					</td>
				</tr>
			</tbody>
		</table>
		<br/>

		<div class="fill_message">
			<form name="form1" method="post" action="Admin_ModiPSW.jsp" id="f">
			<input type="hidden" name="action" value="modiPwd" />
				<table class="tab_login">
					<tr>
						<td valign="top" class="w1">
							�û��˺�:
						</td>
						<td>
							<div class="text_input"><%=b.getLoginName()%></div>
							<input name="loginName" type="hidden" id="txtLoginName"
								class="text_input" readonly="readonly"
								value="<%=loginName%>" />
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							�������룺
						</td>
						<td>
							<input name="loginPwd" type="password" id="txtPassword"
								class="text_input" />
							<div class="text_left" id="passwordValidMsg">
								<p>
									������������ɴ�СдӢ����ĸ��������ɣ�����4��20λ��
								</p>
								<span id="password.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							�ٴ����������õ����룺
						</td>
						<td>
							<input name="checkPwd" type="password" id="txtRepeatPass"
								class="text_input" />
							<div class="text_left" id="repeatPassValidMsg">
								<span id="password1.info" style="color: red"></span>
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