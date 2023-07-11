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
<%@ include file="../mydbcon.jsp" %>
<title>Insert title here</title>

	<script>
		function Mat_delete(id) {
			if (confirm(id + "을(를) 삭제하시겠습니까?") == true) {
				location.href="MatType_delete.jsp?target=" + id;
			} else {
				return false;
			}
		}
	</script>
</head>
<body>
	<center>
		<table border=1 bordercolor="blue">
			<tr style="text-align: center; background: rgb(111,167,235); color: white ;">
				<th>ComCode</th><th>MatType</th><th>MatTypeDes</th><th>use/unuse</th>
				<th>CreatDate</th><th>CreatorID</th><th>Delete</th>
			</tr>
			<%
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			String sql = "SELECT * FROM material_1";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				String ComCode = rs.getString("ComCode");
				String MatType = rs.getString("MatType");
				String MatTypeDes = rs.getString("MatTypeDes");
				String Use_Unuse = rs.getString("use/unuse");
				String CreatDate = rs.getString("CreatDate");
				String CreatorID = rs.getString("CreatorID");
			%>
			<tr style="text-align:center;">
				<td><%=ComCode %></td>
				<td><%=MatType %></td>
				<td><%=MatTypeDes %></td>
				<td><%=Use_Unuse%></td>
				<td><%=CreatDate%></td>	
				<td><%=CreatorID%></td>
				<td><button id = <%=MatType %> onClick = "Mat_delete(this.id);">Delete</button></td>
			</tr>
			<% 
			}
			%>	
		</table>
	</center>
	<center>
	<table>
		<tr><td style="text-align: center;"><form action="material_input.jsp" method="get" name="back" id="back" size="20">
			<input type="submit" value="재입력">
		</form></td></tr>
	
		<tr><td style="text-align: center;"><form action="material_input_detail.jsp" method="get" name="detail" id="datail" size="20">
			<input type="submit" value="다음">
		</form></td></tr>
	</table>
	</center>
</body>
</html>