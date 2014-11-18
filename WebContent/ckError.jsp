<%@ page contentType="text/html; charset=windows-874"%>
<br>
<table width="50%" border="1" align="center" cellpadding="0"
	cellspacing="0" bordercolor="#000000">
	<tr>
		<td bgcolor="#FF0000"><font color="#FFFFFF"><b>เกิดข้อผิดพลาด</b></font></td>
	</tr>
	<tr>
		<td bgcolor="#ECE9D8"><br> <%
 	for (int i = 0; i < errors.size(); i++) {
 		out.println("<li>" + errors.elementAt(i));
 	}
 %> <br>
		<br>
		<center>
				<input type="submit" name="Submit" value="กลับไปแก้ไข"
					onClick="javascript:history.back(1)">
			</center></td>
	</tr>
</table>
<br>
