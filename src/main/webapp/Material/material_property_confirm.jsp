<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="java.sql.SQLException"%> 
<!DOCTYPE html>
<%@ include file="../mydbcon.jsp" %>
<html>
<head>
<meta charset="utf-8">
<title>Material Property Confirm</title>

	<script>
		function Mat_property_delete(id) {
			if (confirm(id + "을(를) 삭제하시겠습니까?") == true) {
				location.href="Mat_property_delete.jsp?target=" + id;
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
				<th>ComCode</th><th>MatType</th><th>MatCharType</th><th>CharValue</th><th>결합값</th><th>CharValueDesc</th><th>UseUnuse</th><th>DELETE</th>
			</tr>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "SELECT * FROM material_result";
	pstmt = conn.prepareStatement(sql);
	
	rs = pstmt.executeQuery();
	
	while(rs.next()){
		String ComCode = rs.getString("ComCode");
		String MatType = rs.getString("MatType");
		String MatCharType = rs.getString("MatCharType");
		int CharVlaue = rs.getInt("CharVlaue");
		String Collabo = rs.getString("결합값");
		String CharValueDesc = rs.getString("CharValueDesc");
		String UseUnuse = rs.getString("UseUnuse");
%>
	<tr style="text-align:center;">
		<td><%=ComCode %></td>
		<td><%=MatType %></td>
		<td><%=MatCharType %></td>
		<td><%=CharVlaue%></td>
		<td><%=Collabo %></td>
		<td><%=CharValueDesc %></td>
		<td><%=UseUnuse %></td>
		<td><button id = <%=MatType %> onClick = "Mat_property_delete(this.id);">Delete</button></td>
	</tr>
<%			
	}
%>
		</table>
	</center>
	
	<center>
	<table>
		<tr><td style="text-align: center;"><form action="material_property_input.jsp" method="get" name="back" id="back" size="20">
			<input type="submit" value="재입력">
		</form></td>
		
		<td style="text-align: center;"><form action="material_final_input.jsp" method="get" name="regist" id="regist" size="20">
			<input type="submit" value="다음">
		</form></td></tr>
	</table>
	</center>	
	
</body>
</html>