<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>    

<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>등록 완료</title>
</head>
<body>
<%
	Connection conn = null;

	String url = "jdbc:mysql://localhost:3306/campusdb";
	String id = "root"; // MySQL에 접속을 위한 계정의 ID
	String pwd = "jinsang1027#"; // MySQL에 접속을 위한 계정의 암호
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pwd);
	
	LocalDateTime now = LocalDateTime.now();
	String formattedNow = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")); // creatDate

	String company_code = request.getParameter("Company_input"); //Comcode
	String Material_Type = request.getParameter("Material_Type"); //MatType
	String Material_description = request.getParameter("Material_description"); 
	
	int TotalLength = Integer.parseInt(request.getParameter("TotalLeng_input")); //속성자리수
	int SerialNum = Integer.parseInt(request.getParameter("SerialNum_input")); //serial number 자리수
	
	String CrossBar = request.getParameter("Crossbar_input"); //구분코드
	String CreatorID = request.getParameter("user_id"); //creatorId
	
	
	/*
	out.println("<script>alert('"+formattedNow+"');</script>");
	out.println("<script>alert('"+company_code+"');</script>");
	out.println("<script>alert('"+Material_Type+"');</script>");
	out.println("<script>alert('"+TotalLength+"');</script>");
	out.println("<script>alert('"+SerialNum+"');</script>");
	out.println("<script>alert('"+CreatorID+"');</script>");
	*/
	
	String sql = "INSERT INTO material_2 VALUES(?,?,?,?,?,?,?)";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	ResultSet rs = null;

	if (TotalLength < 4 || TotalLength > 6 || SerialNum < 4 || SerialNum > 6) {
		
	    	out.println("<script>alert('자리수는 4~6입니다. 다시 입력해주세요.'); location.href='material_regist.jsp'</script>");
	    	return;
		}
	

	
	try{
		session.setAttribute("Company_input", company_code);
		session.setAttribute("SerialNum_input",SerialNum);
		
		
		pstmt.setString(1, company_code);
		pstmt.setString(2, Material_Type);
		pstmt.setInt(3, TotalLength);
		pstmt.setString(4, CrossBar);
		pstmt.setInt(5, SerialNum);
		pstmt.setString(6, formattedNow);
		pstmt.setString(7, CreatorID);
		
		pstmt.executeUpdate();
	}catch(SQLException e){
		e.printStackTrace();
	} finally{
		try{
			if(pstmt != null && !pstmt.isClosed()){
				pstmt.close();
			}
		} catch(SQLException e){
			e.printStackTrace();
		}
	}
	
	conn.close();
%>
 
	<script>
		alert('등록되었습니다.');
		window.location.href='material_regist_confirm.jsp';
	</script>

</body>
</html>