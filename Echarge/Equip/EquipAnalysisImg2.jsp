<%@ page language="java" contentType="text/html; charset=GB2312" pageEncoding="GB2312"%>

<%@ page import="com.Echarge.Analysis.*"%> 
<%@ page import="com.Echarge.Charging.*"%> 
<%@ page import="java.util.*"%>
<%
	//Analysis au =  new Analysis();
	List<Analysis> analysiss = new ArrayList<Analysis>();
	int macNum = Analysis.getAnalysiss2(analysiss);//���׮��Ŀ
	float[][] chargingQTY = new float[3][macNum];//ĳ��ȳ��׮j�ĳ����
	for(int x=0; x<3; x++){
		for(int y=0; y<macNum; y++){
			chargingQTY[x][y] = 0;//����ֵ
		}
	}
	
	Charging cc = new Charging();
	List<Charging> chargings = new ArrayList<Charging>();
	int totalRecords = ChargingMgr.getInstance().getChargings(chargings, 1, 999999999);
	for (int i = 0; i < chargings.size(); i++) {
		cc = chargings.get(i);
		int j = Integer.parseInt(cc.getMachineNo());//���׮��
		int year = Integer.parseInt(new java.text.SimpleDateFormat("yyyy").format(cc.getStartTime()));
		chargingQTY[year-2010][j-1] += cc.getElecQuantity();//year����׮j�ĳ��������
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>Echarge �������� - ���׮�����ͳ��ͼ</title>
		<script type="text/javascript" src="../js/FusionCharts.js"></script>
		
	<link href="../Admin/styles/main.css" rel="stylesheet" type="text/css" />
	<link href="../Admin/styles/general.css" rel="stylesheet" type="text/css" />
	<meta name="keywords" content="Discuz!,Board,Comsenz,forums,bulletin board,">
		<meta name="description" content="Echarge�豸ʹ�÷���">
		<meta name="generator" content="Discuz! 4.0.0RC4 with Templates 4.0.0">
		<meta name="MSSmartTagsPreventParsing" content="TRUE">
		<meta http-equiv="MSThemeCompatible" content="Yes">	
		
		<style type="text/css">
#redlink a:link {color:#FF0000;text-decoration:underline;}
#redlink a:visited {color:#FF0000;text-decoration:none;}
#redlink a:hover {color:#000000;text-decoration:none;}
#redlink a:active {color:#FFFFFF;text-decoration:none;} 

		
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
</head>
 
<body>
	<table id="t1" style="table-layout: fixed;" align="center" border="0" cellpadding="0" cellspacing="0" width="97%">
			<tbody>
				<tr>
				<td class="nav" align="left" nowrap="nowrap" width="100%">
					<h1>
						<span class="action-span"></span><span>Echarge ��������  - �����ͳ��</span>
					</h1>
				</td>
				</tr>
			</tbody>
		</table>
		<br> 
	<div style="text-align:center; padding-top:80px;">
    	<table width="700" align="center" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td> <div id="satisfiedorder_report_flash" style="width:700px;border:0px #ccc solid;"></div></td>
          </tr>
        </table>
    </div>
	<script type="text/javascript" >
		getchart('../Charts/ScrollLine2D.swf');
		
        //numberPrefix="."  ���ֿ�ͷ
		//rotateValues="1"  1�������� 0����
		function getchart(str){
			var chart = new FusionCharts(str, "ChartId", "600", "350"); 
			chart.setDataXML('<?xml version="1.0" encoding="UTF-8" ?>'+
				 '<chart caption="���׮�����ͳ��ͼ" subCaption="2010��-2012��" bgColor="#ffffff" xAxisName="���" yAxisName="��������ȣ�"'+
				' numberPrefix="" sformatNumberScale="1" sNumberPrefix="$" syncAxisLimits="1" rotateValues="0" showSum="0">'+
				'<categories>'+				
					'<category label="2010"/>'+
					'<category label="2011"/>'+
					'<category label="2012"/>'+
				'</categories>'+
				'<dataset seriesName="���׮1">'+
					'<set value="<%=chargingQTY[0][0]%>"/>'+
					'<set value="<%=chargingQTY[1][0]%>"/>'+
					'<set value="<%=chargingQTY[2][0]%>"/>'+
				'</dataset>'+
				'<dataset seriesName="���׮2" renderAs="line" parentYAxis="S" showValues="1" valuePosition="BELOW">'+
					'<set value="<%=chargingQTY[0][1]%>"/>'+
					'<set value="<%=chargingQTY[1][1]%>"/>'+
					'<set value="<%=chargingQTY[2][1]%>"/>'+
				'</dataset>'+
				'<dataset seriesName="���׮3" renderAs="line" parentYAxis="S" showValues="1" valuePosition="BELOW">'+
					'<set value="<%=chargingQTY[0][2]%>"/>'+
					'<set value="<%=chargingQTY[1][2]%>"/>'+
					'<set value="<%=chargingQTY[2][2]%>"/>'+
				'</dataset>'+
				'<dataset seriesName="���׮4" renderAs="line" parentYAxis="S" showValues="1" valuePosition="BELOW">'+
					'<set value="<%=chargingQTY[0][3]%>"/>'+
					'<set value="<%=chargingQTY[1][3]%>"/>'+
					'<set value="<%=chargingQTY[2][3]%>"/>'+
				'</dataset>'+
				'<dataset seriesName="���Գ��׮" renderAs="line" parentYAxis="S" showValues="1" valuePosition="BELOW">'+
					'<set value="<%=chargingQTY[0][0]+chargingQTY[0][1]+chargingQTY[0][2]+chargingQTY[0][3]%>"/>'+
					'<set value="<%=chargingQTY[1][0]+chargingQTY[1][1]+chargingQTY[1][2]+chargingQTY[1][3]%>"/>'+
					'<set value="<%=chargingQTY[2][0]+chargingQTY[2][1]+chargingQTY[2][2]+chargingQTY[2][3]%>"/>'+
				'</dataset>'+
				'</chart>');
			
			chart.render("satisfiedorder_report_flash");
		}
   </script>
</body>
</html>
