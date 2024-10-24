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
    int ret = userDAO.addWish(request.getParameter("classID"), userID);

    PrintWriter script = response.getWriter();
    if (ret == 1) {
      script.println("<script>");
      script.println("alert('B+ 이상 받은 과목은 재수강할수 없습니다.')");
      script.println("location.href='student_sugang.jsp';");
      script.println("</script>");
    }else {
      script.println("<script>");
      script.println("alert('희망등록이 완료되었습니다.')");
      script.println("location.href='student_sugang.jsp';");
      script.println("</script>");
    }
  %>
</head>
<body>

</body>
</html>
