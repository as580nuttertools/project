<%@ page contentType="text/html; charset=windows-874"%>
<%@ include file="header.jsp"%>
<%
String j_username=request.getParameter("username");
%>
<div align="center"></div>
<form method="post" action="login.jsp">
  <table width="35%" border="1" align="center">
    <tr bgcolor="#00CCFF">
      <td colspan="2">เข้าสู่ระบบ</td>
    </tr>
    <tr>
      <td width="42%">ชื่อผู้ใช้งาน</td>
      <td width="58%"><input name="j_username" type="text" value="<%=(j_username==null)?"":j_username%>"></td>
    </tr>
    <tr>
      <td>รหัสผ่าน</td>
      <td><input name="j_password" type="password"></td>
    </tr>
    <tr>
      <td colspan="2"><center>
        <input name="status" type="hidden" value="customer">
        <input type="submit" name="Submit" value="Login"></center></td>
    </tr>
    <tr>
      <td colspan="2"><a href="register.jsp">ลงทะเบียนใหม่</a> | <a href="forget_pw1.jsp">ลืมรหัสผ่าน</a></td>
    </tr>
  </table>
</form>
