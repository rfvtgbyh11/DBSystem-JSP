<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.util.List" %>
<html>
<head>
  <title>Title</title>
</head>
<body>
<button id="admin_main" type="button" onclick="location.href='logout_action.jsp';"> 로그아웃 </button>
<button id="studentInfo" type="button" onclick="location.href='admin_main.jsp';"> 학생 정보 조회 </button>
<button id="classInfo" type="button" onclick="location.href='admin_course.jsp';"> 과목 정보 조회</button>
<h2>학생 정보 조회</h2>
<form action="admin_main.jsp" method="post">
  학번 <input type="text" name="stuId">
  이름 <input type="text" name="stuName">
  학과 <input type="text" name="major">
  <input type="submit" value="검색">
</form>
<%
  UserDAO userDAO = new UserDAO();
  List<UserDAO.StudentInfo> list = null;
  String stuID = null, stuName = null, major = null;
  String userID = null;

  if (session.getAttribute("userID") != null)
    userID = (String) session.getAttribute("userID");
  else response.sendRedirect("index.jsp");

  if (request.getParameter("stuId") != null)
    stuID = (String) request.getParameter("class_id");

  if (request.getParameter("stuName") != null)
    stuName = (String) request.getParameter("course_id");

  if (request.getParameter("major") != null)
    major = (String) request.getParameter("course_name");

  if (stuID != null || stuName != null || major != null){
    list = userDAO.getstuInfo(stuID, stuName, major);
  } else {
    list = userDAO.getstuInfo("", "", "");
  }

%>

<div>
    <table>
        <tr>
            <th>학번</th>
            <th>이름</th>
            <th>학과</th>
            <th>지도교수</th>
            <th>상태</th>
            <th>조회/수정</th>
        </tr>
      <%
        for (UserDAO.StudentInfo line : list){
          out.println("<tr>");
          out.println("<td>" + String.valueOf(line.student_id) + "</td>");
          out.println("<td>" + line.name + "</td>");
          out.println("<td>" + line.major_name + "</td>");
          out.println("<td>" + line.advisor_name + "</td>");
          out.println("<td>" + line.status + "</td>");%>
      <td><button id="<%=line.student_id%>" type="button" onclick="location.href='stuInfo.jsp?stuID=<%=line.student_id%>';"> 선택</button></td><%
          out.println("<td>");
        }
      %>
    </table>
</div>


</script>



</body>
</html>
