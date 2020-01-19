<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Log in</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="/resources/plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- icheck bootstrap -->
  <link rel="stylesheet" href="/resources/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/resources/dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
</head>
<body class="hold-transition login-page">
<div class="login-box">
  <div class="login-logo">
    <b>Login</b>
  </div>
  <!-- /.login-logo -->
  <div class="card">
    <div class="card-body login-card-body">
      <p class="login-box-msg">Sign in to start your session
      		<a href="/board/list"><br/> 
      			return to list page
      			<a href="/memberRegister"><br/>
      				go to sign up page
      			</a>
      		</a>
      </p>

      <form id="loginForm" action="/login" method="post">
        <div class="input-group mb-3">
          <input type="text" class="form-control" name='username' placeholder="Id" value='' autofocus>
          <div class="input-group-append">
            <div class="input-group-text">
              <i class="fas fa-user"></i>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
          <input type="password" class="form-control" name='password' placeholder="Password" value=''>
          <div class="input-group-append">
            <div class="input-group-text">
              <i class="fas fa-lock"></i>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-8">
            <div class="icheck-primary">
              <input type="checkbox" id="remember" name="remember-me">
              <label for="remember">
                	자동 로그인
              </label>
            </div>
          </div>
          <!-- /.col -->
          <div class="col-4">
            <button type="submit" class="btn btn-primary btn-block">Sign In</button>
          </div>
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          <!-- /.col -->
        </div>
      </form>
    </div>
    <!-- /.login-card-body -->
  </div>
</div>
<!-- /.login-box -->

<!-- jQuery -->
<script src="/resources/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="/resources/dist/js/adminlte.min.js"></script>
<!-- SweetAlert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script type="text/javascript">

$(".btn-primary").on("click",function(e){
	
	e.preventDefault();
	
	var loginForm = $("#loginForm");
	
	if(!loginForm.find("input[name='username']").val()){ // id를 입력하지 않았을때
		swal ( "Oops" ,  "아이디를 입력해 주세요!!" ,  "error" );
		return false;
	}
	
	if(!loginForm.find("input[name='password']").val()){ // id를 입력하지 않았을때
		swal ( "Oops" ,  "비밀번호를 입력해 주세요!!" ,  "error" );
		return false;
	}
	
	$("form").submit(); 

});

</script>

<c:if test="${param.error != null}">
	<script>
      $(document).ready(function(){
    	  
    	  swal ( "Oops" ,  "로그인 실패!!" ,  "error" );
      });
    </script>
</c:if> 
    
<c:if test="${param.logout != null}">
	<script>
      $(document).ready(function(){
    	  
    	  swal ( "Success" ,  "로그아웃 되었습니다!!" ,  "success" ).then((value) => {
    		  if(value){
    			  location.href='/board/list';
    		  } 
    	}); 
      });
    </script>
</c:if>  


</body>
</html>