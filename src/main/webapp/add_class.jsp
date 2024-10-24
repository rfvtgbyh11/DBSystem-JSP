<%@ page import="java.util.List" %>
<%@ page import="user.UserDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<button id="admin_main" type="button" onclick="location.href='logout_action.jsp';"> 로그아웃 </button>
<%
    List<UserDAO.LecturerInfo> listLec = null;
    List<UserDAO.RoomInfo> listRoom = null;
    String lecName = null, lecId = null;
    String bldgName = null, roomId = null, roomNum = null;
    String[] days = {"월", "화", "수", "목", "금", "토"};
    String temp = null;

    UserDAO userDAO = new UserDAO();

    if (session.getAttribute("userID") == null) response.sendRedirect("index.jsp");

    request.setCharacterEncoding("UTF-8");

    listLec = userDAO.getLecInfo();
    listRoom = userDAO.getRoomInfo();

%>
<button id="studentInfo" type="button" onclick="location.href='admin_main.jsp';"> 학생 정보 조회 </button>
<button id="classInfo" type="button" onclick="location.href='admin_course.jsp';"> 과목 정보 조회</button>
<form name="addC" action="add_class_action.jsp" method="post">
    수업번호 <input type="text" name="class_no">
    학수번호 <input type="text" name="course_id">
    수강인원 <input type="text" name="person_max">
    강사이름 <select name = "lecturer_id">
      <%
          for (UserDAO.LecturerInfo line : listLec){
              lecName = line.name; lecId = line.lecturer_id;
              %> <option value="<%=lecId%>"><%=lecName%></option> <%
          }
      %>
</select>
        시간 1<select name = "prd1_day">
          <%
              for (String day : days){
                  temp = day;
          %> <option value="<%=temp%>"><%=temp%></option> <%
          }
      %>
        </select>
        (00:00 으로 입력) <input type="text" name="prd1_begin"> ~ <input type="text" name="prd1_end">

        강의실 <select name = "prd1_room">
          <%
                for (UserDAO.RoomInfo line : listRoom){
                bldgName = line.building_name; roomNum = line.room_num; roomId = line.room_id;
          %> <option value="<%=roomId%>"><%=bldgName + " " + roomNum + "호"%></option> <%
        }
        %>
      </select>
          시간 2<select name = "prd2_day">
          <%
              for (String day : days){
                  temp = day;
          %> <option value="<%=temp%>"><%=temp%></option> <%
              }
          %>
          </select>
        (00:00 으로 입력) <input type="text" name="prd2_begin"> ~ <input type="text" name="prd2_end">

        강의실 <select name = "prd2_room">
          <%
                for (UserDAO.RoomInfo line : listRoom){
                bldgName = line.building_name; roomNum = line.room_num; roomId = line.room_id;
          %> <option value="<%=roomId%>"><%=bldgName + " " + roomNum + "호"%></option> <%
        }
        %>
        </select>
              <input type="submit" value="등록">

</form>
</body>
</html>
