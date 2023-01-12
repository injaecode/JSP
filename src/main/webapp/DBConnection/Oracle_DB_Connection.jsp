<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%@ page import="java.sql.*" %>

<!-- 
java.sql.* 패키지 하위 모든 클래스 import
	Connection 객체 : Database(Oracle, MSSQL, MySQL...) 연결
	Statement 객체  : CRUD를 사용해서 Insert, Update, Delete
	PreparedStatement 객체 : Statement 객체의 업그레이드버전, 성능 개선, 간략한 구문
	ResultSet 객체 : DB에서 select한 결과를 저장하는 객체
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
		//변수 초기화 (//JSP 블락 내에서 주석)
		Connection conn =null;
		String driver="oracle.jdbc.driver.OracleDriver";
		String url="jdbc:oracle:thin:@localhost:1521:XE";
		Boolean connect = false;
		
		try{
			Class.forName(driver); //오라클 드라이버를 로드함
			conn=DriverManager.getConnection(url,"C##HR","1234");
			
			connect=true;
			conn.close();
		}catch (Exception e){
			connect=false;
			e.printStackTrace();
		}
		
		//조건을 사용 후 연결 시 잘 연결되었다고 확인 메시지가 출력됨
		if(connect==true){
			out.println("오라클 DB에 잘 연결되었습니다.");
			
		}else{
			out.println("오라클 DB 연결에 실패했습니다");
		}
	%>
</body>
</html>