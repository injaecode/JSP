<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 사용할 클래스를 해당 패키지에서 import  -->
<%@ page import ="java.sql.*, java.util.*" %>
<!-- 클라이언트에서 유니코드를 UTF-8로 처리해야함 (MVC Model 1) -->
<!-- JSP에서 내장객체 : import없이 사용가능한 객체
	request 객체 : 클라이언트에서 넘겨주는 정보를 서버에서 받아서 처리,
	response 객체 : 서버에서 클라이언트에게 정보를 처리하는 객체 -->
<% request.setCharacterEncoding("UTF-8"); %>
<!-- DB접속 파일을 include해서 사용 -->
<%@ include file="conn_MSSQL.jsp" %>

<!-- 폼에서 넘겨주는 변수와 값을 받아서 저장: request.getParameter("변수명); -->
<% 
 	String na=request.getParameter("name");
	String em=request.getParameter("email");
 	String sub=request.getParameter("subject");
 	String con=request.getParameter("content");
 	String ymd=(new java.util.Date()).toLocaleString();
 	
%>

<!-- 폼에서 넘긴 변수를 출력 후 주석처리 -->
<% //out.println("na 변수의 값 = "+na+"<p/>" ); 
 	//out.println("em 변수의 값 = "+em+"<p/>" ); 
	//out.println("sub 변수의 값 = "+sub+"<p/>" ); 
 	//out.println("con 변수의 값 = "+con+"<p/>" ); 
 	//out.println("ymd 변수에 담긴 값 = "+ymd+"<p/>");
  %>
  <%= "na변수에 담긴 값 : "+na+"<p/>" %>
  <!-- 변수에 넘어오는 값을 SQL 쿼리에 담아 DB에 저장 -->
  <% String sql=null;	//sql = SQL 쿼리를 담는 변수
	Statement stmt=null;	//SQL 쿼리를 DB에 적용하는 객체
	
	//connection 객체에 conn.createStatement(); 메소드를 사용, stmt 객체에 할당
	
	stmt=conn.createStatement();
	
	try{
	sql="insert into guestboard (name,email,inputdate,subject,content) ";
  	sql=sql+"values('"+na+"', '"+em+"', '"+ymd+"','"+sub+"','"+con+"')";
  	
    //out.println(sql);
   // int cnt=0; //sql 쿼리가 잘처리되었는지 확인 변수
   //cnt=stmt.executeUpdate(sql); 	 //Statement객체의 excuteUpdate(sql):insert, update, delete
    stmt.executeQuery(sql); 	 //Statement객체의 excuteQuery(sql):select
    							 //Recordset 객체로 리턴시켜줌
    
    //statement객체나 preparedStatement 객체를 사용해서 insert/update/delete
    //저장할 경우 commit은 자동으로 처리됨
    
    //out.println(cnt);
    //if(cnt>0){
    //	out.println("DB에 잘 입력되었습니다.");
    //}else{
    //	out.println("DB에 저장 실패했습니다.");
    //}
	}catch (Exception e){
		out.println ("DataBase Insert 중 문제가 발생 되었습니다. <p/>"); 
		out.println ("고객센터 : 02-1111-1111 로 문의 바랍니다"); 
		e.printStackTrace();
	}finally{
		//사용한 객체를 close()// connction, statment 객체 메모리에서 제거
		if(conn !=null){
			conn.close();
		}
		if (stmt !=null){
			stmt.close();
		}
	}
  	
  	%>
//dbgb_save.jsp: 폼에서 받은 값을 DB에 저장하면 출력페이지로 이동

<% response.sendRedirect("freeboard_list.jsp"); %>
<!-- <jsp:forward page="dbgb_show.jsp"/> -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기의 폼의 변수의 값을 받아서 DB에 저장후 보기 페이지로 이동</title>
</head>
<body>

</body>
</html>