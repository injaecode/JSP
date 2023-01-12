/*Oracle XE DataBase에서 Table 생성*/
Create Table guestlab{
	idx varchar2(200) primary key,
	ename varchar2(200),
	gender varchar2(200),
	adder varchar2(200)
	);
	
/* 1.WEB-INF\lib 라이브러리에 삽입해야함
 * 2.Oracle DB연결 설정
 * 3.폼페이지 생성해야함 guestlab_write.html
 * 4.form에서 action을 처리하는 페이지 생성 guestlab_save.jsp
 * 	 폼에서 넣는 값을 받아서 DB에 저장하는 페이지
 * 
 */