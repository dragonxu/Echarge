<%@ page language="java" contentType="text/html;charset=gb2312" pageEncoding="GB18030"%>
<%@ page import="com.Echarge.admin.*"%>
<%@ page import="com.Echarge.Role.*"%>
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
	request.setCharacterEncoding("GBK");
	String action = request.getParameter("action");
	if (action != null && action.trim().equals("newAdmin")) {
		String adminName = request.getParameter("adminName");
		String loginName = request.getParameter("loginName");
		String loginPwd = request.getParameter("loginPwd");
		String adminEmail = request.getParameter("adminEmail");
		String phoneNum = request.getParameter("phoneNum");
		String adminAddress = request.getParameter("adminAddress");
		String adminType = request.getParameter("adminType");
		try {
			a = Admin.checkName1(loginName);
		} catch (UserNotFoundException e) {
			out.println(e.getMessage());
			return;
		}
		a.setAdminName(adminName);
		a.setLoginName(loginName);
		a.setLoginPwd(loginPwd);
		a.setAdminEmail(adminEmail);
		a.setPhoneNum(phoneNum);
		a.setAdminAddress(adminAddress);
		a.setAdminType(adminType);
		a.setAddDate(new Date());
		a.save();
		response.sendRedirect("Admin_UserList.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<title>Echarge �������� - ����û�</title>
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
				adminName : {
					required : true,
					rangelength : [ 2, 4 ]
				},
				loginName1 : {
					required : true,
					rangelength : [ 3, 12 ]
				},
				loginPwd : {
					required : true,
					rangelength : [ 4, 20 ]
				},
				checkPwd : {
					required : true,
					rangelength : [ 4, 20 ],
					equalTo : "#txtPassword"
				},
				phoneNum:{
					required:true,
					rangelength:[11,11],
					digits:true
				},
				adminEmail:{
					email:true
				},
				adminType:{
					required:true
				}
			},
			messages : {
				adminName : {
					required : "��ʵ��������Ϊ��",
					rangelength : "��ʵ����ӦΪ2-4λ֮��"
				},
				loginName1 : {
					required : "�˺Ų���Ϊ��",
					rangelength : "�˺�ӦΪ3-12λ֮��",
					remote : "�˺��ѱ�ռ��"
				},
				loginPwd : {
					required : "���벻��Ϊ��",
					rangelength : "����ӦΪ4-20λ֮��"
				},
				checkPwd : {
					required : "���벻��Ϊ��",
					rangelength : "����ӦΪ4-20λ֮��",
					equalTo : "�������벻һ��"
				},
				phoneNum:{
					required:"�ֻ����벻��Ϊ��",
					rangelength:"�ֻ������ʽ����",
					digits:"��������������"
				},
				adminEmail:{
					email : "��������ȷ��email��ʽ"
				},
				adminType:{
					required:"��ѡ���û�����"
				}
			},
			errorPlacement : function(error, element) {
				error.appendTo(element.next().find("span"));
			}
		});
	});
</script>

<script language="javascript">
	//����һ���������ڴ��XMLHttpRequest����
	var xmlHttp; 
	
	//�ú������ڴ���һ��XMLHttpRequest����
	function createXMLHttpRequest() {
		if (window.ActiveXObject) {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		} 
		else if (window.XMLHttpRequest) {
			xmlHttp = new XMLHttpRequest();
		}
	}
		
	//����һ������AJAX�첽ͨ�ŵķ���
	function beginCheck(){
		var tempLoginName = document.form1.loginName.value;
		if (tempLoginName == ""){//�����δ����ע����
		 	alert("�Բ�����������ע����!");
		 	return;
		}
		//����һ��XMLHttpRequest����
		createXMLHttpRequest();
		//��״̬�������󶨵�һ������
		xmlHttp.onreadystatechange = processor;
		//ͨ��GET������ָ����URL�����������ĵ���
		xmlHttp.open("GET", "AdminCheckServlet?loginName="+tempLoginName);
		//��������
		xmlHttp.send(null);
	}
	
	//����һ��������״̬�ı�ĺ���
	function processor () {
		//����һ���������ڴ�Ŵӷ��������ص���Ӧ���
		var responseContext;
		if(xmlHttp.readyState == 4) { //�����Ӧ���
			if(xmlHttp.status == 200) {//������سɹ�
				//ȡ������������Ӧ����
				responseContext = xmlHttp.responseText;
				//���ע���������Ч
				if (responseContext.indexOf("true")!=-1){
					alert("��ϲ������ע������Ч��");
				}else{
					alert("�Բ��𣬸�ע�����ѱ�ʹ�ã�");
				}
			}
		}
	}
</script>

		<script language="javascript">
		<!--start_of_saved_settings-->
<!--type,text,name,adminName,required,true,errMsg,��ʵ��������Ϊ��!-->
<!--type,text,name,loginName,required,true,errMsg,�˺Ų���Ϊ��!-->
<!--type,password,name,loginPwd,required,true,errMsg,���벻��Ϊ��!-->
<!--type,password,name,checkPwd,required,true,errMsg,ȷ�����벻��Ϊ��!-->
<!--type,text,name,phoneNum,required,true,errMsg,�绰����Ϊ��!-->
<!--type,text,name,adminAddress,required,true,errMsg,��ַ����Ϊ��!-->
<!--end_of_saved_settings-->
document.form1.adminName.focus;
function CheckForm(){
 var theform = document.form1;
 //var errMsg = "";
 //var setfocus = "";
 
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
 if (theform['loginPwd'].value == "") {
    alert("���벻��Ϊ��!");
  	theform.loginPwd.focus();
  	return false;
 }
 if (theform['checkPwd'].value == "") {
    alert("ȷ�����벻��Ϊ��!");
  	theform.checkPwd.focus();
  	return false;
 }
 
 if (theform['loginPwd'].value != theform['checkPwd'].value) {
    alert("�����������벻һ��!");
  	theform.loginPwd.focus();
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
			<span class="action-span"></span><span>Echarge ��������  - ����û�</span>
					</h1>
				</td>
				</tr>
			</tbody>
		</table>
		<br/>

		<div class="fill_message">
			<form name="form1" method="post" action="Admin_AddUser.jsp" id="f">
			<input type="hidden" name="action" value="newAdmin" />
				<table class="tab_login">
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							�û��˺�:
						</td>
						<td>
							<input name="loginName" type="text" id="txtLoginName"
								class="text_input" />
							<div class="text_left"><input type="button" name="checkLoginName" value="��Ч�Լ��" 
								style="width:80px" onclick="beginCheck()"/></div>
							<div class="text_left" id="loginNameValidMsg">
								<p>
									�û��˺ſ�����СдӢ����ĸ�����ġ�������ɡ�
								</p>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							�û���ʵ����:
						</td>
						<td>
							<input name="adminName" type="text" id="txtAdminName" class="text_input" />
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
					<tr>
						<td valign="top" class="w1">
							����д����Email��ַ��
						</td>
						<td>
							<input name="adminEmail" type="text" id="txtadminEmail" class="text_input" />
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
							<input name="phoneNum" type="text" id="txtphoneNum" class="text_input" />
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
							<input name="adminAddress" type="text" id="txtadminAddress" class="text_input" />
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
	</body>
</html>