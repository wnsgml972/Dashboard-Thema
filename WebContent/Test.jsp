<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<input type="button" value ="test" onclick="play()" />

</html>

<script>
	function play() {

		<%
		System.out.println("실행함?");
			final String path = "C:\\mostemp\\mosquitto-1.4.14\\build\\client\\Debug\\mosquitto_pub.exe";
			String command[] = { path, "-t", "topic", "-m", "publish"};
			ProcessBuilder builder = new ProcessBuilder(command);
			builder.redirectError();
			builder.redirectInput(ProcessBuilder.Redirect.INHERIT);
			builder.redirectOutput(ProcessBuilder.Redirect.INHERIT);			
			try {
				Process process = builder.start();
				process.waitFor();
			} catch (Exception e) {
				e.printStackTrace();
			}
			System.out.println("끝남");
		%>
		alert("111");
	}
</script>