<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ include file ="conn_oracle.jsp" %>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//form에서 넘겨주는 변수를 받아서 새로운 변수에 담기
	String na=request.getParameter("name");
	String em=request.getParameter("email");
	String sub=request.getParameter("subject");
	String cont=request.getParameter("content");
	String pw=request.getParameter("password");
	//답변글을 처리하기위한 변수 3개
	int mid=Integer.parseInt(request.getParameter("mid"));
		//DB: masterid
	int rnum=Integer.parseInt(request.getParameter("rnum"));
		//DB:replynum: 동일 글의 그룹핑
		// 원본 글 + 답변 글일때 마스터아이디 동일
	int step=Integer.parseInt(request.getParameter("step"));
		//DB:step	글의 깊이를 처리하는 컬럼
		//원본 글:0 / 답변:1/ 2차 답변:2...
	//DB의 id 컬럼 최대값+1을 가져와서 저장 
	int id;
	
	//날짜를 한국 포맷에 맞도록 변환해서 저장
	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:m a");
	String ymd=myformat.format(yymmdd);
	//폼에서 넘어온 변수가 잘 들어오는지 출력
	/*out.println(na+"<p/>");
	out.println(em+"<p/>");
	out.println(sub+"<p/>");
	out.println(cont+"<p/>");
	out.println(pw+"<p/>");
	out.println(mid+"<p/>");
	out.println(rnum+"<p/>");
	out.println(step+"<p/>");
	out.println(yymmdd+"<p/>");
	if (true) return;*/
	
	//DB에 저장할 쿼리
	String sql=null;
	Statement stmt=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	
	//글을 넣기 위해 DB에 id의 max 값을 가져온 후 +1로 처리
	sql="select max(id) from freeboard";
	stmt=conn.createStatement();
	rs=stmt.executeQuery(sql);
	
	if(!(rs.next())){ 	//테이블에 저장된 값(원본글)이 없다
		id=1;		
	}else{	//레코드가 존재할 때 (최대값을 가지고 옴)
		id=rs.getInt(1)+1;
		
	}
	//out.println(id);
	//답변 글이므로 step값을 +1
	step+=1; //step=step+1;
	if(step==1){
		sql="select max(replynum) from freeboard where masterid = "+mid;
		rs=stmt.executeQuery(sql);
		if (!(rs.next())){
			rnum=1;
		}else{
			rnum=rs.getInt(1)+1;
		}
	}
	//preparedStatement 객체로 처리
	sql="insert into freeboard (id, name, password, ";
	sql+="email, subject, content, inputdate, masterid, ";
	sql+="readcount, replynum, step) ";
	sql+="values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?";

	//preparedStatement 객체 생성
	pstmt=conn.prepareStatement(sql);
	
	//pstmt에 ?변수 값을 넣음
	pstmt.setInt(1,id);
	pstmt.setString(2,na);
	pstmt.setString(3,pw);
	pstmt.setString(4,em);
	pstmt.setString(5,sub);
	pstmt.setString(6,cont);
	pstmt.setString(7,ymd);
	pstmt.setInt(8,mid);
	pstmt.setInt(9,0);
	pstmt.setInt(10,rnum);
	pstmt.setInt(11,step);

	
	//pstmt실행
	//out.println(sql);
	int result=0;	//0: insert 실패 , 1: insert 성공
	result=pstmt.executeUpdate();
	
	/*
	if(result>=1){
		out.println("DB에 잘 입력되었습니다.");
	}else{
		out.println("입력 실패");
	}
	*/
	
	
	

	
	//DB에 저장 후 freeboard_list03으로 이동, go변수에 페이지 값을 넣기
	//response.sendRedirect("freeboard_list03.jsp?go="+request.getParameter("page"));
%>
</body>
</html>