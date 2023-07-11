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
<title>Material Detail Confirm</title>

	<script>
		function Matdetail_delete(id) {
			if (confirm(id + "을(를) 삭제하시겠습니까?") == true) {
				location.href="Matdetail_delete.jsp?target=" + id;
			} else {
				return false;
			}
		}
	</script>
	
	
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
	<center>
		<table border=1 bordercolor=blue>
			<tr style="text-aligh: center; background: rgb(111,167,235); color: white;">
				<th>ComCode</th><th>MatCharType</th><th>MatCharTypeDesc</th><th>CharLeng</th><th>Delete</th>
			</tr>
			
<% 	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "SELECT * FROM material_datail";
	pstmt = conn.prepareStatement(sql);
	
	rs = pstmt.executeQuery();
	
	while(rs.next()){
		String ComCode = rs.getString("ComCode");
		String MatCharType = rs.getString("MatCharType");
		String MatCharTypeDesc = rs.getString("MatCharTypeDesc");
		String CharLeng = rs.getString("CharLeng");
	
%>		
	<tr style="text-align:center;">
		<td><%=ComCode %></td>
		<td><%=MatCharType %></td>
		<td><%=MatCharTypeDesc %></td>
		<td><%=CharLeng%></td>
		<td><button id = <%=MatCharType %> onClick = "Matdetail_delete(this.id);">Delete</button></td>
	</tr>
<%
}
%>
		</table>
	</center>
	<center>
	<table>
		<tr><td style="text-align: center;"><form action="material_input_detail.jsp" method="get" name="back" id="back" size="20">
			<input type="submit" value="재입력">
		</form></td>
		
		<td style="text-align: center;"><form action="material_regist.jsp" method="get" name="regist" id="regist" size="20">
			<input type="submit" value="다음">
		</form></td></tr>
	</table>
	</center>
</body>
</html>