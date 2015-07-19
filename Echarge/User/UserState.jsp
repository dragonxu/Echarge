<%@ page language="java" contentType="text/html;charset=gb2312"
	pageEncoding="GB18030"%>
<%@ page import="java.util.*"%>
<%@ page import="com.Echarge.User.*"%>
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
	User u = (User) session.getAttribute("User");
	String action = request.getParameter("action");
	if (action != null && action.trim().equals("State")) {
		String clientAccount = request.getParameter("clientAccount");
		String clientState = request.getParameter("clientState");
		clientState = new String(clientState.getBytes("iso-8859-1"),"gbk");
		u.setClientAccount(clientAccount);
		u.setClientState(clientState);
		u.updateState();
		out.println("���ĳɹ�!");
		response.sendRedirect("UserList.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>Echarge �������� - �����ͻ�</title>
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
					remote : "�˺Ų�����"
				}
			},
			errorPlacement : function(error, element) {
				error.appendTo(element.next().find("span"));
			}
		});
	});
</script>

<script type="text/javascript">	
	document.form1.clientAccount.focus;
 	function check()
    {
        var radios = document.getElementsByName("clientState");
        for(var i=0;i<radios.length;i++)
        {
            if(radios[0].checked==true)
            {
                alert("�����ͻ���");
            }
            else if(radios[1].checked==true)
            {
                alert("�����ͻ���");
            } 
            else return false;           
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
			<span class="action-span"></span><span>Echarge �������� - �����ͻ�</span>
						</h1>
				</td>
				</tr>
			</tbody>
		</table>
		<br/>

		<div class="fill_message">
			<form name="form1" method="post" action="UserState.jsp" id="f">
			<input type="hidden" name="action" value="State" />
				<table class="tab_login">
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							�ͻ��˺�:
						</td>
						<td>
							<div class="text_input"><%=u.getClientAccount()%></div>
							<input name="clientAccount" type="hidden" id="txtclientAccount"
								class="text_input" value="<%=u.getClientAccount()%>"/>
							<div class="text_left" id="clientAccountValidMsg">
								<p>
									�ͻ��˺ſ�����СдӢ����ĸ�����ġ�������ɣ�����3��12���ַ���һ������Ϊһ���ַ���
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
							ѡ��һ�ֹ���:
						</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;
							<span><input type="radio" name="clientState" value="����"/>����</span>
							<span><input type="radio" name="clientState" value="����"/>����</span>
						</td>
					</tr>
				</table>
				
				<br/>
				<table align="center">
				<tr>
					<td align="center">
						<input type="submit" value="�ύ" onclick="return check()"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="reset" value="����" />
					</td>
				</tr>
				</table>
			</form>
		</div>
	<script language="javascript">
		var clientState = "<%=u.getClientState()%>"
        var radios = document.getElementsByName("clientState");
		if(clientState=="����"){
			radios[0].checked=true;
		}else{
			radios[1].checked=true;
		}
	</script>
	</body>
</html>