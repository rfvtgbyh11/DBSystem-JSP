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
  String userPassword = null;

  userID = (String) request.getParameter("userID");
  userPassword = (String) request.getParameter("userPassword");

  UserDAO userDAO = new UserDAO();
  int result = userDAO.login(userID, userPassword);


  if (result == 1) {
    session.setAttribute("userType", "Admin");
    session.setAttribute("userID", userID);
    response.sendRedirect("admin_main.jsp");
    return;
  }
  else if (result == 2) {
    session.setAttribute("userType", "Student");
    session.setAttribute("userID", userID);
    response.sendRedirect("student_main.jsp");
    return;
  }
  else {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('아이디 또는 비밀번호 불일치')");
    script.println("location.href='index.jsp';");
    script.println("</script>");
    script.close();
    return;
  }
%>