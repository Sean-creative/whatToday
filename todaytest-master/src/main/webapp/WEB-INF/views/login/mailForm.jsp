<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ������</title>
</head>
<body>
<div class="container">
  <h4>���� ������</h4>
  <form action="/sendMail" method="post">
    <div align="center"><!-- �޴� ��� �̸��� -->
      <input type="text" name="tomail" size="120" style="width:100%" placeholder="����� �̸���" class="form-control" >
    </div>     
    <div align="center"><!-- ���� -->
      <input type="text" name="title" size="120" style="width:100%" placeholder="������ �Է����ּ���" class="form-control" >
    </div>
    <p>
    <div align="center"><!-- ���� --> 
      <textarea name="content" cols="120" rows="12" style="width:100%; resize:none" placeholder="����#" class="form-control"></textarea>
    </div>
    <p>
    <div align="center">
      <input type="submit" value="���� ������" class="btn btn-warning">
    </div>
  </form>
</div>
</body>
</html> 