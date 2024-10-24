<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<button id="studentInfo" type="button" onclick="location.href='admin_main.jsp';"> 학생 정보 조회 </button>
<button id="classInfo" type="button" onclick="location.href='admin_course.jsp';"> 과목 정보 조회</button>
<h2>학생 정보 조회</h2>
<%
  UserDAO userDAO = new UserDAO();
  List<UserDAO._ClassInfo> listPrev = null;
  List<UserDAO._ClassInfo> list = null;
  String stuID = null;
  String userID = null;

  if (session.getAttribute("userID") != null) {
    userID = (String) session.getAttribute("userID");
  } else {
    response.sendRedirect("index.jsp");
  }

  if (request.getParameter("stuID") != null) {
    stuID = (String) request.getParameter("stuID");
    listPrev = userDAO.courseInfo_1(stuID, true);
    list = userDAO.courseInfo(stuID);
  } else {
    response.sendRedirect("admin_main.jsp");
  }


%>
<table>
  <tr>
    <th>수업번호</th>
    <th>학수번호</th>
    <th>교과목명</th>
    <th>교강사 이름</th>
    <th>학점</th>
  </tr>
  <%
    float sum = 0, grade = 0;
    int idx = 0;
    for (UserDAO._ClassInfo line: listPrev){
      idx++;
      grade = Float.parseFloat(userDAO.getGrade(stuID, line.classId)); sum += grade;
      out.println("<tr>");
      out.println("<td>" + line.classNo + "</td>");
      out.println("<td>" + line.courseId + "</td>");
      out.println("<td>" + line.courseName + "</td>");
      out.println("<td>" + line.lecturer + "</td>");
      out.println("<td>");
      out.println(grade);
      out.println("</td>");
    }
    out.println("학점 평균 : ");
    out.println(sum/idx);
    System.out.println(stuID);
  %>
</table>

<form action="setStudentSTActionAD.jsp" method="post">
  <select name = "status">
    <option value="재학">재학</option>
    <option value="휴학">휴학</option>
    <option value="자퇴">자퇴</option>
  </select>
  <select name = "stuID">
    <option value="<%=stuID%>"></option>
  </select>
  <input type="submit" value="변경">
</form>

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

    for (int i = 8; i<20; i++)
      for (int j = 0; j<60; j += 30) {
        out.println("<tr>");
        out.println("<th>"+String.valueOf(i)+":"+String.valueOf(j+100).substring(1)+"</th>");
        for (int k = 0; k<5; k++){
          tempstr = userDAO.timeFind(list, weeks[k], i, j);
          if (tempstr == null || i >= 18) out.println("<td> </td>");
          else out.println("<td style = \"background : LavenderBlush ;\"rowspan=\""+tempstr[0]+"\">"+tempstr[1]+"</td>");
        }
        out.println("</tr>");
      }
  %>

</table>

</script>



</body>
</html>