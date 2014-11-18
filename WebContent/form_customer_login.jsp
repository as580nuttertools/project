<%@ page contentType="text/html; charset=windows-874"%>
<form method="post" action="customer_login.jsp">
	<table width="150" border="0" cellspacing="0">
		<tr>
			<td width="98%" bgcolor="#0000FF"><center>
					<font color="#FFFFF"><b>USER LOGIN </b> </font>
				</center></td>
		</tr>
		<tr>
			<td><div align="center">ชื่อเข้าสู่ระบบ</div></td>
		</tr>
		<tr>
			<td><div align="center">
					<input name="j_username" type="text" id="j_username" size="20">
				</div></td>
		</tr>
		<tr>
			<td><div align="center">รหัสผ่าน</div></td>
		</tr>
		<tr>
			<td><div align="center">
					<input name="j_password" type="password" id="j_password" size="20">
				</div></td>
		</tr>
		<tr>
			<td><div align="center">
					<input name="ck" type="hidden" id="ck" value="yes"> <input
						name="Submit" type="submit" value="Login">
				</div></td>
		</tr>
		<tr>
			<td><p>
					# <a href="forget_pw1.jsp">ลืมรหัสผ่าน</a> <br> # <a
						href="register.jsp">ลงทะเบียนใหม่</a><br>
				</p></td>
		</tr>
	</table>
</form>
