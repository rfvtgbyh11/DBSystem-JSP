<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%
    UserDAO userDAO = new UserDAO();
    String userID = null;

    if (session.getAttribute("userID") != null) {
      userID = (String)session.getAttribute("userID");
    }
    else response.sendRedirect("index.jsp");

    System.out.println(request.getParameter("classID"));
    System.out.println(userID);
    userDAO.delCourse(request.getParameter("classID"), userID);

    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('수강취소되었습니다.')");
    script.println("location.href='student_courselist.jsp';");
    script.println("</script>");
  %>
</head>
<body>

</body>
</html>
