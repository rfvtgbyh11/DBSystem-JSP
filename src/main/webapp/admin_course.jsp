<%@ page import="user.UserDAO" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: hyunsu
  Date: 11/13/2022
  Time: 10:34 PM
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
    String userID = null;
    String class_id = null;
    String course_id = null;
    String course_name = null;
    List<UserDAO._ClassInfo> list = null;
    List<String> temp = null;
    int listsz = 0;

    UserDAO userDAO = new UserDAO();

    if (session.getAttribute("userID") != null)
        userID = (String) session.getAttribute("userID");
    else response.sendRedirect("index.jsp");

    request.setCharacterEncoding("UTF-8");

    if (request.getParameter("class_id") != null)
        class_id = (String) request.getParameter("class_id");

    if (request.getParameter("course_id") != null)
        course_id = (String) request.getParameter("course_id");

    if (request.getParameter("course_name") != null)
        course_name = (String) request.getParameter("course_name");

    if (class_id != null || course_id != null || course_name != null){
        list = userDAO._classInfo(class_id, course_id, course_name);
    } else list = userDAO._classInfo("", "", "");

    if (list != null) listsz = list.size();
%>
<button id="studentInfo" type="button" onclick="location.href='admin_main.jsp';"> 학생 정보 조회 </button>
<button id="classInfo" type="button" onclick="location.href='admin_course.jsp';"> 과목 정보 조회</button>
<h2>과목 조회</h2>
<form name="findC" action="admin_course.jsp" method="post">
    수업번호 <input type="text" name="class_id">
    학수번호 <input type="text" name="course_id">
    교과목명 <input type="text" name="course_name">
    <input type="submit" value="검색">
</form>

<button id = <%=userID%>, type="button" onclick = "location.href='add_class.jsp';"> 과목추가 </button>
<button id = "OLAP", type="button" onclick = "location.href='olap.jsp';"> 통계 </button>

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
            <th>수정</th>
            <th>삭제</th>
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
        %> <td><button id="<%=_class.classId%>" type="button" onclick="location.href='update_class.jsp?class_id=<%=_class.classId%>';"> 버튼 </button></td>
        <td><button id="<%=_class.classId%>" type="button" onclick="location.href='delete_class.jsp?class_id=<%=_class.classId%>';"> 버튼 </button></td><%
                out.println("</tr>");
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
