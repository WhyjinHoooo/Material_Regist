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
			var ComCode = document.Final_ResgistForm.Company_input.value;
			var Mat_Type = document.Final_ResgistForm.Material_Type.value;
			var Mat_Des = document.Final_ResgistForm.Material_description.value;
			
			if(!ComCode || !Mat_Type || !Mat_Des){
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
<title>Final Material Code</title>
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
				<th>ComCode</th><th>MatType</th><th>MatCharType</th><th>CharVlaue</th><th>결합값</th><th>CharValueDesc</th><th>UseUnuse</th>
			</tr>
		
<% 	
	PreparedStatement pstmt_2 = null;
	ResultSet rs_2 = null;
	
	String sql_2 = "SELECT * FROM material_result";
	pstmt_2 = conn.prepareStatement(sql_2);
	
	rs_2 = pstmt_2.executeQuery();
	
	while(rs_2.next()){
		String ComCode = rs_2.getString("ComCode");
		String MatType = rs_2.getString("MatType");
		String MatCharType = rs_2.getString("MatCharType");
		int CharVlaue = rs_2.getInt("CharVlaue");
		String Collabo = rs_2.getString("결합값");
		String CharValueDesc = rs_2.getString("CharValueDesc");
		String UseUnuse = rs_2.getString("UseUnuse");
	
%>		
	<tr style="text-align:center;">
		<td><%=ComCode %></td>
		<td><%=MatCharType %></td>
		<td><%=MatCharType %></td>
		<td><%=CharVlaue%></td>
		<td><%=Collabo %></td>
		<td><%=CharValueDesc %></td>
		<td><%=UseUnuse%></td>
	</tr>
<%
}
%>
	</table>
</div>		
<!-- ===========================입력하는 부분========================== -->
<% 
	String sql1 = "SELECT MatType FROM material_1";
	PreparedStatement pstmt1 = conn.prepareStatement(sql1);
	String company_code = (String)session.getAttribute("Company_input");
	String UseUnuse = (String)session.getAttribute("Use_input");
	String CreatorId = (String)session.getAttribute("user_code");
	String MatType = (String)session.getAttribute("Material_Type_input");
%>
	<form name="Final_ResgistForm" action="material_Final_ok.jsp" method="get" onSubmit="return emptyCheck()">
	<table align="center">
		<!-- 회사 코드 입력하는 부분(ComCode/E100) -->
		<tr><th class="info" align="right">Company: </th>
			<td class="input_info">
				<input type="text" name="Company_input" id="Company" value='<%=company_code %>'>
			</td>
		</tr>	
		<!-- 재료코드 입력하는 부분(matType/ROH1) -->
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
				<!-- 재료 이름 입력(상품,원자재,부자재 입력하는 부분) -->
				<th class="info" align="right">Description: </th>
				<td class="input_info">
					<select name="Material_description" id="Material_description">
						document.write(<option value="">선택</option>);
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
	String sql3 = "SELECT CharVlaue FROM material_result";
	PreparedStatement pstmt3 = conn.prepareStatement(sql3);
	ResultSet rs3 = null;
%>			
			<!-- 첫 번째 char value 입력하는 부분 -->
			<tr><th class="info" align="right">First Characteric Value: </th>
				<td class="input_info">			
					<select name="First_Char_Value" id="First_Char_Value">
						document.write(<option value="">선택</option>);
						<%
						try{
							rs3 = pstmt3.executeQuery();
							while(rs3.next()){
								String First_value = rs3.getString("CharVlaue");
						%>
						document.write(<option value="<%=First_value %>"><%=First_value %></option>);			
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
	String sql3_1 = "SELECT CharValueDesc FROM material_result";
	PreparedStatement pstmt3_1 = conn.prepareStatement(sql3_1);
	ResultSet rs3_1 = null;
%>			
			<!-- 첫 번째 char value를 자세하게 입력하는 부분 -->			
				<th class="info" align="right">First(구분용) Description: </th>
				<td class="input_info">			
					<select name="Fir_CharValueDes" id="Fir_CharValueDes">
						document.write(<option value="">선택</option>);
						<%
						try{
							rs3_1 = pstmt3_1.executeQuery();
							while(rs3_1.next()){
								String Fir_CharValueDesc = rs3_1.getString("CharValueDesc");
						%>
						document.write(<option value="<%=Fir_CharValueDesc %>"><%=Fir_CharValueDesc %></option>);			
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
			<!-- ======================================== -->
<%
	conn = DriverManager.getConnection(url, id, pwd);
	String sql4 = "SELECT CharVlaue FROM material_result";
	PreparedStatement pstmt4 = conn.prepareStatement(sql4);
	ResultSet rs4 = null;
%>			
			<!-- 두 번째 char value 입력하는 부분 -->
			<tr><th class="info" align="right">Second Characteric Value: </th>
				<td class="input_info">			
					<select name="Sec_Char_Value" id="Sec_Char_Value">
						document.write(<option value="">선택</option>);
						<%
						try{
							rs4 = pstmt4.executeQuery();
							while(rs4.next()){
								String Sec_value = rs4.getString("CharVlaue");
						%>
						document.write(<option value="<%=Sec_value %>"><%=Sec_value %></option>);			
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
	String sql4_1 = "SELECT CharValueDesc FROM material_result";
	PreparedStatement pstmt4_1 = conn.prepareStatement(sql4_1);
	ResultSet rs4_1 = null;
%>			
			<!-- 두 번째 char value를 자세하게 입력하는 부분 -->			
				<th class="info" align="right">Second(구분용) Description: </th>
				<td class="input_info">			
					<select name="Sec_CharValueDes" id="Sec_CharValueDes">
						document.write(<option value="">선택</option>);
						<%
						try{
							rs4_1 = pstmt4_1.executeQuery();
							while(rs4_1.next()){
								String Sec_CharValueDesc = rs4_1.getString("CharValueDesc");
						%>
						document.write(<option value="<%=Sec_CharValueDesc %>"><%=Sec_CharValueDesc %></option>);			
						<% 
							}
						} catch(SQLException e){
							e.printStackTrace();
						}finally{
							if(rs4_1 != null){
								rs4_1.close();
							}
						}
						if(pstmt4_1 != null){
							pstmt4_1.close();
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
	String sql5 = "SELECT CharVlaue FROM material_result";
	PreparedStatement pstmt5 = conn.prepareStatement(sql5);
	ResultSet rs5 = null;
%>			
			<!-- 세 번째 char value 입력하는 부분 -->
			<tr><th class="info" align="right">Third Characteric Value: </th>
				<td class="input_info">			
					<select name="Thir_Char_Value" id="Thir_Char_Value">
						document.write(<option value="">선택</option>);
						<%
						try{
							rs5 = pstmt5.executeQuery();
							while(rs5.next()){
								String Thir_value = rs5.getString("CharVlaue");
						%>
						document.write(<option value="<%=Thir_value %>"><%=Thir_value %></option>);			
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
	String sql5_1 = "SELECT CharValueDesc FROM material_result";
	PreparedStatement pstmt5_1 = conn.prepareStatement(sql5_1);
	ResultSet rs5_1 = null;
%>			
			<!-- 세 번째 char value를 자세하게 입력하는 부분 -->			
				<th class="info" align="right">Third(구분용) Description: </th>
				<td class="input_info">			
					<select name="Thir_CharValueDes" id="Thir_CharValueDes">
						document.write(<option value="">선택</option>);
						<%
						try{
							rs5_1 = pstmt5_1.executeQuery();
							while(rs5_1.next()){
								String Thir_CharValueDesc = rs5_1.getString("CharValueDesc");
						%>
						document.write(<option value="<%=Thir_CharValueDesc %>"><%=Thir_CharValueDesc %></option>);			
						<% 
							}
						} catch(SQLException e){
							e.printStackTrace();
						}finally{
							if(rs5_1 != null){
								rs5_1.close();
							}
						}
						if(pstmt5_1 != null){
							pstmt5_1.close();
						}
						if(conn != null){
							conn.close();
						}
						%>
					</select>
					</td>
				</tr>
<%
	conn = DriverManager.getConnection(url, id, pwd);
	String sql6 = "SELECT CharVlaue FROM material_result";
	PreparedStatement pstmt6 = conn.prepareStatement(sql6);
	ResultSet rs6 = null;
%>			
			<!-- 세 번째 char value 입력하는 부분 -->
			<tr><th class="info" align="right">Fourth Characteric Value: </th>
				<td class="input_info">			
					<select name="Four_Char_Value" id="Four_Char_Value">
						document.write(<option value="">선택</option>);
						<%
						try{
							rs6 = pstmt6.executeQuery();
							while(rs6.next()){
								String Four_value = rs6.getString("CharVlaue");
						%>
						document.write(<option value="<%=Four_value %>"><%=Four_value %></option>);			
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
	String sql6_1 = "SELECT CharValueDesc FROM material_result";
	PreparedStatement pstmt6_1 = conn.prepareStatement(sql5_1);
	ResultSet rs6_1 = null;
%>			
			<!-- 세 번째 char value를 자세하게 입력하는 부분 -->			
				<th class="info" align="right">Fourth(구분용) Description: </th>
				<td class="input_info">			
					<select name="Four_CharValueDes" id="Four_CharValueDes">
						document.write(<option value="">선택</option>);
						<%
						try{
							rs6_1 = pstmt6_1.executeQuery();
							while(rs6_1.next()){
								String Four_CharValueDesc = rs6_1.getString("CharValueDesc");
						%>
						document.write(<option value="<%=Four_CharValueDesc %>"><%=Four_CharValueDesc %></option>);			
						<% 
							}
						} catch(SQLException e){
							e.printStackTrace();
						}finally{
							if(rs6_1 != null){
								rs6_1.close();
							}
						}
						if(pstmt6_1 != null){
							pstmt6_1.close();
						}
						if(conn != null){
							conn.close();
						}
						%>
					</select>
					</td>
				</tr>
				
				<tr><th class="info" align="right">Material Number: </th>
					<td class="input_info">
						<input type="type" name="MaterialNum" id="MaterialNum">
					</td>
				</tr>				
				<!-- 재료를 입력하는 부분(코일,박판,순동 등) -->
				<tr><th class="info" align="right">Material Description: </th>
					<td class="input_info">
						<input type="type" name="Material_Des" id="Material_Des">
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