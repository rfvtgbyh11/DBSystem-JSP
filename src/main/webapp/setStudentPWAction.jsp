<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.*"%>
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>

<%
    //사용자가 보낸 데이터를 한글을 사용할 수 있는 형식으로 변환
    request.setCharacterEncoding("UTF-8");
    String userID = null;
    String oldPW = null;
    String newPW = null;

    oldPW = (String) request.getParameter("oldPW");
    newPW = (String) request.getParameter("newPW");

    UserDAO userDAO = new UserDAO();

    if (session.getAttribute("userID") != null)
      userID = (String) session.getAttribute("userID");

    if (userID == null) response.sendRedirect("index.jsp");

    int result = userDAO.setStuPW(userID, oldPW, newPW);


    if (result == 1) {
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('비밀번호 불일치')");
      script.println("location.href='student_main.jsp';");
      script.println("</script>");
      script.close();
      return;
    }
    else if (result == 0) {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('변경되었습니다')");
    script.println("location.href='student_main.jsp';");
    script.println("</script>");
    script.close();
    return;
    }
    else {
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('오류가 발생하였습니다')");
      script.println("location.href='student_main.jsp';");
      script.println("</script>");
      script.close();
      return;
    }
%>