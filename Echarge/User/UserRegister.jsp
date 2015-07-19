<%@ page language="java" contentType="text/html;charset=gb2312" pageEncoding="GB18030"%>
<%@ page import="com.Echarge.User.*"%>
<%@ page import="java.util.*"%>
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
	request.setCharacterEncoding("GBK");
	String action = request.getParameter("action");
	if (action != null && action.trim().equals("newUser")) {
		String clientAccount = request.getParameter("clientAccount");
		String clientName = request.getParameter("clientName");
		String clientPwd = request.getParameter("clientPwd");
		String clientSex = request.getParameter("clientSex");
		String cardNum = request.getParameter("cardNum");
		String clientEmail = request.getParameter("clientEmail");
		String clientTel = request.getParameter("clientTel");
		String clientPhone = request.getParameter("clientPhone");
		String clientAddress = request.getParameter("clientAddress");
		User u = null;
		try {
			u = User.checkUser(clientAccount);
		} catch (UserNotFoundException e) {
			out.println(e.getMessage());
			return;
		}
		u.setClientAccount(clientAccount);
		u.setClientName(clientName);
		u.setClientPwd(clientPwd);
		u.setClientSex(clientSex);
		u.setCardNum(cardNum);
		u.setClientEmail(clientEmail);
		u.setClientTel(clientTel);
		u.setClientPhone(clientPhone);
		u.setClientAddress(clientAddress);
		u.setCardBalance((double)0);
		u.setClientState("����");
		u.setRDate(new Date());
		u.save();
		out.println("ע��ɹ�!");
		response.sendRedirect("UserList.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>Echarge �������� - ��ӿͻ�</title>
		<link href="../css/login.css" rel="stylesheet" type="text/css" />
		<link href="../css/page_bottom.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="../js/jquery.validate.js"></script>
		<link href="../Admin/styles/main.css" rel="stylesheet" type="text/css" />
		<link href="../Admin/styles/general.css" rel="stylesheet" type="text/css" />
	
		<script>
		// �����֤���� (���֤������֤) 
		jQuery.validator.addMethod("isIdCardNo", function(value, element) {
			var reg = /^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/;
			return this.optional(element) || (reg.test(value));
		}, "��������ȷ�����֤�ţ�");
		
	$(document).ready(function() {
		$('#f').validate( {
			rules : {
				clientName : {
					required : true,
					rangelength : [ 2, 4 ]
				},
				clientAccount1 : {
					required : true,
					rangelength : [ 3, 12 ]
				},
				clientPwd : {
					required : true,
					rangelength : [ 4, 20 ]
				},
				checkPwd : {
					required : true,
					rangelength : [ 4, 20 ],
					equalTo : "#txtclientPwd"
				},
				cardNum : {
					isIdCardNo : true
				},
				clientPhone : {
					rangelength : [ 11, 11 ],
					digits : true
				},
				clientTel : {
					rangelength : [ 7, 8 ],
					digits : true
				},
				clientEmail : {
					email : true
				}
			},
			messages : {
				clientName : {
					required : "��ʵ��������Ϊ��",
					rangelength : "��ʵ����ӦΪ2-4λ֮��"
				},
				clientAccount1 : {
					required : "�˺Ų���Ϊ��",
					rangelength : "�˺�ӦΪ3-12λ֮��",
					remote : "�˺��ѱ�ռ��"
				},
				clientPwd : {
					required : "���벻��Ϊ��",
					rangelength : "����ӦΪ4-20λ֮��"
				},
				checkPwd : {
					required : "���벻��Ϊ��",
					rangelength : "����ӦΪ4-20λ֮��",
					equalTo : "�������벻һ��"
				},
				cardNum : {
					isIdCardNo : "���֤�Ų���ȷ"
				},
				clientPhone : {
					rangelength : "�ֻ������ʽ����",
					digits : "��������������"
				},
				clientTel : {
					rangelength : "�绰�����ʽ����",
					digits : "��������������"
				},
				clientEmail : {
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
		var tempLoginName = document.form1.clientAccount.value;
		if (tempLoginName == ""){//�����δ����ע����
		 	alert("�Բ�����������ע����!");
		 	return;
		}
		//����һ��XMLHttpRequest����
		createXMLHttpRequest();
		//��״̬�������󶨵�һ������
		xmlHttp.onreadystatechange = processor;
		//ͨ��GET������ָ����URL�����������ĵ���
		xmlHttp.open("GET", "UserCheckServlet?clientAccount="+tempLoginName);
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
document.form1.clientAccount.focus;
function CheckForm(){
 var theform = document.form1;
 
 if (theform['clientAccount'].value == "") {
    alert("�˺Ų���Ϊ��!");
  	theform.clientAccount.focus();
  	return false;
 }
 if (theform['clientName'].value == "") {
    alert("��������Ϊ��!");
  	theform.clientName.focus();
  	return false;
 }
 if (theform['clientPwd'].value == "") {
    alert("���벻��Ϊ��!");
  	theform.clientPwd.focus();
  	return false;
 }
 if (theform['checkPwd'].value == "") {
    alert("ȷ�����벻��Ϊ��!");
  	theform.checkPwd.focus();
  	return false;
 }
 
 if (theform['clientPwd'].value != theform['checkPwd'].value) {
    alert("�����������벻һ��!");
  	theform.clientPwd.focus();
  	return false;
 }
 return true;
}</script>
</head>
	<body>
		<table style="table-layout: fixed;" align="center" border="0" cellpadding="0" cellspacing="0" width="97%">
			<tbody>
				<tr>
				<td class="nav" align="left" nowrap="nowrap" width="100%">
					<h1>
							<span class="action-span"></span><span>Echarge �������� - ��ӿͻ�</span>
						</h1>
				</td>
				</tr>
			</tbody>
		</table>
		<br/>

		<div class="fill_message">
			<form name="form1" method="post" action="UserRegister.jsp" id="f">
			<input type="hidden" name="action" value="newUser" />
				<table class="tab_login">
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							�ͻ��˺�:
						</td>
						<td>
							<input name="clientAccount" type="text" id="txtclientAccount"
								class="text_input"/>
							<div class="text_left"><input type="button" name="checkLoginName" value="��Ч�Լ��" 
								style="width:80px" onclick="beginCheck()"/></div>
							<div class="text_left" id="clientAccountValidMsg">
								<p>
									�ͻ��˺ſ�����СдӢ����ĸ�����ġ�������ɡ�
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							��ʵ����:
						</td>
						<td>
							<input name="clientName" type="text" id="txtclientName"
								class="text_input"/>
							<div class="text_left" id="clientNameValidMsg">
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
							<input name="clientPwd" type="password" id="txtclientPwd" class="text_input"/>
							<div class="text_left" id="clientPwdValidMsg">
								<p>
									������������ɴ�СдӢ����ĸ��������ɣ�����4��20λ��
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							ȷ�������õ����룺
						</td>
						<td>
							<input name="checkPwd" type="password" id="txtcheckPwd" class="text_input"/>
							<div class="text_left" id="checkPwdValidMsg">
								<p>
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
							��ѡ���Ա�:
						</td>
						<td>
							<select name="clientSex" id="txtclientSex" class="text_input">
								<option value="">
									��ѡ��</option>
								<option value="��" >
									��</option>
								<option value="Ů" >
									Ů</option>
							</select>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
							�����ַ��
						</td>
						<td>
							<input name="clientEmail" type="text" id="txtclientEmail"
								class="text_input"/>
							<div class="text_left" id="clientEmailValidMsg">
								<p>
									����д��ȷ�������ʽ��
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
							���֤�ţ�
						</td>
						<td>
							<input name="cardNum" type="text" id="txtcardNum"
								class="text_input"/>
							<div class="text_left" id="cardNumValidMsg">
								<p>
									����д��ȷ�����֤�Ÿ�ʽ�����֤��Ϊ15λ��18λ��
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
							�̶��绰��
						</td>
						<td>
							<input name="clientTel" type="text" id="txtclientTel"
								class="text_input"/>
							<div class="text_left" id="clientTelValidMsg">
								<p>
									����д��ȷ�Ĺ̶��绰�����ʽ��
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
							�ƶ��绰��
						</td>
						<td>
							<input name="clientPhone" type="text" id="txtclientPhone"
								class="text_input"/>
							<div class="text_left" id="clientPhoneValidMsg">
								<p>
									����д��ȷ���ֻ������ʽ��
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
							סַ��
						</td>
						<td>
							<input name="clientAddress" type="text" id="txtclientAddress"
								class="text_input"/>
							<div class="text_left" id="clientAddressValidMsg">
								<p>
									�ͻ����Ϊ���������֡�
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