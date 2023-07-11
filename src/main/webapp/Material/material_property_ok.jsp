<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="java.sql.SQLException"%> 
<!DOCTYPE html>
<%@ include file="../mydbcon.jsp" %>
<html>
<head>
<meta charset="utf-8">
<title>Material Type별 속성 위치별 값 생성</title>
</head>
<body>
<%
	PreparedStatement pstmt = null;	

	String company_code = request.getParameter("Company_input"); //ComCode
	String Material_Type = request.getParameter("Material_Type"); //Material Type
	String Material_description = request.getParameter("Material_description");
	String Material_proPerty = request.getParameter("MaType_proPerty"); //Material Character
	String Material_proDes = request.getParameter("MaTypepro_des");
	
	int MaTypepro_length = Integer.parseInt(request.getParameter("MaTypepro_leng"));
	int MatChar_Value = Integer.parseInt(request.getParameter("CharValue_input"));//Character Value
	
	String Materal_name = request.getParameter("CharValuedes_input"); //Value Description
	String useUnuse = request.getParameter("Use_input"); //UseUnuse
	
	String collabo = Material_Type + Material_proPerty + MatChar_Value;
	
	String sql = "INSERT INTO material_result VALUES(?,?,?,?,?,?,?)";
	/*
	out.println("<script>alert('company_code: "+company_code+"');</script>");
	out.println("<script>alert('Material_Type: "+Material_Type+"');</script>");
	out.println("<script>alert('Material_description: "+Material_description+"');</script>");
	out.println("<script>alert('Material_proPerty: "+Material_proPerty+"');</script>");
	out.println("<script>alert('Material_proDes: "+Material_proDes+"');</script>");
	out.println("<script>alert('MaTypepro_length: "+MaTypepro_length+"');</script>");
	out.println("<script>alert('MatChar_Value: "+MatChar_Value+"');</script>");
	out.println("<script>alert('Matreal_name: "+Matreal_name+"');</script>");
	out.println("<script>alert('useUnuse: "+useUnuse+"');</script>");
	*/
	int min = 0;
	int max = 0;
	
	for(int i = 1 ; i < 7 ; i++ ){
		if(i == MaTypepro_length){
			min = (int)Math.pow(10,i-1);
			max = ((int)Math.pow(10,i)) - 1;
			if(MatChar_Value < min || MatChar_Value > max){
				out.println("<script>alert('자리수 "+MaTypepro_length+" 는 "+min+" 부터 "+max+"까지입니다.');</script>");
				out.println("<script>history.back()</script>");
				return;
			}
		}
	}
	
	try{
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1,company_code);
		pstmt.setString(2,Material_Type);
		pstmt.setString(3,Material_proPerty);
		pstmt.setInt(4,MatChar_Value);
		pstmt.setString(5,collabo);
		pstmt.setString(6,Materal_name);
		pstmt.setString(7,useUnuse);
		
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
		alert('재료가 등록되었습니다.');
		window.location.href='material_property_confirm.jsp';
	</script>	
</body>
</html>