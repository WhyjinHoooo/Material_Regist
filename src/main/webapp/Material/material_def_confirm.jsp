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
<title>Material Definition Confirm</title>

	<script>
		function Mat_def_delete(id) {
			if (confirm(id + "을(를) 삭제하시겠습니까?") == true) {
				location.href="MatType_def_delete.jsp?target=" + id;
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
				<th>ComCode</th><th>MatType</th><th>FirstChar</th><th>SecondChar</th><th>ThirdChar</th>
				<th>FourthChar</th><th>TotalLeng</th><th>CreateDate</th><th>CreatorID</th><th>DELETE</th>
			</tr>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "SELECT * FROM material_def";
	pstmt = conn.prepareStatement(sql);
	
	rs = pstmt.executeQuery();
	
	while(rs.next()){
		String ComCode = rs.getString("ComCode");
		String MatType = rs.getString("MatType");
		String FirstChar = rs.getString("FirstChar");
		String SecondChar = rs.getString("SecondChar");
		String ThirdChar = rs.getString("ThirdChar");
		String FourthChar = rs.getString("FourthChar");
		int TotalLeng = rs.getInt("TotalLeng");
		String CreateDate = rs.getString("CreateDate");
		String CreatorID = rs.getString("CreatorID");
		
%>		
	<tr style="text-align:center;">
		<td><%=ComCode %></td>
		<td><%=MatType %></td>
		<td><%=FirstChar %></td>
		<td><%=SecondChar%></td>
		<td><%=ThirdChar %></td>
		<td><%=FourthChar %></td>
		<td><%=TotalLeng %></td>
		<td><%=CreateDate%></td>
		<td><%=CreatorID%></td>
		<td><button id = <%=MatType %> onClick = "Mat_def_delete(this.id);">Delete</button></td>
	</tr>
<%
}
%>
	</table>
	</center>
	
		<center>
	<table>
		<tr><td style="text-align: center;"><form action="material_def_input.jsp" method="get" name="back" id="back" size="20">
			<input type="submit" value="재입력">
		</form></td>
		
		<td style="text-align: center;"><form action="material_property_input.jsp" method="get" name="regist" id="regist" size="20">
			<input type="submit" value="다음">
		</form></td></tr>
	</table>
	</center>
</body>
</html>