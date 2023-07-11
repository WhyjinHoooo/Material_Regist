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
	<table border=1 bordercolor=blue style="margin-left: auto; margin-right: auto;">
		<tr style="text-aligh: center; background: rgb(111,167,235); color: white;">
			<th>ComCode</th><th>MatType</th><th>TotalLeng</th><th>구분코드</th><th>Serial_Number_자리수</th>
		</tr>
<%
	PreparedStatement pstmt_3 = null;
	ResultSet rs_3 = null;
	
	String sql_3 = "SELECT * FROM material_2";
	pstmt_3 = conn.prepareStatement(sql_3);
	
	rs_3 = pstmt_3.executeQuery();
	
	while(rs_3.next()){
		String ComCode = rs_3.getString("ComCode");
		String MatType = rs_3.getString("MatType");
		int TotalLeng = rs_3.getInt("TotalLeng");
		String Crossbar = rs_3.getString("구분코드");
		int Serial_Number = rs_3.getInt("Serial_Number_자리수");
%>
	<tr style="text-align:center;">
		<td><%=ComCode %></td>
		<td><%=MatType %></td>
		<td><%=TotalLeng %></td>
		<td><%=Crossbar%></td>
		<td><%=Serial_Number%></td>
	</tr>
<%
}
%>
	</table>
	<!-- ----------------------------등록하는 부분---------------------------------- -->

<%
	String sql1 = "SELECT MatType FROM material_1";
	PreparedStatement pstmt1 = conn.prepareStatement(sql1);
	String company_code = (String)session.getAttribute("Company_input");
	String UseUnuse = (String)session.getAttribute("Use_input");
	String CreatorId = (String)session.getAttribute("user_code");
	String MatType = (String)session.getAttribute("Material_Type_input");
	
%>
	
	<form name="Registform_Def" action="material_def_ok.jsp" method="get">
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
				<th>Description: </th>
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
			<tr><th class="info" align="right">First Characterics: </th>
				<td class="input_info">			
					<select name="Material_firstChar" id="Material_firstChar">
						document.write(<option value=""></option>);
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
					<select name="FirstChar_Des" id="FirstChar_Des">
						document.write(<option value=""></option>);
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
				</tr>
				<!-- //////////////////////////////////// -->
<%
	conn = DriverManager.getConnection(url, id, pwd);
	String sql4 = "SELECT matCharType FROM material_datail";
	PreparedStatement pstmt4 = conn.prepareStatement(sql4);
	ResultSet rs4 = null;
%>			
			<tr><th class="info" align="right">Second Characterics: </th>
				<td class="input_info">			
					<select name="Material_SecChar" id="Material_SecChar">
						document.write(<option value=""></option>);
						<%
						try{
							rs4 = pstmt4.executeQuery();
							while(rs4.next()){
								String matCharType = rs4.getString("matCharType");
						%>
						document.write(<option value="<%=matCharType %>"><%=matCharType %></option>);			
						<% 
							}
						} catch(SQLException e){
							e.printStackTrace();
						}finally{
							if(rs4 != null){
								rs4.close();
							}
						}
						if(pstmt4 != null){
							pstmt4.close();
						}
						if(conn != null){
							conn.close();
						}
						%>
					</select>
					</td>
<%
	conn = DriverManager.getConnection(url, id, pwd);
	String sql4_2 = "SELECT matCharTypeDesc FROM material_datail";
	PreparedStatement pstmt4_2 = conn.prepareStatement(sql4_2);
	ResultSet rs4_2 = null;
%>			
				<th class="info" align="right">Description: </th>
				<td class="input_info">			
					<select name="SecChar_Des" id="SecChar_Des">
						document.write(<option value=""></option>);
						<%
						try{
							rs4_2 = pstmt4_2.executeQuery();
							while(rs4_2.next()){
								String matCharTypeDesc = rs4_2.getString("matCharTypeDesc");
						%>
						document.write(<option value="<%=matCharTypeDesc %>"><%=matCharTypeDesc %></option>);			
						<% 
							}
						} catch(SQLException e){
							e.printStackTrace();
						}finally{
							if(rs4_2 != null){
								rs4_2.close();
							}
						}
						if(pstmt4_2 != null){
							pstmt4_2.close();
						}
						if(conn != null){
							conn.close();
						}
						%>
					</select>
					</td>					
				</tr>
				<!-- +++++++++++++++++++++++++++++++++ -->
<%
	conn = DriverManager.getConnection(url, id, pwd);
	String sql5 = "SELECT matCharType FROM material_datail";
	PreparedStatement pstmt5 = conn.prepareStatement(sql5);
	ResultSet rs5 = null;
%>			
			<tr><th class="info" align="right">Third Characterics: </th>
				<td class="input_info">			
					<select name="Material_ThirChar" id="Material_ThirChar">
						document.write(<option value=""></option>);
						<%
						try{
							rs5 = pstmt5.executeQuery();
							while(rs5.next()){
								String matCharType = rs5.getString("matCharType");
						%>
						document.write(<option value="<%=matCharType %>"><%=matCharType %></option>);			
						<% 
							}
						} catch(SQLException e){
							e.printStackTrace();
						}finally{
							if(rs5 != null){
								rs5.close();
							}
						}
						if(pstmt5 != null){
							pstmt5.close();
						}
						if(conn != null){
							conn.close();
						}
						%>
					</select>
					</td>
<%
	conn = DriverManager.getConnection(url, id, pwd);
	String sql5_3 = "SELECT matCharTypeDesc FROM material_datail";
	PreparedStatement pstmt5_3 = conn.prepareStatement(sql5_3);
	ResultSet rs5_3 = null;
%>			
				<th class="info" align="right">Description: </th>
				<td class="input_info">			
					<select name="ThirdChar_Des" id="thirdChar_Des">
						document.write(<option value=""></option>);
						<%
						try{
							rs5_3 = pstmt5_3.executeQuery();
							while(rs5_3.next()){
								String matCharTypeDesc = rs5_3.getString("matCharTypeDesc");
						%>
						document.write(<option value="<%=matCharTypeDesc %>"><%=matCharTypeDesc %></option>);			
						<% 
							}
						} catch(SQLException e){
							e.printStackTrace();
						}finally{
							if(rs5_3 != null){
								rs5_3.close();
							}
						}
						if(pstmt5_3 != null){
							pstmt5_3.close();
						}
						if(conn != null){
							conn.close();
						}
						%>
					</select>
					</td>					
				</tr>
				<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
<%
	conn = DriverManager.getConnection(url, id, pwd);
	String sql6 = "SELECT matCharType FROM material_datail";
	PreparedStatement pstmt6 = conn.prepareStatement(sql6);
	ResultSet rs6 = null;
%>			
			<tr><th class="info" align="right">Fourth Characterics: </th>
				<td class="input_info">			
					<select name="Material_FourChar" id="Material_FourChar">
						document.write(<option value=""></option>);
						<%
						try{
							rs6 = pstmt6.executeQuery();
							while(rs6.next()){
								String matCharType = rs6.getString("matCharType");
						%>
						document.write(<option value="<%=matCharType %>"><%=matCharType %></option>);			
						<% 
							}
						} catch(SQLException e){
							e.printStackTrace();
						}finally{
							if(rs6 != null){
								rs6.close();
							}
						}
						if(pstmt6 != null){
							pstmt6.close();
						}
						if(conn != null){
							conn.close();
						}
						%>
					</select>
					</td>
<%
	conn = DriverManager.getConnection(url, id, pwd);
	String sql6_4 = "SELECT matCharTypeDesc FROM material_datail";
	PreparedStatement pstmt6_4 = conn.prepareStatement(sql6_4);
	ResultSet rs6_4 = null;
%>			
				<th class="info" align="right">Description: </th>
				<td class="input_info">			
					<select name="FoueChar_Des" id="FourChar_Des">
						document.write(<option value=""></option>);
						<%
						try{
							rs6_4 = pstmt6_4.executeQuery();
							while(rs6_4.next()){
								String matCharTypeDesc = rs6_4.getString("matCharTypeDesc");
						%>
						document.write(<option value="<%=matCharTypeDesc %>"><%=matCharTypeDesc %></option>);			
						<% 
							}
						} catch(SQLException e){
							e.printStackTrace();
						}finally{
							if(rs6_4 != null){
								rs6_4.close();
							}
						}
						if(pstmt6_4 != null){
							pstmt6_4.close();
						}
						if(conn != null){
							conn.close();
						}
						%>
					</select>
					</td>					
				</tr>
				
				<tr class="info">
					<td class="input_info">
						<input type=hidden name="user_id" id="user_id" value=<%=CreatorId %>>
					</td>
				</tr>			
<%
	conn = DriverManager.getConnection(url, id, pwd);
	String sql7 = "SELECT TotalLeng FROM material_2";
	PreparedStatement pstmt7 = conn.prepareStatement(sql7);
	ResultSet rs7 = null;
%>	
	<tr><th class="info" align="right">TotalLeng: </th>
		<td class="input_info">
			<select name="TotalLeng" id="TotalLeng">
			<%
			try{
				rs7 = pstmt7.executeQuery();
				while(rs7.next()){
					int TotalLeng = rs7.getInt("TotalLeng");
			%>
			document.write(<option value="<%=TotalLeng %>"><%=TotalLeng %></option>);			
			<%
				}
			} catch(SQLException e){
				e.printStackTrace();
			}finally{
				if(rs7 != null){
					rs7.close();
				}
			}
			if(pstmt7 != null){
				pstmt7.close();
			}
			if(conn != null){
				conn.close();
			}
			%>
		</select>
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