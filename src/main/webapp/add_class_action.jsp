<%@ page import="user.UserDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<%
  String class_no = null, course_id = null, person_max = null, lecturer_id = null;
  String prd1_day = null, prd1_begin = null, prd1_end = null, prd1_room = null;
  String prd2_day = null, prd2_begin = null, prd2_end = null, prd2_room = null;
  int ret = -1;

  UserDAO userDAO = new UserDAO();
  PrintWriter script = response.getWriter();

  if (session.getAttribute("userID") == null) response.sendRedirect("index.jsp");

  request.setCharacterEncoding("UTF-8");
  class_no = request.getParameter("class_no");
  course_id = request.getParameter("course_id");
  person_max = request.getParameter("person_max");
  lecturer_id = request.getParameter("lecturer_id");
  prd1_day = request.getParameter("prd1_day");
  prd1_begin = request.getParameter("prd1_begin");
  prd1_end = request.getParameter("prd1_end");
  prd1_room = request.getParameter("prd1_room");
  prd2_day = request.getParameter("prd2_day");
  prd2_begin = request.getParameter("prd2_begin");
  prd2_end = request.getParameter("prd2_end");
  prd2_room = request.getParameter("prd2_room");

  if (class_no.equals("") || course_id.equals("") || person_max.equals("") || lecturer_id.equals("") || prd1_day.equals("") || (!prd1_day.equals("온라인") && (prd1_begin.equals("") || prd1_end.equals("") || prd1_room.equals(""))) || prd2_day.equals("") || (!prd2_day.equals("온라인") && (prd2_begin.equals("") || prd2_end.equals("") || prd2_room.equals("")))) {
    script.println("<script>");
    script.println("alert('입력이 안된 항목이 있습니다.')");
    script.println("location.href='add_class.jsp';");
    script.println("</script>");
    script.close();
  }
  ret = userDAO.addClass(class_no, course_id, person_max, lecturer_id, prd1_day, prd1_begin, prd1_end, prd1_room, prd2_day, prd2_begin, prd2_end, prd2_room);

  if (ret == 0){
    script.println("<script>");
    script.println("alert('과목이 추가되었습니다.')");
    script.println("location.href='admin_course.jsp';");
    script.println("</script>");
  }
  else if (ret == 1){
    script.println("<script>");
    script.println("alert('최대인원은 강의실 용량을 넘을수 없습니다.')");
    script.println("location.href='admin_course.jsp';");
    script.println("</script>");
  }
  else if (ret == 2){
    script.println("<script>");
    script.println("alert('존재하지 않는 학수번호입니다.')");
    script.println("location.href='admin_course.jsp';");
    script.println("</script>");
  }
  else {
    script.println("<script>");
    script.println("alert('에러가 발생하였습니다.')");
    script.println("location.href='admin_course.jsp';");
    script.println("</script>");
  }
%>
<body>

</body>
</html>
