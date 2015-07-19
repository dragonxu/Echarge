<%@ page language="java" contentType="text/html;charset=gb2312"%>
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
	User u = (User) session.getAttribute("User");
	request.setCharacterEncoding("GBK");
	String action = request.getParameter("action");
	if (action != null && action.trim().equals("UserModi")) {
		String clientAccount = request.getParameter("clientAccount");
		String clientSex = request.getParameter("clientSex");
		String cardNum = request.getParameter("cardNum");
		String clientEmail = request.getParameter("clientEmail");
		String clientTel = request.getParameter("clientTel");
		String clientPhone = request.getParameter("clientPhone");
		String clientAddress = request.getParameter("clientAddress");
		u.setClientAccount(clientAccount);
		u.setClientSex(clientSex);
		u.setCardNum(cardNum);
		u.setClientEmail(clientEmail);
		u.setClientTel(clientTel);
		u.setClientPhone(clientPhone);
		u.setClientAddress(clientAddress);
		u.update();
		out.println("�޸ĳɹ�!");
		response.sendRedirect("UserInfo.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>Echarge �������� - �޸Ŀͻ���Ϣ</title>
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
				clientAccount : {
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
					equalTo : "#txtPassword"
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
				clientAccount : {
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
	</head>
	<body>
		<table style="table-layout: fixed;" align="center" border="0" cellpadding="0" cellspacing="0" width="97%">
			<tbody>
				<tr>
				<td class="nav" align="left" nowrap="nowrap" width="100%">
					<h1>
							<span class="action-span"></span>
							<span>Echarge �������� - �޸Ŀͻ���Ϣ</span>
						</h1>
				</td>
				</tr>
			</tbody>
		</table>
		<br/>

		<div class="fill_message">
			<form name="form1" method="post" action="UserModify.jsp" id="f">
			<input type="hidden" name="action" value="UserModi" />
				<table class="tab_login">
					<tr>
						<td valign="top" class="w1">
							��ʵ����:
						</td>
						<td>
							<div class="text_input"><%=u.getClientName()%></div>
							<input name="clientName" type="hidden" id="txtAdminName"
								class="text_input" readonly="readonly"
								value="<%=u.getClientName()%>" />
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
							�ͻ��˺�:
						</td>
						<td>
							<div class="text_input"><%=u.getClientAccount()%></div>
							<input name="clientAccount" type="hidden" id="txtclientAccount"
								class="text_input" readonly="readonly"
								value="<%=u.getClientAccount()%>" />
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
								class="text_input" value="<%=u.getClientEmail()%>"/>
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
								class="text_input" value="<%=u.getCardNum()%>"/>
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
								class="text_input" value="<%=u.getClientTel()%>"/>
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
								class="text_input" value="<%=u.getClientPhone()%>"/>
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
								class="text_input" value="<%=u.getClientAddress()%>"/>
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
		<script language="javascript">
		document.form1.clientSex.value = "<%=u.getClientSex()%>";
		</script>
	</body>
</html>