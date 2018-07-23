<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<input type="button" value="test" onclick="play()" />
</html>

<script>
          function play() {
          <%
          StringBuilder builder = new StringBuilder();
          Process process = Runtime.getRuntime().exec("ps -ef");
          try {
          process.wait();
          } catch (InterruptedException e) {
                e.printStackTrace();
          }
          BufferedReader pReader = new BufferedReader(new InputStreamReader(process.getInputStream()));
          String data = null;
          while((data=pReader.readLine())!=null){
               builder.append(line);
          }
          String result = builder.toString();
          System.out.print(result);
          %>
	}
</script>

