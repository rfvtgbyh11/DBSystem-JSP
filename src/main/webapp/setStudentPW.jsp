<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="EUC-KR">
  <title></title>
</head>
<body>
<form action="setStudentPWAction.jsp" method="post">
  기존 비밀번호 :<input type="text" name="oldPW">
  새 비밀번호 : <input type="password" name="newPW">
  <input type="submit" value="변경">
</form>
</body>
</html>