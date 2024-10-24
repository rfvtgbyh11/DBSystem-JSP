<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%
    session.invalidate();
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('로그아웃되었습니다.')");
    script.println("location.href='index.jsp';");
    script.println("</script>");
%>