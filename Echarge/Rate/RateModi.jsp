<%@ page language="java" contentType="text/html;charset=gb2312"
	pageEncoding="GB18030"%>
<%@ page import="com.Echarge.Rate.*"%>
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
	String rateName = request.getParameter("rateName");
	Rate r = Rate.loadByName(rateName);
	String action = request.getParameter("action");
	if (action != null && action.trim().equals("RateModi")) {
		float rateValue = Float.parseFloat(request.getParameter("rateValue"));
		int rateTime = Integer.parseInt(request.getParameter("rateTime"));
		r.setRateName(rateName);
		r.setRateValue(rateValue);
		r.setRateTime(rateTime);
		r.update();
		out.println("�޸ĳɹ�!");
		response.sendRedirect("RateList.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>Echarge �������� - �޸Ĳ�����Ϣ</title>
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
				rateName : {
					required : true,
					rangelength : [ 3, 12 ]
				},
				rateValue : {
					required : true,
					number : true
				},
				rateTime : {
					required : true,
					number : true
				}
			},
			messages : {
				rateName : {
					required : "����������Ϊ��",
					rangelength : "������ӦΪ3-12λ֮��"
				},
				rateValue : {
					required : "����ֵ����Ϊ��",
					number : "������ʮ��������(����С��)"
				},
				rateTime:{
					required : "ʱ��β���Ϊ��",
					number:"������ʮ��������"
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
	function CheckForm() {
		var theform = document.form1;

		if (theform['rateName'].value == "") {
			alert("����������Ϊ��!");
			theform.rateName.focus();
			return false;
		}
		if (theform['rateValue'].value == "") {
			alert("���ʲ���Ϊ��!");
			theform.rateValue.focus();
			return false;
		}
		return true;
	}
</script>
	</head>

	<body>
		<table style="table-layout: fixed;" align="center" border="0"
			cellpadding="0" cellspacing="0" width="97%">
			<tbody>
				<tr>
					<td class="nav" align="left" nowrap="nowrap" width="100%">
						<h1>
							<span class="action-span"></span>
							<span>Echarge �������� - �޸Ĳ�����Ϣ</span>
						</h1>
					</td>
				</tr>
			</tbody>
		</table>
		<br />

		<div class="fill_message">
			<form name="form1" method="post" action="RateModi.jsp" id="f">
				<input type="hidden" name="action" value="RateModi" />
				<table class="tab_login">
					<tr>
						<td valign="top" class="w1">
							������:
						</td>
						<td>
							<div class="text_input"><%=rateName%></div>
							<input name="rateName" type="hidden" id="txtAdminName"
								class="text_input" readonly="readonly"
								value="<%=rateName%>" />
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
							<span id="mcname" style="color: red">*</span> ����ֵ:
						</td>
						<td>
							<input name="rateValue" type="text" id="txtphoneNum"
								class="text_input" value="<%=r.getRateValue()%>" />
							<div class="text_left" id="phoneNumValidMsg">
								<p>
									����ֵ�ɸ�����������ɡ�
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
							<span id="mcname" style="color: red">*</span> ʱ���:
						</td>
						<td>
							<input name="rateTime" type="text" id="txtrateTime"
								class="text_input" value="<%=r.getRateTime()%>" />
							<div class="text_left" id="rateTimeValidMsg">
								<p>
									ʱ��β���8λ������ʽ��24Сʱ��ʽ����17002300����ʾ����5�㵽11���ʱ��Ρ�
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
				</table>

				<br />
				<table align="center">
					<tr>
						<td align="center">
							<input type="submit" value="�ύ" />
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="reset" value="����" />
						</td>
					</tr>
				</table>
			</form>
		</div>
<!-- 
		<script language="javascript">
			document.form1.validFlag.value = "";
		</script> -->
	</body>
</html>