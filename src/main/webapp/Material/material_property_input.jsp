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
			var CharValue = document.Registform_Pro.CharValue_input.value;
			var CharValuedes = document.Registform_Pro.CharValuedes_input.value;

			
			if(!CharValue || !CharValuedes){
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
<title>Material Definition</title>
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
	String MatType = (String)session.getAttribute("Material_Type_input");
	
%>	
	
	<form name="Registform_Pro" action="material_property_ok.jsp" method="get" onSubmit="return emptyCheck()">
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
	String sql2 = "SELECT MatTypeDes FROM material_1";
	PreparedStatement pstmt2 = conn.prepareStatement(sql2);
	ResultSet rs2 = null;
%>
				<!-- 재료 이름 입력 -->
				<th class="info" align="right">Description: </th>
				<td class="input_info">
					<select name="Material_description" id="Material_description">
					<% 	
					try{
						rs2 = pstmt2.executeQuery();
						while(rs2.next()){
							String MatTypeDes = rs2.getString("MatTypeDes");
					%>
					document.write(<option value="<%=MatTypeDes %>"><%=MatTypeDes %></option>);
					<%
						}
					}catch(SQLException e){
						e.printStackTrace();
					}finally{
						if(rs2 != null){
							rs2.close();
						}
					}
					if(pstmt2 != null){
						pstmt2.close();
					}
					if(conn != null){
					conn.close();
					}
					%>
					</select>
				</td>
			</tr>
			<!-- ======================================== -->		
<%
	conn = DriverManager.getConnection(url, id, pwd);
	String sql3 = "SELECT matCharType FROM material_datail";
	PreparedStatement pstmt3 = conn.prepareStatement(sql3);
	ResultSet rs3 = null;
%>			
			<tr><th class="info" align="right">Material Character: </th>
				<td class="input_info">			
					<select name="MaType_proPerty" id="MaType_proPerty">
						<%
						try{
							rs3 = pstmt3.executeQuery();
							while(rs3.next()){
								String matCharType = rs3.getString("matCharType");
						%>
						document.write(<option value="<%=matCharType %>"><%=matCharType %></option>);			
						<% 
							}
						} catch(SQLException e){
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
<%
	conn = DriverManager.getConnection(url, id, pwd);
	String sql3_1 = "SELECT matCharTypeDesc FROM material_datail";
	PreparedStatement pstmt3_1 = conn.prepareStatement(sql3_1);
	ResultSet rs3_1 = null;
%>			
				<th class="info" align="right">Description: </th>
				<td class="input_info">			
					<select name="MaTypepro_des" id="MaTypepro_des">
						<%
						try{
							rs3_1 = pstmt3_1.executeQuery();
							while(rs3_1.next()){
								String matCharTypeDesc = rs3_1.getString("matCharTypeDesc");
						%>
						document.write(<option value="<%=matCharTypeDesc %>"><%=matCharTypeDesc %></option>);			
						<% 
							}
						} catch(SQLException e){
							e.printStackTrace();
						}finally{
							if(rs3_1 != null){
								rs3_1.close();
							}
						}
						if(pstmt3_1 != null){
							pstmt3_1.close();
						}
						if(conn != null){
							conn.close();
						}
						%>
					</select>
					</td>
<%
	conn = DriverManager.getConnection(url, id, pwd);
	String sql3_2 = "SELECT charLeng FROM material_datail";
	PreparedStatement pstmt3_2 = conn.prepareStatement(sql3_2);
	ResultSet rs3_2 = null;
%>		
				<th class="info" align="right">MatCharacter 자리 수: </th>
				<td class="input_info">			
					<select name="MaTypepro_leng" id="MaTypepro_leng">
						<%
						try{
							rs3_2 = pstmt3_2.executeQuery();
							while(rs3_2.next()){
								String matTypeProLeng = rs3_2.getString("charLeng");
						%>
						document.write(<option value="<%=matTypeProLeng %>"><%=matTypeProLeng %></option>);			
						<% 
							}
						} catch(SQLException e){
							e.printStackTrace();
						}finally{
							if(rs3_2 != null){
								rs3_2.close();
							}
						}
						if(pstmt3_2 != null){
							pstmt3_2.close();
						}
						if(conn != null){
							conn.close();
						}
						%>
					</select>
					</td>
				</tr>	
				
				<tr><th class="info"></th>
					<td class="input_info">
						<input type="hidden" name="Use_input" id="Use_input" value=<%=UseUnuse %>>
					</td>
				</tr>
				
				<tr><th class="info">Character Value: </th>
					<td class="input_info">
						<input type="text" name=CharValue_input id=CharValue_input>
					</td>
					
					<th class="info">Value Description: </th>
					<td class="input_info">
						<input type="text" name=CharValuedes_input id=CharValuedes_input>
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