<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ page import="com.Echarge.Charging.*"%>
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
	final int PAGE_SIZE = 10; //ÿҳ��ʾ��������¼
	final int PAGES_PER_TIME = 10;//ÿ����ʾ���ٸ�ҳ������
	int pageNo = 1;
	String strPageNo = request.getParameter("pageNo");
	if (strPageNo != null && !strPageNo.trim().equals("")) {
		try {
			pageNo = Integer.parseInt(strPageNo);
		} catch (NumberFormatException e) {
			pageNo = 1;
		}
	}
	if (pageNo <= 0)
		pageNo = 1;
%>
<%
	List<Charging> chargings = new ArrayList<Charging>();
	Charging c = null;
	int totalRecords = 0;
	int totalPages = 0;

	//����������ѯ
	String clientAccount = request.getParameter("clientAccount");
	clientAccount = new String(clientAccount.getBytes("ISO-8859-1"),
			"gb2312");
	//	out.println(clientAccount);
	String machineNo = request.getParameter("machineNo");
	machineNo = new String(machineNo.getBytes("ISO-8859-1"), "gb2312");
	//	out.println(machineNo);
	String dateFirst = request.getParameter("dateFirst");
	String dateLast = request.getParameter("dateLast");

	if (!clientAccount.equals("������ͻ��˺�")
			&& !machineNo.equals("��������׮��")) {
		totalRecords = ChargingMgr.getInstance().getSearchResult3(
				chargings, pageNo, PAGE_SIZE, clientAccount, machineNo,
				dateFirst, dateLast);
	} else if (clientAccount.equals("������ͻ��˺�")
			&& !machineNo.equals("��������׮��")) {
		totalRecords = ChargingMgr.getInstance().getSearchResult2(
				chargings, pageNo, PAGE_SIZE, machineNo, dateFirst,
				dateLast);
	} else if (!clientAccount.equals("������ͻ��˺�")
			&& machineNo.equals("��������׮��")) {
		totalRecords = ChargingMgr.getInstance().getSearchResult1(
				chargings, pageNo, PAGE_SIZE, clientAccount, dateFirst,
				dateLast);
	} else {
		totalRecords = ChargingMgr.getInstance().getSearchResult0(
				chargings, pageNo, PAGE_SIZE, dateFirst, dateLast);
	}

	totalPages = (totalRecords + PAGE_SIZE - 1) / PAGE_SIZE;
	if (pageNo > totalPages)
		pageNo = totalPages;
%>
<html>
	<head>
	<link href="../Admin/styles/main.css" rel="stylesheet" type="text/css" />
	<link href="../Admin/styles/general.css" rel="stylesheet" type="text/css" />	
	<title>�ͻ�����</title>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<meta name="keywords"
			content="Discuz!,Board,Comsenz,forums,bulletin board,">
		<meta name="description" content="Echarge�ͻ�����">
		<meta name="generator" content="Discuz! 4.0.0RC4 with Templates 4.0.0">
		<meta name="MSSmartTagsPreventParsing" content="TRUE">
		<meta http-equiv="MSThemeCompatible" content="Yes">	
		
		<style type="text/css">
		<!--
a			{ text-decoration: none; color: #000000 }
a:hover			{ text-decoration: underline }
body			{ scrollbar-base-color: #F3F6FA; scrollbar-arrow-color: #4D76B3; font-size: 12px; background-color: #ffffff }
table			{ font: 12px Verdana,Tahoma; color: #000000 }
input,select,textarea	{ font: 11px Verdana,Tahoma; color: #000000; font-weight: normal; background-color: #F3F6FA }
select			{ font: 11px Verdana,Tahoma; color: #000000; font-weight: normal; background-color: #F3F6FA }
.nav			{ font: 12px Verdana,Tahoma; color: #000000; font-weight: bold }
.nav a			{ color: #000000 }
.header			{ font: 11px Verdana,Tahoma; color: #000000; font-weight: bold; background-image: url("images/green/bg01.gif") }
.header a		{ color: #FFFFFF }
.category		{ font: 11px Verdana,Tahoma; color: #000000; background-color: #EFEFEF }
.tableborder		{ background: #80BDCB; border: 0px solid #4D76B3 } 
.singleborder		{ font-size: 0px; line-height: 0px; padding: 0px; background-color: #F3F6FA }
.smalltxt		{ font: 11px Verdana,Tahoma }
.outertxt		{ font: 12px Verdana,Tahoma; color: #000000 }
.outertxt a		{ color: #000000 }
.bold			{ font-weight: bold }
.altbg1			{ background: #F3F6FA }
.altbg2			{ background: #FFFFFF }
-->
		</style>
		<script language="JavaScript" src="../Admin/images/common.js"></script>
		<style type="text/css">.cPopText { font-family: Tahoma, Verdana; background-color: #FFFFCC; border: 1px #000000 solid; font-size: 12px; padding-right: 4px; padding-left: 4px; height: 20px; padding-top: 2px; padding-bottom: 2px; visibility: hidden; filter: Alpha(Opacity=80)}</style>
			
		<script type="text/javascript">
	function mm(f) {
		if (f == 1) {
			lay1.style.display = "inline"
			lay2.style.display = "none"
		} else if(f == 2){
			lay1.style.display = "none"
			lay2.style.display = "inline"
		} else if (f == 3) {
			lay3.style.display = "inline"
			lay4.style.display = "none"
		} else {
			lay3.style.display = "none"
			lay4.style.display = "inline"
		}

	}
	</script>

<script type="text/javascript">
function Hidden(t1,t2,t3,t4,t5){
	var t1,t2,t3,t4;//���ID
	t1.style.display="none";//�л�Ϊ����״̬
	t2.style.display="none";
	t3.style.display="none";
	t4.style.display="none";
	t5.style.display="none";
	window.print(); 
	t1.style.display="";//�л�Ϊ��ʾ״̬
	t2.style.display="";
	t3.style.display="";
	t4.style.display="";
	t5.style.display="";
	return;
}
</script>	
	
<script type="text/javascript">
function ExportToExcel(Id){
	var mStr;
	mStr = window.document.body.innerHTML ;
	var mWindow = window;
	window.document.body.innerHTML =Id.innerHTML;  
	document.write(window.document.body.innerHTML);
	document.execCommand("saveAs","true","ChargingList.xls");	
	window.document.body.innerHTML = mStr;
	history.back();
}
</script>	

<script type="text/javascript" src="../js/date.js"></script>
<script>
var oCalendarChs=new PopupCalendar("oCalendarChs"); //��ʼ���ؼ�ʱ,�����ʵ������:oCalendarChs
oCalendarChs.weekDaySting=new Array("��","һ","��","��","��","��","��");
oCalendarChs.monthSting=new Array("һ��","����","����","����","����","����","����","����","����","ʮ��","ʮһ��","ʮ����");
oCalendarChs.oBtnTodayTitle="����";
oCalendarChs.oBtnCancelTitle="ȡ��";
oCalendarChs.Init();
</script>

	</head>
	
	<body leftmargin="0" rightmargin="0" topmargin="0" onkeydown="if(event.keyCode==27) return false;">
		<div id="popLayer" style="position: absolute; z-index: 1000;"class="cPopText"></div>
	
		<table id="t1" style="table-layout: fixed;" align="center" border="0"
			cellpadding="0" cellspacing="0" width="97%">
			<tbody>
				<tr>
				<td class="nav" align="left" nowrap="nowrap" width="100%">
					<h1>
				<span class="action-span"></span><span>Echarge ��������  - �ͻ����� </span>
				</h1>
				</td>
					
				</tr>
			</tbody>
		</table>
		
		
	<form method="post" name="form1" action="ChargingSearchResult.jsp">
	<input type="hidden" name="action" value="ChargingSearch" />
	<table id="t2" style="border-bottom:dotted #999999 1px;" align="center" border="0" cellpadding="0" cellspacing="0" width="97%">
		<tr>
			<td width="35%" align="left" nowrap="nowrap">
				<input id=5 type=radio name=r2 value=5 checked onclick=mm(3)><label for="5">���г��׮</label>
				<span id=lay3 style="display:inline"></span>
			
				<input id=6 type=radio name=r2 value=6 onclick=mm(4)><label for="6">ָ�����׮</label>
				<span id=lay4 style="display:none"><input type="text" name="machineNo" value="��������׮��"></span>
			</td>
			<td align="left" nowrap="nowrap" width="35%">	
				<input id=1 type=radio name=r1 value=1 checked onclick=mm(1)><label for="1">���пͻ�</label>
				<span id=lay1 style="display:inline"></span> 
				
				<input id=2 type=radio name=r1 value=2 onclick=mm(2)><label for="2">ָ���ͻ�</label>
				<span id=lay2 style="display:none"><input type="text" name="clientAccount" value="������ͻ��˺�"></span>	
			</td>
			<td class="nav" align="right" nowrap="nowrap">
				<input type="submit" value="��ѯ"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="����"/>
			</td>
		</tr>
	</table>
	<table id="t3" style="border-bottom:dotted #999999 1px;" align="center" border="0" cellpadding="0" cellspacing="0" width="97%">
		<tr>	
			<td align="left" nowrap="nowrap" width="35%"><span class="nav">					
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span class="outertxt">
				<label for="3">��ʼ����</label>
				<input id=3 readonly type="text" name="dateFirst"
				onclick="getDateString(this,oCalendarChs)" value="2000-01-01" size="20">
			</span><span class="nav">			    </span></td>
			<td align="left" nowrap="nowrap"><span class="nav">				
				&nbsp;&nbsp;&nbsp;&nbsp;</span><span class="outertxt">&nbsp;
				<label for="4">��������</label>
				<input id=4 readonly type="text" name="dateLast"
				onclick="getDateString(this,oCalendarChs)" value="2050-12-31" size="20">
			</span><span class="nav">			    </span></td>
		</tr>
	</table><br>
		
		<table id="t4" align="center" border="0" cellpadding="0" cellspacing="0" width="97%">
			<tbody>
				<tr>
					<td>
						<table border="0" cellpadding="0" cellspacing="0">
							<tbody>
								<tr>
									<td height="3"></td>
								</tr>
								<tr>
									<td>
										<table class="tableborder" cellpadding="2" cellspacing="1">
											<tbody>
												<tr class="smalltxt" bgcolor="#f3f6fa">
													<td class="header">
														&nbsp;<%=totalRecords%>
													</td>
													<td class="header">
														&nbsp;<%=pageNo%>/<%=totalPages%>&nbsp;
													</td>
													
													<%
																											int start = ((pageNo - 1) / PAGES_PER_TIME) * PAGES_PER_TIME + 1;
																											for (int i = start; i < start + PAGES_PER_TIME; i++) {
																												if (i > totalPages)
																													break;
																												if (pageNo == i) {
																										%>
															<td bgcolor="#ffffff">&nbsp;<u><b><%=i%></b></u>&nbsp;</td>
														<%
															} else {
														%>
															<td>&nbsp;
																<a href="ChargingList.jsp?pageNo=<%=i%>"><%=i%></a>&nbsp;
															</td>
													<%
														}
														}
													%>
															<td>&nbsp;
																<a href="ChargingList.jsp?pageNo=<%=pageNo + 1%>">&gt;</a>&nbsp;
															</td>
													
													<td>
														&nbsp;
														<a href="http://bbs.allsmart.com/member.php?action=list&amp;srchmem=&amp;order=&amp;admins=&amp;page=100">&gt;<b>|</b>
														</a>&nbsp;
													</td>
													<td style="padding: 0pt;">
														<input name="custompage" size="2"
															style="border: 1px solid rgb(77, 118, 179);"
															onKeyDown="javascript: if(window.event.keyCode == 13) window.location='member.php?action=list&srchmem=&order=&admins=&page='+this.value;"
															type="text">
													</td>
												</tr>
											</tbody>
										</table>
									</td>
								</tr>
								<tr>
									<td height="3"></td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>

				<input name="formhash" value="93a2a31f" type="hidden">
		<div id="EXCEL">
		<table class="tableborder" align="center" cellpadding="4" cellspacing="1" width="97%">
			<tbody>
				<tr class="header">
					<td align="center" width="7%">
						�����
					</td>
					<td align="center" width="7%">
						�ͻ��˺�
					</td>
					<td align="center" width="7%">
						���׮��
					</td>
					<td align="center" width="9%">
						��������ȣ�
					</td>
					<td align="center" width="9%">
						�����ã�Ԫ��
					</td>	
					<td align="center" width="9%">
						��ʱ��Ԫ��
					</td>
					<td align="center" width="9%">
						���ģʽ
					</td>
					<td align="center" width="12%">
						���ʱ��
					</td>
					<td align="center" width="12%">
						��ʼʱ��
					</td>
					<td align="center" width="12%">
						����ʱ��
					</td>
				</tr>
				<%
						for (int i = 0; i < chargings.size(); i++) {
						c = chargings.get(i);
				%>

				<tr>					
					<td class="altbg2" align="center">
						<%=c.getcID()%>
					</td>					
					<td class="altbg1" align="center">
						<%=c.getClientAccount()%>
					</td>									
					<td class="altbg1" align="center">
						<%=c.getMachineNo()%>
					</td>
					<td class="altbg1" align="center">
						<%=c.getElecQuantity()%>
					</td>
					<td class="altbg1" align="center">
						<%=c.getCost()%>
					</td>
					<td class="altbg1" align="center">
						<%=c.getTheBalance()%>
					</td>				
					<td class="altbg1" align="center">
						<%=c.getChargingMode()%>
					</td>				
					<td class="altbg1" align="center">
						<%=c.getChargingTime()%>
					</td>
					<td class="altbg1" align="center">
						<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(c.getStartTime())%>
					</td>
					<td class="altbg1" align="center">
						<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(c.getEndTime())%>
					</td>
					<td class="altbg1" align="center">
						<div id="redlink"><a href="ChargeDetailInfo.jsp?cID=<%=c.getcID()%>">��ϸ</a></div>
					</td>		
				</tr>
				<%
				}
				 %>
			</tbody>
		</table></div><br>
		
		<table id="t5" style="table-layout: fixed;" align="center" border="0" cellpadding="0" cellspacing="0" width="97%">
			<tr>
				<td class="nav" align="center" nowrap="nowrap" width="100%">
					<input type="button" value="��ӡ" onclick="return Hidden(t1,t2,t3,t4,t5)"/>&nbsp;
					<input type="button" value="����" onclick="return ExportToExcel(EXCEL)">
				</td>
			</tr>
		</table>
	</form>
	</body>
</html>