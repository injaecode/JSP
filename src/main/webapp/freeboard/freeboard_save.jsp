<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 필요한 라이브러리 import -->
<%@ page import = "java.sql.*, java.util.*,java.text.*" %>
<!-- DB include -->
<%@ include file="conn_oracle.jsp" %>
<!--  form에서 넘어오는 데이터는 모두 string으로 넘긴다 
Integer.perseInt()
-->

<!-- form에서 넘어오는 변수의 값을 받아서 새로운 변수에 할당 -->

<% 
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String sub = request.getParameter("subject");
	String cont = request.getParameter("content");
	String pw = request.getParameter("password");
	
	int id =1;
	
	//날짜 처리
	java.util.Date yymmdd = new java.util.Date();
	//out.println(yymmdd);
	SimpleDateFormat myformat = new SimpleDateFormat("yy-mm-d h:m a");
	String ymd=myformat.format(yymmdd);
	
	//DB에 값을 처리할 변수 선언 : Connection -->include 되어있음
	String sql=null;
	Statement stmt=null;
	ResultSet rs=null;	//id 컬럼의 최대값을 select
	
	try{
	//DB에서 값을 처리
	stmt=conn.createStatement();
	sql="select max(id) as id from freeboard"; //id:primary key
	
	rs=stmt.executeQuery(sql);
//	rs.next();
	
//	out.println(rs.getString(id)+"<p/>");
	
	
	//테이블의 id컬럼 값을 적용 :최대값을 가져와서 +1
	if(!(rs.next())){	//테이블에 값이 존재하지 않는 경우
		id=1;
	}else{				//테이블에 값이 존재하는 경우
		id=rs.getInt(1)+1;
	}
	
	//Statement 객체는 변수값을 처리하는 것이 복잡함. PreparedStatement를 사용한다.
	//폼에서 넘겨받은 값을 DB에 insert하는 쿼리 (주의:masterID: id컬럼에 들어오는 값으로 처리해야함)
	sql="insert into freeboard(id, name, password, email, "; 
	sql+="subject, content, inputdate, masterid, readcount, replynum, step) ";
	sql+="values ("+id+", '"+na+"','"+pw+"','"+em+"','"+sub+"','"+cont+"','"+ymd+"', "+id+","+"0, 0, 0)";
	
	//out.println(sql);
	//if(true) return;	//프로그램 중지, 디버깅할때 사용함
	stmt.executeUpdate(sql); //DB 저장완료, commit을 자동으로 처리
	
	//try catch블락으로 프로그램이 종료되지 않도록 처리 후 객체 제거
	}catch (Exception e){
		out.println("예상치 못한 오류가 발생했습니다.<p/>");
		out.println("고객센터 : 02-1111-1111 <p/>");
		
	}finally{
		if(conn !=null) conn.close();
		if(stmt !=null) stmt.close();
		if(rs !=null) rs.close();
	}
%>
<!--  페이지이동: 
	response.sendRedirect: 클라이언트에서 페이지를 재요청 ->url주소 변경
	forward: 서버에서 페이지 이동 ->url 주소 변경안됨 -->

<% //response.sendRedirect("freeboard_list.jsp"); %>
<jsp:forward page="freeboard_list.jsp"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>