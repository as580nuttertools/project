<% 
String status=""+session.getAttribute("status");
if(status.equals("admin")){response.sendRedirect("admin_alert.jsp");}
%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ include file="header.jsp"%>
<br>
<form action="admin_login.jsp" method="post">
  <table width="30%" align="center" cellspacing="0" >
    <tr bgcolor="#CC99FF">
      <td colspan="2"><div align="center" style="font-weight: bold">ADMIN LOGIN </div></td>
    </tr>
    <tr bgcolor="#ECE9D8">
      <td>username</td>
      <td><input name="j_username" type="text" id="j_username"></td>
    </tr>
    <tr bgcolor="#ECE9D8">
      <td>password</td>
      <td><input name="j_password" type="password" id="j_password"></td>
    </tr>
    <tr bgcolor="#ECE9D8">
      <td colspan="2"><div align="center">
        <input type="submit" name="Submit" value="Login">
      </div><div align="center"></div></td>
    </tr>
  </table> 
</form>
