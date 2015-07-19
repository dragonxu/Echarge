<%@ page language="java" contentType="text/html;charset=gb2312" import="java.util.*"%>
<%@ page import="com.Echarge.admin.*" %>
<%@ page import="com.Echarge.Charging.*" %>
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
	if (action != null && action.trim().equals("ChargingSearch")) {
		int ID =  Integer.parseInt(request.getParameter("ID"));
		Charging c = null;
		try {
			c = ChargingMgr.getInstance().checkID(ID);
		} catch (UserNotFoundException e) {
			out.println(e.getMessage());
			return;
		}
		session.setAttribute("Charging", c);
		response.sendRedirect("ChargingInfo.jsp");
	}
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<title>Echarge �������� - ����¼��ѯ</title>
		<link href="../css/login.css" rel="stylesheet" type="text/css" />
		<link href="../css/page_bottom.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="../js/jquery.validate.js"></script>
		<link href="../Admin/styles/main.css" rel="stylesheet" type="text/css" />
		<link href="../Admin/styles/general.css" rel="stylesheet" type="text/css" />
	
		<script>
	$(document).ready(function() {
		$('#f').validate( {
			rules : {
				ID : {
					required : true
				}
			},
			messages : {
				ID : {
					required : "����Ų���Ϊ��"
				}
			},
			errorPlacement : function(error, element) {
				error.appendTo(element.next().find("span"));
			}
		});
	});
</script>
	
	
	<script language="javascript">
document.form1.ID.focus;
function CheckForm(){
 var theform = document.form1;
 
 if (theform['ID'].value == "") {
    alert("����Ų���Ϊ��!");
  	theform.ID.focus();
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
							<span class="action-span"></span><span>Echarge �������� - ����¼��ѯ</span>
						</h1>
				</td>
				</tr>
			</tbody>
		</table>
		<br/>

		<div class="fill_message">
			<form name="form1" method="post" action="ChargingInfo.jsp" id="f">
			<input type="hidden" name="action" value="ChargingSearch" />
				<table class="tab_login">
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							����д�����:
						</td>
						<td>
							<input name="ID" type="text" id="txtID"
								class="text_input"/>
							<div class="text_left" id="IDValidMsg">
								<p>
									����д��ȷ�ĳ���š�
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