<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<script>
	function emptyCheck(){
		var ComCode = document.Registform_datail.Company_input.value;
		var matCharType = document.Registform_datail.Material_Chrtyp_input.value;
		var matCharTypeDesc = document.Registform_datail.Material_ChrTyp_Description_input.value;
		var charLeng = document.Registform_datail.Char_type_length.value;
		
		if(!ComCode || !matCharType || !matCharTypeDesc || !charLeng){
			alert('모든 항목을 입력하세요.');
			return false;
		} else{
			return true;
		}
	}
	</script>
<title>Material Charactor</title>
</head>
<body>
<%
	String company_code = (String)session.getAttribute("Company_input");
%>
<form name="Registform_datail" action="material_detail_ok.jsp" method="get" onsubmit="return emptyCheck()">
		<table align="center">
			
				<tr><td class="info">Company Code: </td>
					<td class="input_info"> 
						<input type="text" name="Company_input" id="Company" value='<%=company_code %>' size="20">
					</td>	
				</tr>
				
				<tr><td class="info">Material Character Type : </td>
					<td class="input_info">
						<input type="text" name="Material_Chrtyp_input" id="Material_Chrtyp_input" size="20">
					</td>
				</tr>
				 
				<tr><td class="info">Description: </td>
					<td class="input_info">
						<input type="text" name="Material_ChrTyp_Description_input" id="Material_ChrTyp_Description_input" size="20">
					</td>
				</tr>
				  
				<tr><td class="info">Character Type Length: </td>
					<td class="input_info">
						<input type="text" name="Char_type_length" id="Char_type_length" size="20">
					</td>
				</tr>
		
					<tr>
						<td style="text-align: center;" colspan="2">
							<input type="submit" id="btn_submit" value="Input">
						</td>
					</tr>
				
			
		</table>
	</form>	
</body>
</html>