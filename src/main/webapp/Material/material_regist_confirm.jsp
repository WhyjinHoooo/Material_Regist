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
<title>Insert title here</title>

	<script>
		function CharValueDesc_delete(id) {
			if (confirm(id + "을(를) 삭제하시겠습니까?") == true) {
				location.href="material_regist_delete.jsp?target=" + id;
			} else {
				return false;
			}
		}
		
		function reInput(id){
			if(confirm("재입력하시겠습니까?") == true){
				location.href="material_regist.jsp";
			} else{
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
		<table border=1 bordercolor="blue">
			<tr style="text-align: center; background: rgb(111,167,235); color: white ;">
				<th>ComCode</th><th>MatType</th><th>속성자리수</th><th>구분코드</th>
				<th>Serial Number 자리수</th><th>CreatDate</th><th>CreatorID</th><th>Delete</th>
			</tr>
			<%
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			String sql = "SELECT * FROM material_2";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				String ComCode = rs.getString("ComCode");
				String MatType = rs.getString("MatType");
				Integer TotalLeng = rs.getInt("TotalLeng");
				String CrossBar = rs.getString("구분코드");
				Integer Serial_Number = rs.getInt("Serial_Number_자리수");
				String CreateDate = rs.getString("CreateDate");
				String CreatotID = rs.getString("CreatotID");
			%>
			<tr style="text-align:center;">
				<td><%=ComCode %></td>
				<td><%=MatType %></td>
				<td><%=TotalLeng %></td>
				<td><%=CrossBar%></td>
				<td><%=Serial_Number%></td>	
				<td><%=CreateDate%></td>
				<td><%=CreatotID%></td>
				<td><button id = <%=MatType %> onClick = "CharValueDesc_delete(this.id);">Delete</button></td>
			</tr>
			<% 
			}
			%>	
		</table>
	</center>
	<center>
	<table>
		<tr>
			<td><button id="btn" onClick ="reInput(this.id);">재입력</button></td>
		</tr>
		
		<td style="text-align: center;"><form action="material_def_input.jsp" method="get" name="regist" id="regist" size="20">
			<input type="submit" value="다음">
		</form></td></tr>
	</table>
	</center>	
</body>
</html>