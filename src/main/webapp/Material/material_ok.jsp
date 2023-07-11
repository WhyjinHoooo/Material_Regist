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
<%@ include file="../mydbcon.jsp" %>
<title>등록 완료</title>
</head>
<body>
<%

	/*
	Connection conn = null;
	
		String url = "jdbc:mysql://localhost:3306/campusdb"; //Database 이름은 campusdb 
		String id = "root";                     //MySQL에 접속을 위한 계정의 ID
		String pwd = "jinsang1027#";            //MySQL에 접속을 위한 계정의 암호
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pwd);	
	*/
	
	LocalDateTime now = LocalDateTime.now();
	String formattedNow = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	
	String company_code = request.getParameter("Company_input");
	String Material_Type = request.getParameter("Material_Type_input");
	String Material_Description= request.getParameter("Description_input");
	String UseUnuse = request.getParameter("Use_input");
	String UserCode = request.getParameter("user_code");
	
	String sql = "INSERT INTO material_1 VALUES(?,?,?,?,?,?)";
	String sql2 = "SELECT * FROM material_1";

	PreparedStatement pstmt = conn.prepareStatement(sql);
	PreparedStatement pstmt2 = conn.prepareStatement(sql2);
	
	ResultSet rs = null;
	//material_1에 먼저 등록되어 있는 지 검사하고 material_1에 등록을 위해 생성
	try{
		rs = pstmt2.executeQuery();
		
		while(rs.next()){
			String MatType_confirm = rs.getString("MatType");
			
			if(MatType_confirm.equals(Material_Type)){
				//out.println("<script>alert('"+MatType_confirm+"가 중복되었습니다.'); location.href='material_input.jsp'</script>");
				out.println("<script>alert('"+MatType_confirm+"은(는) 중복되었습니다.');</script>");
				out.print("<script> history.back();</script>");
				//out.print("<script> location.href='material_input.jsp'</script>");
				conn.close();
				return;
			}
		}
	} catch(SQLException e){
		e.printStackTrace();
	} finally{
		if(rs != null){
			rs.close();
		}
	}
	
	try {
		session.setAttribute("Company_input", company_code); //회사 코드
		session.setAttribute("Use_input",UseUnuse); // 사용유무
		session.setAttribute("user_code",UserCode); // 회원 고유 번호
		session.setAttribute("Material_Type_input",Material_Type); // 재료의 타입
		
		pstmt.setString(1, company_code);
		pstmt.setString(2, Material_Type);
		pstmt.setString(3, Material_Description);
		pstmt.setString(4, UseUnuse);
		pstmt.setString(5, formattedNow);
		pstmt.setString(6, UserCode);
				
		pstmt.executeUpdate();
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		try {
			if (pstmt != null && !pstmt.isClosed()) {
				pstmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
					
	conn.close();
			
%>
	
	<script>
		alert('재료가 등록되었습니다.');
		window.location.href='material_confirm.jsp';
	</script>
	
</body>
</html>
