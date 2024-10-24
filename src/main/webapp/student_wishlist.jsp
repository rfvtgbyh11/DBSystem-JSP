<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.util.List" %>
<html>
<head>
  <title>Title</title>
</head>
<body>
<button id="admin_main" type="button" onclick="location.href='logout_action.jsp';"> 로그아웃 </button>
<%
  String userID = null;
  String name = null;
  int credit = 0;
  String class_id = null;
  String course_id = null;
  String course_name = null;
  List<UserDAO._ClassInfo> list = null;
  List<String> temp = null;
  int listsz = 0;

  UserDAO userDAO = new UserDAO();

  if (session.getAttribute("userID") != null)
    userID = (String) session.getAttribute("userID");

  if (userID == null) response.sendRedirect("index.jsp");
  else {
    name = userDAO.getStuName(userID);
    credit = userDAO.getStuCrd(userID);
  }

  out.println(name+ " (학생)님 안녕하세요.");
  request.setCharacterEncoding("UTF-8");

  if (request.getParameter("class_id") != null)
    class_id = (String) request.getParameter("class_id");

  if (request.getParameter("course_id") != null)
    course_id = (String) request.getParameter("course_id");

  if (request.getParameter("course_name") != null)
    course_name = (String) request.getParameter("course_name");

  list = userDAO.wishInfo(userID);
  if (list != null) listsz = list.size();
%>
<button id="student_main" type="button" onclick="location.href='student_main.jsp';"> 학생 정보 </button>
<button id="student_sugang" type="button" onclick="location.href='student_sugang.jsp';"> 수강 신청 </button>
<button id="student_wishlist" type="button" onclick="location.href='student_wishlist.jsp';"> 희망 내역 </button>
<button id="student_courselist" type="button" onclick="location.href='student_courselist.jsp';"> 신청 내역 </button>
<button id="student_grade" type="button" onclick="location.href='student_grade.jsp';"> 금학기 학점조회 </button>
<h2> 희망 내역 </h2> <h3> 이름 <%=name%> <%=credit%>학점 / 18학점</h3>

<div>
  <b>(<%=listsz%> 개의 강의)</b>

  <table>
    <tr>
      <th>수업번호</th>
      <th>학수번호</th>
      <th>교과목명</th>
      <th>교강사 이름</th>
      <th>수업시간</th>
      <th>신청인원/수강정원</th>
      <th>강의실</th>
      <th>수강신청</th>
      <th>희망취소</th>
    </tr>
    <%
      if (listsz != 0) {
        for (UserDAO._ClassInfo _class : list) {
          out.println("<tr>");
          out.println("<td>" + _class.classNo + "</td>");
          out.println("<td>" + _class.courseId + "</td>");
          out.println("<td>" + _class.courseName + "</td>");
          out.println("<td>" + _class.lecturer + "</td>");
          out.println("<td>");
          for (int i=0; i<_class.day.length; i++) {
            if (_class.day[i] == null){
              out.println("(온라인)"); break;
            }
            out.println(_class.day[i] + " " + _class.begin[i] + " ~ " + _class.end[i]);
          }
          out.println("</td>");
          out.println("<td>" + _class.per_no + " / " + _class.per_max + "</td>");
          out.println("<td>");
          for (int i=0; i<_class.roomNum.length; i++) {
            if (_class.roomNum[i] == null){
              out.println("(온라인)"); break;
            }
            out.println(_class.bldg[i] + " " + _class.roomNum[i] + " 호 ");
          }
          out.println("</td>");
    %> <td><button id="<%=_class.classId%>" type="button" onclick="location.href='stusugang_app.jsp?classID=<%=_class.classId%>';"> 버튼 </button></td>
    <td><button id="<%=_class.classId+_class.classId%>" type="button" onclick="location.href='delwish.jsp?classID=<%=_class.classId%>';"> 버튼 </button></td><%
        }
      }
    %>

    <!-- Paging 처리 -->
    <tr>
      <td colspan="5" height="40">
        <%-- ${pageCode} --%>
      </td>
    </tr>
  </table>
</div>



</body>
</html>
