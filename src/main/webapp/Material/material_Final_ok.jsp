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
<title>Material Final OK</title>
</head>
<body>
<%
	Connection conn = null;

	String url = "jdbc:mysql://localhost:3306/campusdb";
	String id = "root"; // MySQL에 접속을 위한 계정의 ID
	String pwd = "jinsang1027#"; // MySQL에 접속을 위한 계정의 암호
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pwd);

	PreparedStatement pstmt = null; // 등록할 때 사용함
	String company_code = request.getParameter("Company_input"); //ComCode
	String material_Type = request.getParameter("Material_Type"); // MatType
	
	int First_Value = 0;
	String First_ValueDesc = "";
	try {
	    First_Value = Integer.parseInt(request.getParameter("First_Char_Value")); // chat1value 문자로 받아들이고 나중에 숫자로 변경
	    First_ValueDesc = request.getParameter("Fir_CharValueDes");
	} catch (NumberFormatException e) {
	    e.printStackTrace();
	}

	int Second_Value = 0;
	String Second_ValueDesc = "";
	try {
	    Second_Value = Integer.parseInt(request.getParameter("Sec_Char_Value")); // chat2value 문자로 받아들이고 나중에 숫자로 변경
	    Second_ValueDesc = request.getParameter("Sec_CharValueDes");
	} catch (NumberFormatException e) {
	    e.printStackTrace();
	}

	int Third_Value = 0;
	String Third_ValueDesc = "";
	try {
	    Third_Value = Integer.parseInt(request.getParameter("Thir_Char_Value")); // chat3value 문자로 받아들이고 나중에 숫자로 변경
	    Third_ValueDesc = request.getParameter("Thir_CharValueDes");
	} catch (NumberFormatException e) {
	    e.printStackTrace();
	}

	int Fourth_Value = 0;
	String Fourth_ValueDesc = "";
	try {
	    Fourth_Value = Integer.parseInt(request.getParameter("Four_Char_Value")); // chat4value 문자로 받아들이고 나중에 숫자로 변경
	    Fourth_ValueDesc = request.getParameter("Four_CharValueDes");
	} catch (NumberFormatException e) {
	    e.printStackTrace();
	}
	
	String material_Num = request.getParameter("MaterialNum");//10111-000001
	
	String material_Desc = ""; //primary key
	
	if(Fourth_ValueDesc == ""){
		material_Desc = First_ValueDesc + "," + Second_ValueDesc + "," + Third_ValueDesc;
			if(Third_ValueDesc == ""){
				material_Desc = First_ValueDesc + "," + Second_ValueDesc;
					if(Second_ValueDesc == ""){
						material_Desc = First_ValueDesc;
					}
			}
	} else{
		material_Desc = request.getParameter("Material_Des");
	}
	
	//최종적으로 재료를 등럭한 날짜
	LocalDateTime now = LocalDateTime.now();
	String master_Date = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	
	String creator_id = (String)session.getAttribute("user_code"); //등록한 사람의 아이디
	/*---------------------------------------------------------------*/
	//String useUnuse = (String)session.getAttribute("Use_input"); //등록한 재료의 사용 유무
	Connection conn_0 = null;
	PreparedStatement pstmt_0 = null; // 처음 재료를 등록한 날짜를 가져오기 위함
	String sql_0 = "SELECT use/unuse FROM material_1 WHERE MatType = ?";
	ResultSet rs_0 = null;
	String useUnuse = "";
	
	try {
		conn_0 = DriverManager.getConnection(url, id, pwd);
		pstmt_0 = conn.prepareStatement(sql_0);
		pstmt_0.setString(1, material_Type);
		rs_0 = pstmt_0.executeQuery();
		
		if (rs_0.next()) {
			useUnuse = rs_0.getString("use/unuse"); //문자로 인식
			
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}  finally {
		if (rs_0 != null) {
			rs_0.close();
		}
		if (pstmt_0 != null) {
			pstmt_0.close();
		}
		if (conn_0 != null) {
			conn_0.close();
		}
	}
	
	/*---------------------------------------------------------------*/
	Connection conn_1 = null;
	PreparedStatement pstmt_1 = null; // 처음 재료를 등록한 날짜를 가져오기 위함
	String sql_1 = "SELECT CreatDate FROM material_1 WHERE MatType = ?";
	ResultSet rs_1 = null;
	String create_Date = "";
	
	try {
		conn_1 = DriverManager.getConnection(url, id, pwd);
		pstmt_1 = conn.prepareStatement(sql_1);
		pstmt_1.setString(1, material_Type);
		rs_1 = pstmt_1.executeQuery();
		
		if (rs_1.next()) {
			create_Date = rs_1.getString("CreatDate"); //문자로 인식
			
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}  finally {
		if (rs_1 != null) {
			rs_1.close();
		}
		if (pstmt_1 != null) {
			pstmt_1.close();
		}
		if (conn_1 != null) {
			conn_1.close();
		}
	}

	/*---------------------------------------------------------------*/
	
	Connection conn_2 = null;
	PreparedStatement pstmt_2 = null; // 재료의 코드 길이
	String sql_2 = "SELECT TotalLeng FROM material_2 WHERE MatType = ?";
	ResultSet rs_2 = null;
	int TotalLeng = 0;
	
	try {
		conn_2 = DriverManager.getConnection(url, id, pwd);
		pstmt_2 = conn_2.prepareStatement(sql_2);
		pstmt_2.setString(1, material_Type);
		rs_2 = pstmt_2.executeQuery();
		
		if (rs_2.next()) {
			TotalLeng = rs_2.getInt("TotalLeng"); //숫자로 인식
			int exported_totalLeng = material_Num.split("-")[0].length();//재료의 고유코드의 앞자리의 자리 수
			if(exported_totalLeng != TotalLeng){
				out.println("<script>alert('해당 재료의 고유코드(앞자리)는 "+TotalLeng+" 자리입니다. 다시 입력하세요.');</script>");
				out.print("<script> history.back();</script>");
				conn.close();
				return;
			}
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		if (rs_2 != null) {
			rs_2.close();
		}
		if (pstmt_2 != null) {
			pstmt_2.close();
		}
		if (conn_2 != null) {
			conn_2.close();
		}
	}
	
	/*---------------------------------------------------------------*/
	
	Connection conn_3 = null;
	PreparedStatement pstmt_3 = null; // 재료의 시리얼 넘버
	String sql_3 = "SELECT Serial_Number_자리수 FROM material_2 WHERE MatType = ?";
	ResultSet rs_3 = null;
	int SerialNum = 0;
	
	try {
		conn_3 = DriverManager.getConnection(url, id, pwd);
		pstmt_3 = conn_3.prepareStatement(sql_3);
		pstmt_3.setString(1, material_Type);
		rs_3 = pstmt_3.executeQuery();
		
		while (rs_3.next()) {
			SerialNum = Integer.parseInt(rs_3.getString("Serial_Number_자리수")); // 숫자로 인식	
			String exported_serialNum = material_Num.substring(material_Num.lastIndexOf("-")+1); //입력받은 material_Num에서 뒷자리 추출
			int length = exported_serialNum.length(); //추출한 뒷자리의 길이 계산
			if(SerialNum != length){
				out.println("<script>alert('해당 재료의 고유코드(Serial Number)는 "+SerialNum+" 자리입니다. 다시 입력하세요.');</script>");
				out.print("<script> history.back();</script>");
				conn.close();
				return;				
			}	
			
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		if (rs_3 != null) {
			rs_3.close();
		}
		if (pstmt_3 != null) {
			pstmt_3.close();
		}
		if (conn_3 != null) {
			conn_3.close();
		}
	}
	
	/*---------------------------------------------------------------*/
	/*
	out.println("<script>alert('기업코드: "+company_code+"');</script>");
	out.println("<script>alert('재료 코드"+material_Type+"');</script>");
	out.println("<script>alert('숫자1: "+First_Value+"');</script>");
	out.println("<script>alert('재료 타입1: "+First_ValueDesc+"');</script>");
	out.println("<script>alert('숫자2: "+Second_Value+"');</script>");
	out.println("<script>alert('재료 타입2: "+Second_ValueDesc+"');</script>");
	out.println("<script>alert('숫자3: "+Third_Value+"');</script>");
	out.println("<script>alert('재료 타입3: "+Third_ValueDesc+"');</script>");
	out.println("<script>alert('숫자4: "+Fourth_Value+"');</script>");
	out.println("<script>alert('재료 타입4: "+Fourth_ValueDesc+"');</script>");
	
	out.println("<script>alert('초기에 입력한 totalleng: "+TotalLeng+"');</script>");
	out.println("<script>alert('초기에 입력한 시리얼넘버: "+SerialNum+"');</script>");
	
	out.println("<script>alert('재료의 총 코드 앞자리: "+material_Num+"');</script>");
	out.println("<script>alert('재료의 식별코드: "+material_Desc+"');</script>");
	out.println("<script>alert('최종 등록일: "+master_Date+"');</script>");
	out.println("<script>alert('초기 등록일: "+create_Date+"');</script>");
	out.println("<script>alert('등록인 코드: "+creator_id+"');</script>");
	out.println("<script>alert('사용 유무: "+useUnuse+"');</script>");
	*/
	/*------------등록 유무를 점검하는 코드-------------------------------*/
	
	Connection conn_4 = null;
	PreparedStatement pstmt_4 = null; // 재료의 교유 코드 추출
	String sql_4 = "SELECT MatNum FROM material_final WHERE MatDesc = ?";
	ResultSet rs_4 = null;
	try{
		conn_4 = DriverManager.getConnection(url, id, pwd);
		pstmt_4 = conn_4.prepareStatement(sql_4);
		pstmt_4.setString(1, material_Desc);
		rs_4 = pstmt_4.executeQuery();
		
		while(rs_4.next()){
			String matNum_exported = rs_4.getString("MatNum"); // material_final 에서 MatType에 해당하는 MatNum 가져오기 
				if(material_Num.equals(matNum_exported)){
					out.println("<script>alert('다음 재료의 식별코드는 "+matNum_exported+" 입력되었습니다.');</script>");
					out.print("<script> history.back();</script>");
					conn.close();
					return;
				}
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		if (rs_4 != null) {
			rs_4.close();
		}
		if (pstmt_4 != null) {
			pstmt_4.close();
		}
		if (conn_4 != null) {
			conn_4.close();
		}
	}

	try{
		String sql = "INSERT INTO material_final VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
	
		pstmt.setString(1,company_code);
		pstmt.setString(2,material_Type);
		pstmt.setInt(3,First_Value);
		pstmt.setInt(4,Second_Value);
		pstmt.setInt(5,Third_Value);
		pstmt.setInt(6,Fourth_Value);
		pstmt.setString(7,material_Num);
		pstmt.setString(8,material_Desc);
		pstmt.setString(9,master_Date);
		pstmt.setString(10,create_Date);
		pstmt.setString(11,creator_id);
		pstmt.setString(12,useUnuse);
		
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
		window.location.href='material_final_confirm.jsp';
	</script>	
	
</body>
</html>