<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.util.List" %>
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
        List<UserDAO._ClassInfo> list = userDAO.courseInfo(userID);

        System.out.println(request.getParameter("classID"));
        System.out.println(userID);
        int ret = userDAO.takeCls(request.getParameter("classID"), userID, list);

        PrintWriter script = response.getWriter();
        if (ret == 1) {
            script.println("<script>");
            script.println("alert('B+ 이상 받은 과목은 재수강할수 없습니다.')");
            script.println("location.href='student_sugang.jsp';");
            script.println("</script>");
        } else if (ret == 2) {
            script.println("<script>");
            script.println("alert('수강정원이 가득 찼습니다.')");
            script.println("location.href='student_sugang.jsp';");
            script.println("</script>");
        }else if (ret == 3) {
            script.println("<script>");
            script.println("alert('다른 수강과목과 겹치는 시간이 있습니다.')");
            script.println("location.href='student_sugang.jsp';");
            script.println("</script>");
        }else if (ret == 4) {
            script.println("<script>");
            script.println("alert('최대학점을 초과하였습니다.')");
            script.println("location.href='student_sugang.jsp';");
            script.println("</script>");
        }else if (ret == 5) {
            script.println("<script>");
            script.println("alert('이미 이번학기에 수강신청한 과목입니다.')");
            script.println("location.href='student_sugang.jsp';");
            script.println("</script>");
        }else {
            script.println("<script>");
            script.println("alert('수강신청이 완료되었습니다.')");
            script.println("location.href='student_sugang.jsp';");
            script.println("</script>");
        }
    %>
</head>
<body>

</body>
</html>
