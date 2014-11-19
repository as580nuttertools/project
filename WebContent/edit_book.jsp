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
	<jsp:setProperty name="up" property="overwrite" value="true" />
</jsp:useBean>
<%
	Class.forName(driver);
	Connection con = DriverManager.getConnection(url, user, pw);
	Statement stmt = con.createStatement();
	String sql;
	ResultSet rs = null;
	Vector errors = new Vector();
	String b_id = request.getParameter("b_id");
	String isbn = "", title = "", author = "", bt_id = "", n_page = "", publisher = "", time = "", price = "", quantity = "", description = "", filetype = "", image = "";
	sql = "select * from book where b_id=" + b_id;
	rs = stmt.executeQuery(sql);
	while (rs.next()) {
		isbn = rs.getString("isbn");
		title = new String(rs.getString("title").getBytes("ISO8859_1"),
				"windows-874");
		author = new String(rs.getString("author")
				.getBytes("ISO8859_1"), "windows-874");
		bt_id = rs.getString("bt_id");
		n_page = rs.getString("n_page");
		publisher = new String(rs.getString("publisher").getBytes(
				"ISO8859_1"), "windows-874");
		time = rs.getString("time");
		price = rs.getString("price");
		quantity = rs.getString("quantity");
		image = rs.getString("image");
		description = new String(rs.getString("description").getBytes(
				"ISO8859_1"), "windows-874");
	}
	//ตรวจสอบว่ามีการส่งข้อมูลแบบ multipart/form-data หรือไม่
	if (MultipartFormDataRequest.isMultipartFormData(request)) {
		MultipartFormDataRequest mrequest = new MultipartFormDataRequest(
				request);
		b_id = mrequest.getParameter("b_id");
		isbn = mrequest.getParameter("isbn");
		title = mrequest.getParameter("title");
		author = mrequest.getParameter("author");
		bt_id = mrequest.getParameter("bt_id");
		n_page = mrequest.getParameter("n_page");
		publisher = mrequest.getParameter("publisher");
		time = mrequest.getParameter("time");
		price = mrequest.getParameter("price");
		quantity = mrequest.getParameter("quantity");
		description = mrequest.getParameter("description");
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
			image = filename;
		}
		//ตรวจสอบว่ามีข้อผิดพลาดหรือไม่ ถ้ามีให้แสดงข้อผิดพลาดออกมา
		if (errors.size() > 0) {
%><%@ include file="../ckError.jsp"%>
<%
	} else {
			//แก้ไขข่าวในตาราง news
			if (file.getData() != null) {
				sql = "update book set  bt_id='" + bt_id + "',isbn='"
						+ isbn + "',author='" + author + "',title='"
						+ title + "',price='" + price
						+ "',description='" + description + "',image='"
						+ image + "',time='" + time + "',n_page='"
						+ n_page + "' where b_id=" + b_id;
				//ถ้ามีการ upload ให้กำหนดชื่อรูปที่ upload แล้วทำการ upload file
				file.setFileName(image + filetype);
				up.store(mrequest, "upload");
			} else {
				sql = "update book set  bt_id='" + bt_id + "',isbn='"
						+ isbn + "',author='" + author + "',title='"
						+ title + "',price='" + price + "',quantity='"
						+ quantity + "',description='" + description
						+ "',time='" + time + "',n_page='" + n_page
						+ "' where b_id=" + b_id;
			}
			int row = stmt.executeUpdate(sql);
			if (row != 0) {
				response.sendRedirect("book_list_menu.jsp");
			}
		}
	} else {
%>
<br>
<form action="edit_book.jsp" method="post" enctype="multipart/form-data">
	<table width="70%" border="1" align="center" cellspacing="0"
		bordercolor="black" bgcolor="#E1EEEE">
		<tr bgcolor="#79CDCD">
			<td colspan="2" align="center"><strong>แก้ไขหนังสือ</strong></td>
		</tr>
		<tr>
			<td width="25%"><b>ISBN</b></td>
			<td width="75%"><input name="isbn" type="text" value="<%=isbn%>"
				maxlength="13"></td>
		</tr>
		<tr>
			<td><b>ชื่อหนังสือ</b></td>
			<td><input name="title" type="text" value="<%=title%>">
			</td>
		</tr>
		<tr>
			<td><b>ชื่อผู้แต่ง</b></td>
			<td><input name="author" type="text" value="<%=author%>">
			</td>
		</tr>
		<tr>
			<td><b>ประเภทหนังสือ</b></td>
			<td><select name="bt_id">
					<option value="0">&lt;--- เลือกประเภทหนังสือ --&gt;</option>
					<%
						sql = "select * from booktype";
							rs = stmt.executeQuery(sql);
							while (rs.next()) {
					%>
					<option value="<%=rs.getString("bt_id")%>"
						<%if (rs.getString("bt_id").equals(bt_id)) {
						out.println("selected");
					}%>><%=new String(rs.getString("name").getBytes(
							"ISO8859_1"), "windows-874")%></option>
					<%
						}
							rs.close();
					%>
			</select></td>
		</tr>
		<tr>
			<td><b>จำนวนหน้า</b></td>
			<td><input name="n_page" type="text" value="<%=n_page%>"
				size="5"> หน้า *</td>
		</tr>
		<tr>
			<td><b>สำนักพิมพ์</b></td>
			<td><input name="publisher" type="text" value="<%=publisher%>">
			</td>
		</tr>
		<tr>
			<td><b>จัดพิมพ์ครั้งที่</b></td>
			<td><input name="time" type="text" value="<%=time%>" size="10"></td>
		</tr>
		<tr>
			<td><b>ราคา</b></td>
			<td><input name="price" type="text" value="<%=price%>" size="10">
				<b>บาท </td>
		</tr>
		<tr>
			<td><b>จำนวน</b></td>
			<td><input name="quantity" value="<%=price%>" type="text"
				size="5" maxlength="5">เล่ม</td>
		</tr>
		<tr>
			<td><b>รายละเอียด</b></td>
			<td><textarea name="description" cols="50" rows="5"><%=description%></textarea>
			</td>
		</tr>
		<tr>
			<td><b>ไฟล์รูปภาพ[jpg,gif]</b></td>
			<td><input name="upload" type="file" value="<%=image%>"><b>ว่างไว้ถ้าไม่ต้องการแก้ไข</b></td>
		</tr>
		<tr>
			<td colspan="2"><div align="center">
					<input name="b_id" type="hidden" value="<%=b_id%>"> <input
						type="submit" name="Submit" value="แก้ไข">
				</div></td>
		</tr>
	</table>
</form>
<%
	}
%>
