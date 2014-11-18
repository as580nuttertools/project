<%@ include file="ck_session_customer.jsp"%>
<%@ page contentType="text/html; charset=windows-874" %>
<%@ page import="java.sql.*,java.util.*" %>
<%@ include file="header_user.jsp"%>
<%@ include file="config.jsp"%>
<%
Class.forName(driver);
Connection con=DriverManager.getConnection(url,user,pw);
Statement stmt=con.createStatement();
String sql;ResultSet rs=null;
if(request.getParameter("Submit")!=null){
String username=request.getParameter("username");
String password=request.getParameter("password");
String cpassword=request.getParameter("cpassword");
String que_forget=request.getParameter("que_forget");
String ans_forget=request.getParameter("ans_forget");
Vector errors=new Vector();
if(username.equals("")){
errors.add("ตรวจสอบชื่อเข้าสู่ระบบ");
}
if((!password.equals(cpassword))||password.length()<6||password.length()>12){
errors.add("ตรวจสอบรหัสผ่านและยืนยันรหัสผ่าน");
}
if(que_forget.equals("")||ans_forget.equals("")){
errors.add("ตรวจสอบคำถามกันลืม หรือคำตอบกันลืม"); 
}
//ถ้าชื่อผู้เข้าสู่ระบบไม่ใช่ชื่อเดิมตรวจสอบว่าชื่อใหม่ที่เปลี่ยนซ้ำหรือไม่
if(!username.equals(session.getAttribute("j_username"))){
sql="select username from customer where username='"+username+"'";
rs=stmt.executeQuery(sql);
if(rs.next()){
errors.add("ชื่อเข้าสู่ระบบนี้มีผู้ใช้แล้ว");
}rs.close();
}
if(errors.size()>0){
%><%@ include file="ckError.jsp"%><%
}else{
sql="update customer set username='"+username+"',password='"+password+"',que_forget='"+que_forget+"',ans_forget='"+ans_forget+"' where username='"+session.getAttribute("j_username")+"'";
stmt.executeUpdate(sql);
session.invalidate();
%>
<center>แก้ไขข้อมูลเรียบร้อยแล้วให้ทำการ Login เข้ามาใหม่
<jsp:include page="form_customer_login.jsp"/></center>
<%
}
}else{
%>
<form action="edit_data_login.jsp" method="post" >
  <table width="55%" border="0" align="center" cellspacing="0">
    <tr bgcolor="#ECE9D8">
      <td colspan="2"><span style="font-weight: bold">แก้ไขข้อมูลที่ใช้เข้าสู่ระบบ</span></td>
    </tr>
    <tr>
      <td>ชื่อเข้าสู่ระบบ</td>
      <td><input name="username" type="text" value="<%=session.getAttribute("j_username")%>"></td>
    </tr>
    <tr>
      <td>รหัสผ่านใหม่</td>
      <td><input name="password" type="password">      
      *[6-12 ตัวอักษร]</td>
    </tr>
    <tr>
      <td>ยืนยันรหัสผ่าน</td>
      <td><input name="cpassword" type="password">
      * </td>
    </tr>
    <tr>
      <td>คำถามกันลืม</td>
      <td><input name="que_forget" type="text">
      *</td>
    </tr>
    <tr>
      <td>คำตอบ</td>
      <td><input name="ans_forget" type="text">
      *</td>
    </tr>
    <tr>
      <td colspan="2"><div align="center">
        <input type="submit" name="Submit" value="แก้ไข">
      </div></td>
    </tr>
  </table>
</form>
<%}%>
