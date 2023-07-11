<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="../mydbcon.jsp" %>
<title>Insert title here</title>
</head>
<body>
	<%
		String MatType_code = request.getParameter("target");
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM material_result WHERE MatType ='" + MatType_code + "'";
		pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();
		pstmt.close();
	%>
	
	<script>
		alert("<%=MatType_code%>이(가) 삭제되었습니다.");
		window.location.href="./material_property_confirm.jsp";
	</script>
	
</body>
</html>