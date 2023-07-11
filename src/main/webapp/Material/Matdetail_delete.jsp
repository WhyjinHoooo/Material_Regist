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
		String MatCharType_code = request.getParameter("target");
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM material_datail WHERE matCharType ='" + MatCharType_code + "'";
		pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();
		pstmt.close();
	%>
	
	<script>
		alert("<%=MatCharType_code%>가 삭제되었습니다.");
		window.location.href="./material_datail_confirm.jsp";
	</script>
	
</body>
</html>