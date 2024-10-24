<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<button id="admin_main" type="button" onclick="location.href='logout_action.jsp';"> 로그아웃 </button>
<%
    String userID = null;
    String name = null;
    String advisor = null;
    String status = null;
    String major = null;

    UserDAO userDAO = new UserDAO();

    if (session.getAttribute("userID") != null)
        userID = (String) session.getAttribute("userID");

    if (userID == null) response.sendRedirect("index.jsp");
    else {
        name = userDAO.getStuName(userID);
        advisor = userDAO.getStuAdv(userID);
        status = userDAO.getStuSt(userID);
        major = userDAO.getStuMaj(userID);
    }

    PrintWriter pw = response.getWriter();
    pw.printf("%s (학생)님 안녕하세요.", name);


%>
<button id="student_main" type="button" onclick="location.href='student_main.jsp';"> 학생 정보 </button>
<button id="student_sugang" type="button" onclick="location.href='student_sugang.jsp';"> 수강 신청 </button>
<button id="student_wishlist" type="button" onclick="location.href='student_wishlist.jsp';"> 희망 내역 </button>
<button id="student_courselist" type="button" onclick="location.href='student_courselist.jsp';"> 신청 내역 </button>
<button id="student_grade" type="button" onclick="location.href='student_grade.jsp';"> 금학기 학점조회 </button>

<h2> 학생 정보 </h2>

<h3> 이름 <%=name%> </h3>
<h3> 학번 <%=userID%> </h3> <button type="button" onclick="location.href='setStudentPW.jsp'">비밀번호 변경하기</button>
<h3> 지도교수 <%=advisor%> </h3>
<h3> 재학상태 <%=status%> </h3> <button type="button" onclick="location.href='setStudentST.jsp'">재학상태 변경하기</button>
<h3> 전공 <%=major%> </h3>



</body>
</html>
