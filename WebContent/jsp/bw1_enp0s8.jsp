<%@ page language="java" import= "java.io.*, java.util.*"  
   contentType="text/html;charset=EUC-KR" session="false" %>
<html>
<%
        String path = "/home/user/tomcat8/webapps/ROOT/dashboard/etri-jsp-sh/bw1.sh";
        String bashCommand[] = {"ls", "-al"}; // bash 명령어
        String scriptCommand[] = {"sh", path, "enp0s8"}; //shell script 실행

    int lineCount = 0;
    String line="";

    ProcessBuilder builder = new ProcessBuilder(scriptCommand);
    Process childProcess = null;

    try{
        childProcess = builder.start();

      BufferedReader br =
            new BufferedReader(
                    new InputStreamReader(
                          new SequenceInputStream(childProcess.getInputStream(), childProcess.getErrorStream())));
      while((line = br.readLine()) != null){
        line = line.replaceAll(" ", "");
        line = line.replaceAll("<html>", "");
        line = line.replaceAll("</html>","");

%>
    <%=line%> 
<%
      }
      br.close();

   }catch(IOException ie){
      ie.printStackTrace();
   }catch(Exception e){
      e.printStackTrace();
   }
%>
</html>
