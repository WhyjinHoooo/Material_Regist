<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="java.sql.SQLException"%> 
<!DOCTYPE html>
<%@ include file="../mydbcon.jsp" %>
<html>
<head>
<meta charset="utf-8">
<title>Material Confirm Final</title>

	<script>
		function Mat_final_delete(id) {
			if (confirm(id + "을(를) 삭제하시겠습니까?") == true) {
				location.href="Mat_final_delete.jsp?target=" + id;
			} else {
				return false;
			}
		}
	</script>
</head>
<body>
	<center>
		<table border=1 bordercolor=blue>
			<tr style="text-aligh: center; background: rgb(111,167,235); color: white;">
				<th>ComCode</th><th>MatType</th><th>Char1Value</th><th>Char2Value</th><th>Char3Value</th><th>Char4Value</th>
				<th>MatNum</th><th>MatDesc</th><th>MasterDate</th><th>CreateDate</th><th>CreatorId</th><th>UseUnuse</th><th>Delete</th>
			</tr>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "SELECT * FROM material_final";
	pstmt = conn.prepareStatement(sql);
	
	rs = pstmt.executeQuery();
	
	while(rs.next()){
		String ComCode = rs.getString("ComCode");
		String MatType = rs.getString("MatType");
		int Char1Value = rs.getInt("Char1Value");
		int Char2Value = rs.getInt("Char2Value");
		int Char3Value = rs.getInt("Char3Value");
		int Char4Value = rs.getInt("Char4Value");
		String MatNum = rs.getString("MatNum");
		String MatDesc = rs.getString("MatDesc");
		String MasterDate = rs.getString("MasterDate");
		String CreateDate = rs.getString("CreateDate");
		String CreatorId = rs.getString("CreatorId");
		String UseUnuse = rs.getString("UseUnuse");			
%>
		<tr style="text-align:center;">
		<td><%=ComCode %></td>
		<td><%=MatType %></td>
		<td><%=Char1Value %></td>
		<td><%=Char2Value%></td>
		<td><%=Char3Value %></td>
		<td><%=Char4Value %></td>
		<td><%=MatNum %></td>
		<td><%=MatDesc %></td>
		<td><%=MasterDate %></td>
		<td><%=CreateDate %></td>
		<td><%=CreatorId %></td>
		<td><%=UseUnuse %></td>
		<td><button id = <%=MatDesc %> onClick = "Mat_final_delete(this.id);">Delete</button></td>
	</tr>
<% 
	}
%>
		</table>
	</center>
	
	<center>
	<table>
		<td style="text-align: center;"><form action="material_input.jsp" method="get" name="regist" id="regist" size="20">
			<input type="submit" value="초기화면">
		</form></td></tr>
	</table>
	</center>
</body>
</html>