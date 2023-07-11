<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<script>
	function emptyCheck(){
		var ComCode = document.Mat_Registform.Company_input.value;
		var MatType = document.Mat_Registform.Material_Type.value;
		var MatCharType = document.Mat_Registform.Material_Character.value;
		var MatChaType_Des = document.Mat_Registform.Material_description.value;
		var TotalLeng = document.Mat_Registform.TotalLeng_input.value;
		var SerialNum = document.Mat_Registform.SerialNum_input.value;
		
		if(!ComCode || !MatType || !MatCharType || !MatChaType_Des || !TotalLeng || !SerialNum){
			alert('모든 항목을 입력하세요.');
			return false;
		} else{
			return true;
		}
	}
	</script>
		<style>
		.table-container {
			display: flex;
			justify-content: space-between;
			margin: 0 auto;
			max-width: 1000px;
		}

		.table-container table {
			border: 1px solid blue;
			margin: 10px;
		}

		.table-container th {
			text-align: center;
			background: rgb(111, 167, 235);
			color: white;
	}
	</style>
<title>Material Regist</title>
</head>
<body>
<%
	Connection conn = null;

	String url = "jdbc:mysql://localhost:3306/campusdb";
	String id = "root"; //MySQL에 접속을 위한 계정의 ID
	String pwd = "jinsang1027#"; //MySQL에 접속을 위한 계정의 암호
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pwd);
%>
<div class="table-container">
	<table border=1 bordercolor="blue" style="margin-left: auto; margin-right: auto;">
			<tr style="text-align: center; background: rgb(111,167,235); color: white ;">
				<th>ComCode</th><th>MatType</th><th>MatTypeDes</th><th>use/unuse</th>
				<th>CreatDate</th><th>CreatorID</th>
			</tr>
			<%
			
			PreparedStatement pstmt_1 = null;
			ResultSet rs_1 = null;
			
			String sql_1 = "SELECT * FROM material_1";
			pstmt_1 = conn.prepareStatement(sql_1);
			
			rs_1 = pstmt_1.executeQuery();
			
			while(rs_1.next()){
				String ComCode = rs_1.getString("ComCode");
				String MatType = rs_1.getString("MatType");
				String MatTypeDes = rs_1.getString("MatTypeDes");
				String Use_Unuse = rs_1.getString("use/unuse");
				String CreatDate = rs_1.getString("CreatDate");
				String CreatorID = rs_1.getString("CreatorID");
			%>
			<tr style="text-align:center;">
				<td><%=ComCode %></td>
				<td><%=MatType %></td>
				<td><%=MatTypeDes %></td>
				<td><%=Use_Unuse%></td>
				<td><%=CreatDate%></td>	
				<td><%=CreatorID%></td>
			</tr>
			<% 
			}
			%>	
		</table>

	
	<table border=1 bordercolor=blue style="margin-left: auto; margin-right: auto;">
			<tr style="text-aligh: center; background: rgb(111,167,235); color: white;">
				<th>ComCode</th><th>MatCharType</th><th>MatCharTypeDesc</th><th>CharLeng</th>
			</tr>
		
<% 	
	PreparedStatement pstmt_2 = null;
	ResultSet rs_2 = null;
	
	String sql_2 = "SELECT * FROM material_datail";
	pstmt_2 = conn.prepareStatement(sql_2);
	
	rs_2 = pstmt_2.executeQuery();
	
	while(rs_2.next()){
		String ComCode = rs_2.getString("ComCode");
		String MatCharType = rs_2.getString("MatCharType");
		String MatCharTypeDesc = rs_2.getString("MatCharTypeDesc");
		String CharLeng = rs_2.getString("CharLeng");
	
%>		
	<tr style="text-align:center;">
		<td><%=ComCode %></td>
		<td><%=MatCharType %></td>
		<td><%=MatCharTypeDesc %></td>
		<td><%=CharLeng%></td>
	</tr>
<%
}
%>
	</table>
</div>	
<!-- ----------------------------등록하는 부분---------------------------------- -->

<%
	String sql1 = "SELECT MatType FROM material_1";
	PreparedStatement pstmt1 = conn.prepareStatement(sql1);
	String company_code = (String)session.getAttribute("Company_input");
	String UseUnuse = (String)session.getAttribute("Use_input");
	String CreatorId = (String)session.getAttribute("user_code");
	
%>
	
	<form name="Mat_Registform" action="material_regist_ok.jsp" method="get" onSubmit="return emptyCheck()">
		<table align="center">
			<!-- 회사 코드 입력 ComCode -->	
			<tr><th class="info" align="right">Company: </th>
				<td class="input_info">
					<input type="text" name="Company_input" id="Company" value='<%=company_code %>'>
				</td>
			</tr>
			<!-- 재료 코드 입력 -->
			<tr><th class="info" align="right">Material Type: </th>
				<td class="input_info">
					<select name="Material_Type" id="Material_Type">
					<%
					ResultSet rs1 = pstmt1.executeQuery();
					try{
						while(rs1.next()){
							String materialType = rs1.getString("MatType");
					%>
					document.write(<option value="<%=materialType %>"><%=materialType %></option>);
					<%
						}
					}catch(SQLException e){
						e.printStackTrace();
					}finally{
							if(rs1 != null){
								rs1.close();
							}
					}
					if(pstmt1 != null){
						pstmt1.close();
					}
					if(conn != null){
						conn.close();
					}
					%>
					</select>
				</td>
<%
	conn = DriverManager.getConnection(url, id, pwd);
	String sql3 = "SELECT MatTypeDes FROM material_1";
	PreparedStatement pstmt3 = conn.prepareStatement(sql3);
	ResultSet rs3 = null;
%>
				<!-- 재료 이름 입력 -->
				<th>Description: </th>
				<td class="input_info">
					<select name="Material_description" id="Material_description">
					<% 	
					try{
						rs3 = pstmt3.executeQuery();
						while(rs3.next()){
							String MatTypeDes = rs3.getString("MatTypeDes");
					%>
					document.write(<option value="<%=MatTypeDes %>"><%=MatTypeDes %></option>);
					<%
						}
					}catch(SQLException e){
						e.printStackTrace();
					}finally{
						if(rs3 != null){
							rs3.close();
						}
					}
					if(pstmt3 != null){
						pstmt3.close();
					}
					if(conn != null){
					conn.close();
					}
					%>
					</select>
				</td>
			</tr>

			<!-- 재료의 갯수를 입력하는 부분 -->
			<th class="info">속성 자리수(TotalLeng): </th>
				<td class="input_info">
					<input type="text" name="TotalLeng_input" id="TotalLeng_input" size="20">
				</td>
			
			<tr><th class="info">Serial Number 자리수: </th>
					<td class="input_info">
						<input type="text" name="SerialNum_input" id="SerialNum_input"size="20">
					</td>
				</tr>
			
			<tr class="info">
					<td class="input_info">
						<input type=hidden name="Crossbar_input" id="Crossbar_input" value="-">
					</td>
				</tr>
			
			<tr class="info">
					<td class="input_info">
						<input type=hidden name="user_id" id="user_id" value=<%=CreatorId %>>
					</td>
				</tr>
			
			<tr>
				<td style="text-align: center;" colspan="2">
					<input type="submit" id="btn_submin" value="Input">
				</td>
			</tr>	
			
		</table>
	</form>

</body>
</html>