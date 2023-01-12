<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <!-- 필요한 라이브러리 등록 -->
    <%@ page import = "java.sql.* , java.util.*" %>
    
    <!-- DB의 값을 select해서 해당 값을 출력 -->
    <%@ include file="conn_oracle.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록의 내용을 DB에서 가져와 출력하는 페이지</title>

<link href="filegb.css" rel="stylesheet" type="text/css">

<style>
	div{width:600px; margin:0 auto;
	}
	table, tr, td{
	padding : 5px;
	border-collapse:collapse;}
</style>

</head>
<body>
show02.jsp입니다 <p/>


<!-- database에서 select한 결과를 담는 변수 선언:컬렉션 = 방이 자동 증가 -->
<% 
//컬렉션 : 방의 크기를 자동으로 늘려준다
//list: 인터페이스를 구현한 객체 ArrayList(싱글쓰레드), Vector(멀티쓰레드)
	Vector name=new Vector();	//db테이블에서 name컬럼 값만 담는 변수
	Vector email=new Vector();
	Vector inputdate=new Vector();
	Vector subject=new Vector();
	Vector content=new Vector();

	//사용할 변수 선언
	String sql=null;		//SQL 쿼리를 담는 변수
	Statement stmt=null;	//DBMS에 sql 쿼리를 보내는 객체
	ResultSet rs=null;		//select한 결과 레코드 셋을 담은 객체
	
	//sql 쿼리를 변수에 할당
	sql="select * from guestboard order by inputdate desc";
	
	//Connection (conn) 객체를 사용해서 Statement 객체를 생성
	stmt = conn.createStatement();
	
	//stmt 객체를 실행
	//rs: select한 결과 레코드를 담은 객체
	rs= stmt.executeQuery(sql);
	
	if(rs.next()){
		do{
			name.addElement(rs.getString("name"));
			email.addElement(rs.getString("email"));
			inputdate.addElement(rs.getString("inputdate"));
			subject.addElement(rs.getString("subject"));
			content.addElement(rs.getString("content"));
		}while(rs.next());
	}
	//rs에 담긴 값을 루프 돌리면서 출력
		//rs.next(); 커서의 위치를 다음 레코드로 이동
			//레코드가 존재하면 rs.next : true
			//레코드의 값이 존재 하지 않으면 : false
	
			//벡터에 저장된 값을 for문을 사용해서 출력
				//컬렉션에서 방의 갯수 : arrayList, vector
				//name.size(): 방의 개수
			
			for(int i=0;i<name.size();i++){
		

%>
<!--  rs에 담긴 값을 출력할 테이블 생성 
		rs.getString("컬럼명")-->
<div>
	<table width="600px" border="1px">
		<tr>
			<td colspan="2" align="center">
				<h3> <%= subject.elementAt(i) %></h3>	
			</td>
		
		</tr>
		<tr>
			<td> 글쓴이 : <%= name.elementAt(i) %>	</td>
			<td> E-mail :  <%= email.elementAt(i) %></td>
		</tr>
		<tr>
			<td colspan="2"> 출력일자 : <%= inputdate.elementAt(i) %>	</td>
		</tr>
		<tr>
			<td colspan="2" width="600px"> <%= content.elementAt(i) %> </td>
		</tr>
	</table>
	
	<p/> 
</div>
<%
			}
%>
<div>
	<a href="dbgb_write.html"><img src="images/write.gif" width="100px"></a>
</div>
</body>
</html>