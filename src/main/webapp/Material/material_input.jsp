<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

	<script>
		function emptyCheck(){
			var ComCode = document.Registform.Company_input.value;
			var MatType = document.Registform.Material_Type_input.value;
			var MatTypeDesc = document.Registform.Description_input.value;
			var UseUnuse = document.Registform.Use_input.value;
			var CreatorID = document.Registform.user_code.value;
			
			if(!ComCode || !MatType || !MatTypeDesc || !UseUnuse){
				alert('모든 항목을 입력하세요.');
				return false;
			} else{
				return true;
			}
		}
		
		function Confirm_check(){
			var master_id = "E100";
			var master = document.getElementById('identification').value;
			if(master != master_id){
				alert("관리자 코드를 다시 입력해주세요.");
				return false;
			} else{
				alert("Move to Confirm Page.");
				window.location.href='material_confirm.jsp';
				return true;
			}
			
		}
	</script>
<title>Material input</title>
</head>
<body>
	<center>
	<h3>필수입력사항</h3>
	</center>
	
	<form name="Registform" action="material_ok.jsp" method="get" onSubmit="return emptyCheck()">
		<table align="center">
			
				<tr><th class="info" align="right">Company: </th>
					<td class="input_info"> 
						<input type="text" name="Company_input" id="Company" size="20">
						
					</td>	
				</tr>
				
				<tr><th class="info" align="right">Material Type: </th>
					<td cllss="input_info">
						<input type="text" name="Material_Type_input" id="Material_Type_input" size="20">
					</td>
				</tr>
				 
				<tr><th class="info" align="right">Description: </th>
					<td class="input_info">
						<input type="text" name="Description_input" id="Description_input" size="20">
					</td>
				</tr>
				  
				<tr><th class="info" align="right">Use/Unuse: </th>
					<td class="input_info">
						<input type="text" name="Use_input" id="Use_input" placeholder="Y/N" size="20">
					</td>
				</tr>
				
				<tr><th class="info" align="right">Material Type: </th>
					<td class="input_info">
						<input name=user_code id=user_code value=9005510 />
					</td>
				 </tr>

				<tr>
					<td style="text-align: center;" colspan="2">
						<input type="submit" id="btn_submin" value="Input">
					</td>
				</tr>	
				
		</table>
	</form>	
	
			<center>
				<tr>
					<td>
						<input type="password" class="textbox" name="identification" id="identification" placeholder="Plaese Input Company Code"><br>
						<button class="button" onclick="return Confirm_check()">Confirm</button>
						</form>
					</td>
				</tr>
			</center>
		
	

</body>
</html>