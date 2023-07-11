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
	String Material_description = request.getParameter("Material_description"); //원자제
	int TotalLeng = Integer.parseInt(request.getParameter("TotalLeng")); //TotalLeng 자리수
	String CreatorID = request.getParameter("user_id"); //creatorId
	
	String FirstChar = request.getParameter("Material_firstChar"); //FirstChar
	String SecChar = request.getParameter("Material_SecChar"); // SecondChar
	String ThirdChar = request.getParameter("Material_ThirChar"); // ThirdChar
	String FourthChar = request.getParameter("Material_FourChar");//FourthChar
	
	String sql = "INSERT INTO material_def VALUES(?,?,?,?,?,?,?,?,?)";
	
	String sql_1 = "SELECT charLeng from material_datail WHERE matCharType = ?";
	String sql_2 = "SELECT charLeng from material_datail WHERE matCharType = ?";
	String sql_3 = "SELECT charLeng from material_datail WHERE matCharType = ?";
	String sql_4 = "SELECT charLeng from material_datail WHERE matCharType = ?";
	
	/*out.println("<script>alert('"+company_code+"');</script>");
	out.println("<script>alert('"+Material_Type+"');</script>");
	out.println("<script>alert('"+Material_description+"');</script>");
	out.println("<script>alert('"+TotalLeng+"');</script>");
	out.println("<script>alert('"+CreatorID+"');</script>");
	out.println("<script>alert('"+FirstChar+"');</script>");
	out.println("<script>alert('"+SecChar+"');</script>");
	out.println("<script>alert('"+ThirdChar+"');</script>");
	out.println("<script>alert('"+FourthChar+"');</script>");
	*/
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = null;
	
	//===============================================
	PreparedStatement pstmt_1 = conn.prepareStatement(sql_1);
	pstmt_1.setString(1, FirstChar);
	PreparedStatement pstmt_2 = conn.prepareStatement(sql_2);
	pstmt_2.setString(1, SecChar);
	PreparedStatement pstmt_3 = conn.prepareStatement(sql_3);
	pstmt_3.setString(1, ThirdChar);
	PreparedStatement pstmt_4 = conn.prepareStatement(sql_4);
	pstmt_4.setString(1, FourthChar);
	
	ResultSet rs_1 = null;
	ResultSet rs_2 = null;
	ResultSet rs_3 = null;
	ResultSet rs_4 = null;
	
	int firstChar_num = 0;
	int secondChar_num = 0;
	int thirdChar_num = 0;
	int fourthChar_num = 0;
	
	try{
		rs_1 = pstmt_1.executeQuery();
		rs_2 = pstmt_2.executeQuery();
		rs_3 = pstmt_3.executeQuery();
		rs_4 = pstmt_4.executeQuery(); 

		if(rs_1.next()){
			//out.println("<script>alert('"+rs_1.getInt("charLeng")+"');</script>");
			 firstChar_num = rs_1.getInt("charLeng");
		}
		if(rs_2.next()){
			 //out.println("<script>alert('"+rs_2.getInt("charLeng")+"');</script>");
			  secondChar_num = rs_2.getInt("charLeng");
		}
		if(rs_3.next()){
			//out.println("<script>alert('"+rs_3.getInt("charLeng")+"');</script>");
			 thirdChar_num = rs_3.getInt("charLeng");
		}
		if(rs_4.next()){
			//out.println("<script>alert('"+rs_4.getInt("charLeng")+"');</script>");
			 fourthChar_num = rs_4.getInt("charLeng");
		}
	
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		if(rs_1 != null){
			rs_1.close();
		}
		if(rs_2 != null){
			rs_2.close();
		}
		if(rs_3 != null){
			rs_3.close();
		}
		if(rs_4 != null){
			rs_4.close();
		}
	}
	
	if(firstChar_num + secondChar_num + thirdChar_num + fourthChar_num != TotalLeng ){
		out.println("<script>alert('Characterics 타입을 다시 선택하십시오.'); location.href='material_def_input.jsp'</script>");
		return;
	}	
	
	
	
	try{
		session.setAttribute("TotalLeng",TotalLeng);//재료기 가지는 고유의 코드의 자리수로, final input때 사용
		
		pstmt.setString(1,company_code);
		pstmt.setString(2,Material_Type);
		pstmt.setString(3,FirstChar);
		pstmt.setString(4,SecChar);
		pstmt.setString(5,ThirdChar);
		pstmt.setString(6,FourthChar);
		pstmt.setInt(7,TotalLeng);
		pstmt.setString(8,formattedNow);
		pstmt.setString(9,CreatorID);
		
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
		window.location.href='material_def_confirm.jsp';
	</script>	
</body>
</html>