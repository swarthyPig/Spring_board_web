# Spring Simple Board Web Project

## 구성
- [개발 동기](#개발-동기)
- [개발 환경](#Environment)
- [구현 기능](#구현-기능)
- [결과 화면](#결과-화면)
- [향후 과제](#향후-과제)
- [참고 자료](#참고-자료)

## 개발 동기
Java로 게시판을 구현 해보면서 Spring Framework에 대한 사용법과 이해도 확립을 목표로 진행하게 되었습니다.

## Environment
항목 | 개발환경 
:---: | :---: 
OS | Windows10 
Language | Java 1.8 
Tool | Spring Tool Suite
Backend | Spring MVC
Frontend | Bootstrap(AdminLTE-3.0.1), jsp, jQuery
WAS | Tomcat 9
DB | Oracle Database 11g Express
ORM | Mybatis
Library | Lombok, HikariCP, spring-security, ajax

## 구현 기능

* 게시글
  - 게시글을 열람, 등록, 수정, 삭제를 할 수 있다.
  - 자신이 등록한 게시글이 아니면 수정, 삭제를 할 수 없다.
  - 게시글을 삭제할 시 등록 되어 있던 댓글 또한 같이 삭제된다.
  - (페이징 처리)한 페이지에 10개의 게시글을 볼 수 있으며, 페이지는 10페이지씩 열람 가능하다.
  - (검색 기능)6가지 옵션을 가지고 검색을 할 수 있다.
  - 검색 시 검색의 옵션과 내용, 검색 했던 페이지가 유지된다.
  
* 댓글(REST API)
  - 댓글을 열람, 등록, 수정, 삭제 할 수 있다.
  - 자신이 등록한 댓글이 아니면 수정, 삭제를 할 수 없다.
  - 한 페이지에 10개의 댓글을 볼 수 있으며, 댓글은 10페이지씩 열람 가능하다.
  - 댓글은 등록한 해당 일이 지나지 않으면 (시/분/초)로 표시되며 지났으면 (년/월/일)로 표시된다. 
  
* 로그인, 로그아웃, 회원가입
  - 회원가입을 하지 않은 사용자(로그인을 하지 않은 사용자)는 게시물과 댓글의 열람만 가능하다.
  - 로그인 한 사용자는 게시글 등록과 댓글 등록을 할 수 있다.
  - 사용자는 자동 로그인을 사용 할 수 있다(10분이 지나면 쿠기 삭제).
  - 관리자는 게시글을 임의로 삭제, 수정 할 수 있다.
  - 회원가입시 비밀번호는 bcrypt를 통해 암호화된다.

## 결과 화면

* 게시글
  - 게시글 리스트 열람
  ![list](/img/list.PNG)
  - 게시글과 댓글 열람
  ![get](/img/get.PNG)
  - 게시글 수정과 삭제
  ![modify_and_remove](/img/modify.PNG)

* 댓글
  - 댓글 등록
  ![replyRegister](/img/replyRegister.PNG)
  - 댓글 수정과 삭제
  ![replyModify](/img/replyModify.PNG)

* 회원가입 로그인
  - 회원가입
  ![signUp](/img/signUp.PNG)
  - 로그인
  ![login](/img/login.PNG)

* 데이터 베이스
  - DB 목록
  ![DB](/img/DB.PNG)


## 향후 과제
* 회원탈퇴
* 회원가입시 아이디 중복검사
* list 페이지에 조회수 추가

## 참고 자료
코드로 배우는 스프링 웹 프로젝트(개정판) - 구멍가게 코딩단
