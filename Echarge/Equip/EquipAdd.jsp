<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="com.Echarge.Analysis.*"%>
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
	if (action != null && action.trim().equals("EquipAdd")) {
		//String equipName = request.getParameter("equipName");
		//String equipModel = request.getParameter("equipModel");
		String equipNo = request.getParameter("equipNo");
		String noteMsg = request.getParameter("noteMsg");
		//String intactFlag = request.getParameter("intactFlag");
		//int useNum = Integer.parseInt(request.getParameter("useNum"));
		//String rDate = request.getParameter("rDate");
		//Double useTime = Double.parseDouble(request.getParameter("useTime"));
		Analysis au = new Analysis();
		try {
			au = Analysis.checkEquipNo(equipNo);
		} catch (UserNotFoundException e) {
			out.println(e.getMessage());
			return;
		}
		au.setEquipName("���׮");
		au.setEquipModel("cdz_1");
		au.setEquipNo(equipNo);
		au.setNoteMsg(noteMsg);
		//au.setIntactFlag("��");
		au.setUseNum(0);
		au.setrDate(new Date());
		au.setUseTime("0��0��0��0ʱ0��0��");
		au.save();
		response.sendRedirect("EquipAnalysis.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>Echarge �������� - ����豸</title>
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
				equipName : {
					required : true,
					rangelength : [ 2, 12 ]
				},
				equipModel : {
					required : true,
					rangelength : [ 2, 12 ]
				},
				equipNo:{
					required:true,
					rangelength:[5,5],
					digits:true
				},
				intactFlag:{
					required:true
				},
				useNum:{
					required:true,
					digits:true
				},
				rDate:{
					required:true
				},
				useTime : {
					required : true,
					number:true
				}
			},
			messages : {
				equipName : {
					required : "�豸���Ʋ���Ϊ��",
					rangelength : "�豸����ӦΪ2-12λ֮��"
				},
				equipModel : {
					required : "�豸�ͺŲ���Ϊ��",
					rangelength : "˵���ͺ�ӦΪ2-12λ֮��"
				},
				equipNo:{
					required:"�豸��Ų���Ϊ��",
					rangelength:"�豸���ӦΪ5λ",
					digits:"��������������"
				},
				intactFlag:{
					required:"��ѡ���豸״̬��"
				},
				useNum:{
					required:"�豸ʹ�ô�������Ϊ��",
					digits:"�豸ʹ�ô���Ϊ��������"
				},
				rDate:{
					required:"�豸ע��ʱ�䲻��Ϊ��"
				},
				useTime : {
					required:"�豸ʹ��ʱ�䲻��Ϊ��",
					number:"�豸ʹ��ʱ��Ϊʮ�������֣�����С����"
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
		if (theform['equipName'].value == "") {
			alert("�豸���Ʋ���Ϊ��!");
			theform.equipName.focus();
			return false;
		}
		if (theform['equipNo'].value == "") {
			alert("�豸��Ų���Ϊ��!");
			theform.equipNo.focus();
			return false;
		}
		if (theform['firstTime'].value == "") {
			alert("��ʼʱ�䲻��Ϊ��!");
			theform.firstTime.focus();
			return false;
		}		
		if (theform['lastTime'].value == "") {
			alert("����ʱ�䲻��Ϊ��!");
			theform.lastTime.focus();
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
			<span class="action-span"></span><span>Echarge �������� - ����豸</span>
					</h1>
				</td>
				</tr>
			</tbody>
		</table>
		<br/>

		<div class="fill_message">
			<form name="form1" method="post" action="EquipAdd.jsp" id="f">
			<input type="hidden" name="action" value="EquipAdd" />
				<table class="tab_login">
					
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							����д���׮��:
						</td>
						<td>
							<input name="equipNo" type="text" id="equipNo" class="text_input" />
							<div class="text_left" id="equipNoValidMsg">
								<p>
									�豸�����5λ����������ɣ�ǰ��λ��ʾ�豸���࣬����λ��ʾ�豸�š�
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
							��ע:
						</td>
						<td>
							<input name="noteMsg" type="text" id="noteMsg" class="text_input" />
							<div class="text_left" id="useNumValidMsg">
								<p>
									
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<!--
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							�豸�Ƿ����:
						</td>
						<td>
							<select name="intactFlag" class="text_input">
								<option value="">��ѡ��</option>
								<option value="��">��</option>
								<option value="��">��</option>
							</select>
							<div class="text_left" id="intactFlagValidMsg">
								<p>
									&nbsp;��ѡ���豸״̬��
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							�豸ʹ�ô���:
						</td>
						<td>
							<input name="useNum" type="text" id="useNum" class="text_input" />
							<div class="text_left" id="useNumValidMsg">
								<p>
									�豸ʹ�ô���������������ɡ�
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							�豸ע������:
						</td>
						<td>
							<input name="rDate" type="text" class="text_input" />
							<div class="text_left" id="rDateValidMsg">
								<p>
									ʱ����д��ʽΪ:YYYY-MM-DD��
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" class="w1">
						<span id="mcname" style="color:red">*</span>
							�豸ʹ��ʱ�䣨�£�:
						</td>
						<td>
							<input name="useTime" type="text" id="useTime" class="text_input" />
							<div class="text_left" id="useTimeValidMsg">
								<p>
									�豸ʹ��ʱ���ɸ�����������ɡ�
								</p>
								<span id="name.info" style="color: red"></span>
							</div>
						</td>
					</tr>-->
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