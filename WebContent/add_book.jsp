<%@ include file="ck_session_admin.jsp"%>
<%@ page contentType="text/html; charset=windows-874"%>
<%@ page import="java.sql.*,java.util.*,javazoom.upload.*"%>
<%@ include file="header.jsp"%>
<%@ include file="config.jsp"%>
<%@ include file="m_Numeric.jsp"%>
<%
	String pic_book = path + "\\Image\\pic_book";//กำหนดที่อยู่ของรูปหนังสือ
%>
<jsp:useBean id="up" scope="page" class="javazoom.upload.UploadBean">
	<jsp:setProperty name="up" property="folderstore" value="<%=pic_book%>" />
</jsp:useBean>
<%
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql;
	ResultSet rs = null;
	Vector errors = new Vector();
	//ตรวจสอบว่ามีการส่งข้อมูลแบบ multipart/form-data หรือไม่
	if (MultipartFormDataRequest.isMultipartFormData(request)) {
		MultipartFormDataRequest mrequest = new MultipartFormDataRequest(
		request);
		String isbn = mrequest.getParameter("isbn");
		String title = mrequest.getParameter("title");
		String author = mrequest.getParameter("author");
		String bt_id = mrequest.getParameter("bt_id");
		String n_page = mrequest.getParameter("n_page");
		String publisher = mrequest.getParameter("publisher");
		String time = mrequest.getParameter("time");
		String price = mrequest.getParameter("price");
		String quantity = mrequest.getParameter("quantity");
		String description = mrequest.getParameter("description");
		String filetype = "";
		String image = "";
		String b_id = "";
		//ตรวจสอบข้อผิดพลาดต่างๆ จากค่าที่ส่งมาจากฟอร์ม ถ้ามีข้อผิดพลาดให้เพิ่มไว้ใน errors

		if (isbn.equals("")) {
	errors.add("กรุณากรอกรหัสISBN");
		}
		if (title.equals("")) {
	errors.add("กรุณากรอกชื่อหนังสือ");
		}
		if (author.equals("")) {
	errors.add("กรุณากรอกชื่อผู้แต่ง");
		}
		if (bt_id.equals("0")) {
	errors.add("กรุณาเลือกประเภทหนังสือ");
		}
		if (n_page.equals("")) {
	errors.add("กรุณากรอกจำนวนหน้า");
		}
		if (!n_page.equals("")) {
	if (!isNumeric(n_page)) {
		errors.add("กรุณากรอกจำนวนหน้าที่เป็นตัวเลขเท่านั้น");
	}
		}
		if (publisher.equals("")) {
	errors.add("กรุณากรอกสำนักพิมพ์");
		}
		if (time.equals("")) {
	errors.add("กรุณากรอกจัดพิมพ์ครั้งที่");
		}
		if (!time.equals("")) {
	if (!isNumeric(time)) {
		errors.add("กรุณากรอกครั้งที่พิมพ์ที่เป็นตัวเลขเท่านั้น");
	}
		}
		if (price.equals("")) {
	errors.add("กรุณากรอกราคา");
		}
		if (!price.equals("")) {
	if (!isNumeric(price)) {
		errors.add("กรุณากรอกราคาที่เป็นตัวเลขเท่านั้น");
	}
		}
		if (quantity.equals("")) {
	errors.add("กรุณากรอกจำนวน");
		}
		if (!quantity.equals("")) {
	if (!isNumeric(quantity)) {
		errors.add("กรุณากรอกจำนวนที่เป็นตัวเลขเท่านั้น");
	}
		}
		if (description.equals("")) {
	errors.add("กรุณากรอกรายละเอียด");
		}

		//ตรวจสอบค่าจาก file field
		Hashtable files = mrequest.getFiles();
		UploadFile file = (UploadFile) files.get("upload");
		if (file.getData() != null) {
	String filename = file.getFileName().toLowerCase();
	filetype = filename.substring(filename.lastIndexOf("."),
			filename.length());
	if ((filetype.indexOf("gif") == -1)
			&& (filetype.indexOf("jpeg") == -1)
			&& (filetype.indexOf("jpg") == -1)) {
		errors.add("ตรวจสอบชนิดไฟล์รูปภาพ");
	}
		} else {
			errors.add("กรุณาเลือกรูปภาพ");
		}
		//ตรวจสอบว่ามีข้อผิดพลาดหรือไม่ ถ้ามีให้แสดงข้อผิดพลาดออกมา
		if (errors.size() > 0) {
%><%@ include file="../ckError.jsp"%>
<%
	} else {
			//เพิ่มข่าวลงในตาราง book
			sql = "insert into book (bt_id,isbn,author,title,price,quantity,description,image,publisher,time,n_page) VALUES ('"
					+ isbn
					+ "','"
					+ bt_id
					+ "','"
					+ author
					+ "','"
					+ title
					+ "','"
					+ price
					+ "','"
					+ quantity
					+ "','"
					+ description
					+ "','"
					+ image
					+ "','"
					+ publisher
					+ "','"
					+ time
					+ "','" + n_page + "') ";

			stmt.executeUpdate(sql);
			//หาค่าสูงสุดของ news_id จากตาราง news เพื่อใช้ในการกำหนดชื่อไฟล์ที่ upload และแก้ไขชื่อไฟล์ในฐานข้อมูล
			sql = "select  max(b_id) as b_id from book";
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				b_id = rs.getString("b_id");
			}
			rs.close();
			image = b_id + filetype;
			//แก้ไขชื่อรูปในฐานข้อมูล
			sql = "update book set image='default.jpg' where b_id='"
					+ b_id + "'";
			stmt.executeUpdate(sql);
			//เปลี่ยนชื่อรูปที่ upload แล้วทำการ upload file
			file.setFileName(image);
			up.store(mrequest, "upload");
			response.sendRedirect("book_list_menu.jsp");
		}
	} else {
%><br>
<form action="add_book.jsp" method="post" enctype="multipart/form-data">
	<table width="70%" border="1" align="center" cellspacing="0"
		bordercolor="black" bgcolor="#E1EEEE">
		<tr bgcolor="#79CDCD">
			<td colspan="2"><div align="center" style=""><b>เพิ่มหนังสือ</b></div></td>
		</tr>
		<tr>
			<td width="25%"><b>ISBN</b></td>
			<td width="75%"><input name="isbn" type="text" maxlength="13"></td>
		</tr>
		<tr>
			<td><b>ชื่อหนังสือ</b></td>
			<td><input name="title" type="text"></td>
		</tr>
		<tr>
			<td><b>ชื่อผู้แต่ง</b></td>
			<td><input name="author" type="text"></td>
		</tr>
		<tr>
			<td><b>ประเภทหนังสือ</b></td>
			<td><select name="bt_id">
					<option value="0" selected>&lt;--- เลือกประเภทหนังสือ
						--&gt;</option>
					<%
						sql = "select * from booktype";
							rs = stmt.executeQuery(sql);
							while (rs.next()) {
					%>
					<option value="<%=rs.getString("bt_id")%>"><%=new String(rs.getString("name").getBytes(
							"ISO8859_1"), "windows-874")%></option>
					<%
						}
							rs.close();
					%>
			</select></td>
		</tr>
		<tr>
			<td><b>จำนวนหน้า</b></td>
			<td><input name="n_page" type="text" size="5">หน้า</td>
		</tr>
		<tr>
			<td><b>สำนักพิมพ์</b></td>
			<td><input name="publisher" type="text"></td>
		</tr>
		<tr>
			<td><b>จัดพิมพ์ครั้งที่</b></td>
			<td><input name="time" type="text" size="10"></td>
		</tr>
		<tr>
			<td><b>ราคา</b></td>
			<td><input name="price" type="text" size="10">บาท</td>
		</tr>
		<tr>
			<td><b>จำนวน</b></td>
			<td><input name="quantity" type="text" size="5" maxlength="5">เล่ม</td>
		</tr>
		<tr>
			<td><b>รายละเอียด</b></td>
			<td><textarea name="description" cols="45" rows="5"></textarea></td>
		</tr>
		<tr>
			<td><b>ไฟล์รูปภาพ [jpg,gif]</b></td>
			<td><input name="upload" type="file"></td>
		</tr>
		<tr>
			<td colspan="2"><div align="center">
					<input type="submit" name="Submit" value="ตกลง"> <input
						name="Reset" type="reset" value="ล้างข้อมูล">
				</div></td>
		</tr>
	</table>
</form>
<%
	}
%>
