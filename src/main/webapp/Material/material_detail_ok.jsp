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
<title>Material Detail Ok</title>
</head>
<body>
<%
	Connection conn = null;

	String url = "jdbc:mysql://localhost:3306/campusdb";
	String id = "root"; // MySQL에 접속을 위한 계정의 ID
	String pwd = "jinsang1027#"; // MySQL에 접속을 위한 계정의 암호
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pwd);
	
	
	String company_code = request.getParameter("Company_input");
	String Material_Char_Type = request.getParameter("Material_Chrtyp_input");
	String Material_Char_Type_Desc = request.getParameter("Material_ChrTyp_Description_input");
	String Char_Length = request.getParameter("Char_type_length");
	
	/*
	out.print("<script>alert('"+ company_code +"')</script>");
	out.print("<script>alert('"+ Material_Char_Type +"')</script>");
	out.print("<script>alert('"+ Material_Char_Type_Desc +"')</script>");
	out.print("<script>alert('"+ Char_Length +"')</script>");
	*/
	
	String sql = "INSERT INTO material_datail VALUES(?,?,?,?)";
	String sql2 = "SELECT MatCharType FROM material_datail";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	PreparedStatement pstmt2 = conn.prepareStatement(sql2);
	
	ResultSet rs2 = null;
	
	try{
		rs2 = pstmt2.executeQuery();
		
		while(rs2.next()){
			
			String MatCharType_confirm = rs2.getString("MatCharType");
			
			if(Material_Char_Type.equals(MatCharType_confirm)){
				out.println("<script>alert('"+Material_Char_Type+"가 중복되었습니다.');</script>");
				out.print("<script> history.back();</script>");
				conn.close();
				return;
			}
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		if(rs2 != null){
			rs2.close();
		}
	}
	
	try	{
		session.setAttribute("Company_input", company_code);
				
		pstmt.setString(1, company_code);
		pstmt.setString(2, Material_Char_Type);
		pstmt.setString(3, Material_Char_Type_Desc);
		pstmt.setString(4, Char_Length);
				
		pstmt.executeUpdate();
	
	} catch(SQLException e){
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
		alert('재료가 등록되었습니다.');
		window.location.href='material_datail_confirm.jsp';
	</script>
</body>
</html>