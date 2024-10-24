<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %><%--
  Created by IntelliJ IDEA.
  User: hyunsu
  Date: 11/15/2022
  Time: 8:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
  UserDAO userDAO = new UserDAO();
  PrintWriter script = response.getWriter();
  String class_id = null;

  if (session.getAttribute("userID") == null) response.sendRedirect("index.jsp");

  class_id = request.getParameter("class_id");
  if (class_id == null) response.sendRedirect("admin_course.jsp");

  if (userDAO.deleteClass(class_id) == 0){
    script.println("<script>");
    script.println("alert('과목이 삭제되었습니다.')");
    script.println("location.href='admin_course.jsp';");
    script.println("</script>");
  }
  else {
    script.println("<script>");
    script.println("alert('에러가 발생하였습니다.')");
    script.println("location.href='admin_course.jsp';");
    script.println("</script>");
  }
%>

</body>
</html>
