<%@ page import="user.UserDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: hyunsu
  Date: 11/15/2022
  Time: 9:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<button id="admin_main" type="button" onclick="location.href='logout_action.jsp';"> 로그아웃 </button>
    <%
        if (session.getAttribute("userID") == null) response.sendRedirect("index.jsp");

        UserDAO userDAO = new UserDAO();
        List<UserDAO.CourseInfo> cInfoList = new ArrayList();
        cInfoList = userDAO.olap();
    %>

    <button id="studentInfo" type="button" onclick="location.href='admin_main.jsp';"> 학생 정보 조회 </button>
    <button id="classInfo" type="button" onclick="location.href='admin_course.jsp';"> 과목 정보 조회</button>

    <table>
        <tr>
            <th>학수번호</th>
            <th>과목이름</th>
            <th>편차</th>
        </tr>
        <%
        for (UserDAO.CourseInfo i : cInfoList){
            out.println("<tr>");
            out.println("<td>" + i.course_id + "</td>");
            out.println("<td>" + i.name + "</td>");
            out.println("<td>" + i.dev.substring(0, 5) + "</td>");
            out.println("</tr>");
        }
    %>
</body>
</html>
