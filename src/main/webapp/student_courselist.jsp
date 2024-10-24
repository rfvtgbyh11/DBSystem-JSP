<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.util.List" %>
<html>
<head>
  <title>Title</title>
  <style>
    table, th, td {
      border: 1px solid black;
      border-collapse: collapse;
      text-align: center;
      width : 100px;
      height: 40px;
    }
    th, td {
      padding: 20px;
    }
    th {
      text-align: center;
    }
  </style>
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

  list = userDAO.courseInfo(userID);
  if (list != null) listsz = list.size();
%>
<button id="student_main" type="button" onclick="location.href='student_main.jsp';"> 학생 정보 </button>
<button id="student_sugang" type="button" onclick="location.href='student_sugang.jsp';"> 수강 신청 </button>
<button id="student_wishlist" type="button" onclick="location.href='student_wishlist.jsp';"> 희망 내역 </button>
<button id="student_courselist" type="button" onclick="location.href='student_courselist.jsp';"> 신청 내역 </button>
<button id="student_grade" type="button" onclick="location.href='student_grade.jsp';"> 금학기 학점조회 </button>
<h2> 신청 내역 </h2> <h3> 이름 <%=name%> <%=credit%>학점 / 18학점</h3>

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
      <th>재수강</th>
      <th>수강취소</th>
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
          out.println("<td>");
          out.println(userDAO.getGrade(userID, _class.classId));
          out.println("</td>");
    %> <td><button id="<%=_class.classId+_class.classId%>" type="button" onclick="location.href='delcourse.jsp?classID=<%=_class.classId%>';"> 버튼 </button></td><%
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

  <table style="width:100%">

    <tr>
      <th> </th>
      <th>월</th>
      <th>화</th>
      <th>수</th>
      <th>목</th>
      <th>금</th>
      <th>토</th>
    </tr>
    <%
      String[] weeks = {"월", "화", "수", "목", "금"};
      String[] tempstr = new String[2];

      int[][] n = new int[5][60];

      for (int i = 8; i<20; i++)
        for (int j = 0; j<60; j += 30) {
          out.println("<tr>");
          out.println("<th>"+String.valueOf(i)+":"+String.valueOf(j+100).substring(1)+"</th>");
          for (int k = 0; k<5; k++){
            if (n[k][i*2+j/30] == 1) continue;
            tempstr = userDAO.timeFind(list, weeks[k], i, j);
            if (tempstr == null || i >= 18) out.println("<td> </td>");
            else {
              for (int l = 0; l<Integer.parseInt(tempstr[0]); l++) n[k][i*2+j/30+l] = 1;
              out.println("<td style = \"background : LavenderBlush ;\"rowspan=\"" + tempstr[0] + "\">" + tempstr[1] + "</td>");
            }
          }
          out.println("</tr>");
        }
    %>

  </table>
</div>



</body>
</html>
