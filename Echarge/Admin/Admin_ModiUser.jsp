<%@ page language="java" contentType="text/html;charset=gb2312" pageEncoding="GB18030"%>
<%@ page import="com.Echarge.admin.*" %>
<%@ page import="com.Echarge.Role.*" %>
<%@ page import="java.util.*"%>

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
	a = null;
	try {
		a = Admin.checkName(loginName);
	} catch (UserNotFoundException e) {
		out.println(e.getMessage());
		return;
	}
	request.setCharacterEncoding("GBK");
	String action = request.getParameter("action");
	if (action != null && action.trim().equals("modify")) {
		String adminEmail = request.getParameter("adminEmail");
		String phoneNum = request.getParameter("phoneNum");
		String adminAddress = request.getParameter("adminAddress");
		String adminType = request.getParameter("adminType");
		adminType = new String(adminType.getBytes("ISO-8859-1"),"gb2312");
		a.setLoginName(loginName);
		a.setAdminEmail(adminEmail);
		a.setPhoneNum(phoneNum);
		a.setAdminAddress(adminAddress);
		a.setAdminType(adminType);
		a.update();
		out.println("�޸ĳɹ�");
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<title>Echarge �������� - �޸���Ϣ </title>
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
				phoneNum:{
					required:true,
					rangelength:[11,11],
					digits:true
				},
				adminEmail:{
					required:true,
					email:true
				}
			},
			messages : {
				phoneNum:{
					required:"�ֻ����벻��Ϊ��",
					rangelength:"�ֻ������ʽ����",
					digits:"��������������"
				},
				adminEmail:{
					required : "email����Ϊ��",
					email : "��������ȷ��email��ʽ"
				}
			},
			errorPlacement : function(error, element) {
				error.appendTo(element.next().find("span"));
			}
		});
	});
</script>

		<script language="javascript">
document.form1.adminName.focus;
function CheckForm(){
 var theform = document.form1;
 //var errMsg = "";
 var setfocus = "";
 
 if (theform['adminName'].value == "") {
    alert("��ʵ��������Ϊ��!");
    theform.adminName.focus();
  	return false;
 }
 if (theform['loginName'].value == "") {
    alert("�˺Ų���Ϊ��!");
  	theform.loginName.focus();
  	return false;
 }
 if (theform['phoneNum'].value == "") {
    alert("�绰����Ϊ��!");
  	theform.phoneNum.focus();
  	return false;
 }
 if (theform['adminAddress'].value == "") {
    alert("��ַ����Ϊ��!");
  	theform.adminAddress.focus();
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
							<span class="action-span"></span><span>Echarge �������� - �޸��û���Ϣ</span>
						</h1>
				</td>
				</tr>
			</tbody>
		</table>
		<br/>

		<div class="fill_message">
			<form name="form1" method="post" action="Admin_ModiUser.jsp" id="f">
			<input type="hidden" name="action" value="modify" />
				<table class="tab_login">
					<tr>
						<td valign="top" class="w1">
							�û���ʵ����:
						</td>
						<td>
							<div class="text_input"><%=a.getAdminName()%></div>
							<input name="adminName" type="hidden" id="txtAdminName" class="text_input" readonly="readonly" value="<%=a.getAdminName()%>"/>
							<div class="text_left" id="adminNameValidMsg">
								<p>
									��ʵ����������������ɣ�����2��4���ַ���һ������Ϊһ���ַ���
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
							�û��˺�:
						</td>
						<td>
							<div class="text_input"><%=loginName%></div>
							<input name="loginName" type="hidden" id="txtLoginName" class="text_input" readonly="readonly" value="<%=a.getLoginName()%>"/>
							<div class="text_left" id="loginNameValidMsg">
								<p>
									�û��˺ſ�����СдӢ����ĸ�����ġ�������ɣ�����3��12���ַ���һ������Ϊһ���ַ���
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							����д����Email��ַ��
						</td>
						<td>
							<input name="adminEmail" type="text" id="txtadminEmail" class="text_input" value="<%=a.getAdminEmail()%>"/>
							<div class="text_left" id="adminEmailValidMsg">
								<p>
									����д��Ч��Email��ַ��
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							����д�����ֻ�����:
						</td>
						<td>
							<input name="phoneNum" type="text" id="txtphoneNum" class="text_input" value="<%=a.getPhoneNum()%>"/>
							<div class="text_left" id="phoneNumValidMsg">
								<p>
									�绰����������������ɣ�����11���ַ���
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
							����д����סַ:
						</td>
						<td>
							<input name="adminAddress" type="text" id="txtadminAddress" class="text_input" value="<%=a.getAdminAddress()%>"/>
							<div class="text_left" id="adminAddressValidMsg">
								<p>
									סַ������СдӢ����ĸ�����ġ�������ɡ�
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
							<span id="mcname" style="color: red">*</span>
								�û�����:
						</td>
						<td>
							<select name="adminType"  class="text_input"/>
								<option value="">
									��ѡ��
								</option>
								<%
									List<Role> roles = new ArrayList<Role>();
									Role.getRoles(roles, 1, 10);
									for (int i = 0; i < roles.size(); i++) {
										Role r = roles.get(i);
								%>
								<option value="<%=r.getRoleName()%>"><%=r.getRoleName()%></option>
								<%
									}
								%>
							</select>
							<div class="text_left" id="adminTypeValidMsg">
								<p>
									&nbsp;��ѡ����ȷ���û����ͣ���ͬ���͵��û����в�ͬ��Ȩ��
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

<script language="javascript">
document.form1.adminType.value = "<%=a.getAdminType()%>";
</script>
</body>
</html>