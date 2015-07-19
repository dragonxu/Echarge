<%@ page language="java" contentType="text/html;charset=gb2312"
	import="java.util.*"%>
<%@ page import="com.Echarge.Charging.*"%>
<%@ page import="com.Echarge.admin.*"%>
<%@ page import="com.Echarge.Rate.*"%>
<%@ page import="com.Echarge.User.*"%>
<%@ page import="com.Echarge.Analysis.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
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
	if (action != null && action.trim().equals("ChargingInsert")) {
		String clientAccount = request.getParameter("clientAccount");
		User u = null;
		try {
			u = User.checkAccount(clientAccount);
		} catch (UserNotFoundException e) {
			out.println(e.getMessage());
			return;
		}
		String machineNo = request.getParameter("machineNo");
		Analysis an = null;
		try {
			an = Analysis.checkMachineNo(machineNo);
		} catch (UserNotFoundException e) {
			out.println(e.getMessage());
			return;
		}
		Double elecQuantity = Double.parseDouble(request.getParameter("elecQuantity"));
		Double rateValue = Double.parseDouble(request.getParameter("rateValue"));
		//Double cost = Double.parseDouble(request.getParameter("cost"));
		//Double theBalance = Double.parseDouble(request.getParameter("theBalance"));
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		//Date chargingTime = df.parse(request.getParameter("chargingTime"));
		Date startTime = df.parse(request.getParameter("startTime"));
		Date endTime = df.parse(request.getParameter("endTime"));
		Charging c = new Charging();
		c.setClientAccount(clientAccount);
		c.setMachineNo(machineNo);
		c.setElecQuantity(elecQuantity);
		Double cost = elecQuantity * rateValue;//�����õ��ڷ��ʳ˳����
		Double cardBalance = u.getCardBalance();//�ͻ����
		Double theBalance = cardBalance - cost;//��ʱ�����ڿͻ�����������
		String chargingTime = ChargingMgr.getInstance().calcChargingTime(startTime,endTime);
		//���ʱ����ڽ���ʱ�����ʼʱ��
		c.setCost(cost);
		c.setTheBalance(theBalance);
		c.setChargingTime(chargingTime);
		c.setStartTime(startTime);
		c.setEndTime(endTime);
		ChargingMgr.getInstance().save(c);
		out.println("¼��ɹ�!");
		response.sendRedirect("ChargingList.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>Echarge �������� - ����¼¼��</title>
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
				},
				machineNo : {
					required : true,
					rangelength : [ 5, 5 ]
				},
				rateValue : {
					required : true
				},
				elecQuantity : {
					required : true,
					number:true
				},
				startTime : {
					required : true,
					rangelength : [ 16, 16 ]
				},
				endTime : {
					required : true,
					rangelength : [ 16, 16 ]
				},
				cFlag : {
					required : true
				}
			},
			messages : {
				clientAccount : {
					required : "�ͻ��˺Ų���Ϊ��",
					rangelength : "�ͻ��˺�ӦΪ3-12λ֮��",
					remote : "�ͻ��˺��ѱ�ռ��"
				},
				machineNo : {
					required : "���׮�Ų���Ϊ��",
					rangelength : "���׮��ӦΪ5λ"
				},
				rateValue : {
					required : "���ʲ���Ϊ��"
				},
				elecQuantity : {
					required : "���������Ϊ��",
					number: "�����Ǹ���������"
				},
				startTime:{
					required:"��ʼʱ�䲻��Ϊ��",
					rangelength: "����д��ȷ�ĸ�ʽ"
				},
				endTime:{
					required : "����ʱ�䲻��Ϊ��",
					rangelength: "����д��ȷ�ĸ�ʽ"
				},
				cFlag:{
					required : "��Ч��־����Ϊ��"
				}
			},
			errorPlacement : function(error, element) {
				error.appendTo(element.next().find("span"));
			}
		});
	});
</script>
		
		<script language="javascript">
	document.form1.loginName.focus;
	function CheckForm() {
		var theform = document.form1;
		if (theform['loginName'].value == "") {
			alert("����Ա�˺Ų���Ϊ��!");
			theform.loginName.focus();
			return false;
		}
		if (theform['clientAccount'].value == "") {
			alert("�ͻ��˺Ų���Ϊ��!");
			theform.clientAccount.focus();
			return false;
		}
		if (theform['clientName'].value == "") {
			alert("�ͻ���������Ϊ��!");
			theform.clientName.focus();
			return false;
		}
		if (theform['servFlag'].value == "") {
			alert("�������Ͳ���Ϊ��!");
			theform.servFlag.focus();
			return false;
		}
		if (theform['jtfFlag'].value == "") {
			alert("�������Ͳ���Ϊ��!");
			theform.jtfFlag.focus();
			return false;
		}
		
		if (theform['jtfMoney'].value == "") {
			alert("���ò���Ϊ��!");
			theform.jtfMoney.focus();
			return false;
		}
		
		if (theform['thenBalance'].value == "") {
			alert("��ʱ����Ϊ��!");
			theform.thenBalance.focus();
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
							<span class="action-span"></span><span>Echarge �������� - ����¼¼��</span>
						</h1>
				</td>
				</tr>
			</tbody>
		</table>
		<br/>

		<div class="fill_message">
			<form name="form1" method="post" action="ChargingInsert.jsp" id="f">
			<input type="hidden" name="action" value="ChargingInsert" />
				<table class="tab_login">
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							�ͻ��˺�:
						</td>
						<td>
							<input name="clientAccount" type="text" id="txtclientAccount"
								class="text_input"/>
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
						<span id="mcname" style="color:red">*</span>
							���׮��:
						</td>
						<td>
							<input name="machineNo" type="text" id="txtclientName"
								class="text_input"/>
							<div class="text_left" id="clientNameValidMsg">
								<p>
									���׮����5λ����������ɣ�ǰ��λ��ʾ�豸���࣬����λ��ʾ�豸�š� 
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							��������ȣ�:
						</td>
						<td>
							<input name="elecQuantity" type="text" id="txtjtfMoney"
								class="text_input"/>
							<div class="text_left" id="jtfMoneyValidMsg">
								<p>
									���������Ϊ��������С����
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<!-- <tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							���ʣ�Ԫ/�ȣ�:
						</td>
						<td>
							<select name="rateValue"  class="text_input">
								<option value="">
									��ѡ��
								</option>
								<%
									List<Rate> rates = new ArrayList<Rate>();
									Rate.getRates(rates, 1, 100);
									for (int i = 0; i < rates.size(); i++) {
										Rate r = rates.get(i);
								%>
								<option value="<%=r.getRateValue()%>"><%=r.getRateValue()%></option>
								<%
									}
								%>
							</select>
							<div class="text_left" id="jtfMoneyValidMsg">
								<p>
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr style="overflow:hidden;">
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							�����ã�Ԫ�� :
						</td>
						<td>
							<input name="cost" type="text" id="txtjtfMoney"
								class="text_input"/>
							<div class="text_left" id="jtfMoneyValidMsg">
								<p>
									�����ÿ���Ϊ��������С����
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							��ʱ��Ԫ�� :
						</td>
						<td>
							<input name="theBalance" type="text" id="txttheBalance"
								class="text_input"/>
							<div class="text_left" id="theBalanceValidMsg">
								<p>
									��ʱ������Ϊ��������С����
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							���ʱ��:
						</td>
						<td>
							<input name="chargingTime" type="text" id="txtjtfMoney"
								class="text_input"/>
							<div class="text_left" id="jtfMoneyValidMsg">
								<p>
									ʱ���ʽΪ:YYYY-MM-DD HH:MM:SS��
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr> -->
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							��ʼʱ��:
						</td>
						<td>
							<input name="startTime" type="text" class="text_input"/>
							<div class="text_left" id="jtfMoneyValidMsg">
								<p>
									ʱ���ʽΪ:YYYY-MM-DD HH:MM��
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							����ʱ��:
						</td>
						<td>
							<input name="endTime" type="text" id="txtjtfMoney"
								class="text_input"/>
							<div class="text_left" id="jtfMoneyValidMsg">
								<p>
									ʱ���ʽΪ:YYYY-MM-DD HH:MM��
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							��Ч��־:
						</td>
						<td>
							<select name="cFlag" class="text_input">
								<option value="">
									��ѡ��
								</option>
								<option value="��Ч">
									��Ч
								</option>
								<option value="��Ч">
									��Ч
								</option>
							</select>
							<div class="text_left" id="servFlagValidMsg">
								<p>
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