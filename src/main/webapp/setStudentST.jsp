<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="EUC-KR">
  <title></title>
</head>
<body>
<form action="setStudentSTAction.jsp" method="post">
  비밀번호 확인 : <input type="text" name="PW">
  <select name = "status">
    <option value="재학">재학</option>
    <option value="휴학">휴학</option>
    <option value="자퇴">자퇴</option>
  </select>
  <input type="submit" value="변경">
</form>
</body>
</html>