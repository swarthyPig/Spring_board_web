<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Registration Page</title>
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
<body class="hold-transition register-page">
<div class="register-box">
  <div class="register-logo">
    <b>Registration</b>
  </div>

  <div class="card">
    <div class="card-body register-card-body">
      <p class="login-box-msg">Register a new membership<a href="/board/list"><br/> return to list page.</a></p>

      <form id="memberForm" action="/memberRegister" method="post">
        <div class="input-group mb-3">
          <input type="text" class="form-control" name='userName' placeholder="Name" value='' autofocus>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-user"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
          <input type="text" class="form-control" name='userid' placeholder="ID" value=''>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-address-card"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
          <input type="password" class="form-control" name='userpw' placeholder="Password" value=''>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
          <input type="password" class="form-control" name='retypeUserpw' placeholder="Retype password" value=''>
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col">
            <button type="submit" class="btn btn-primary float-right">Register</button>
          </div>
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          <input type="hidden" name="auth" value="ROLE_USER" />
          <!-- /.col -->
        </div>
      </form>
    </div>
    <!-- /.form-box -->
  </div><!-- /.card -->
</div>
<!-- /.register-box -->

<!-- jQuery -->
<script src="/resources/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="/resources/dist/js/adminlte.min.js"></script>
<!-- SweetAlert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	var memberForm = $("#memberForm");
	
	$(".btn-primary").on("click",function(e){
		e.preventDefault();
		
		if(!memberForm.find("input[name='userName']").val()){ 
			swal ( "Oops" ,  "이름을 입력해 주세요!!" ,  "error" );
			return false;
		}
		
		if(!memberForm.find("input[name='userid']").val()){ 
			swal ( "Oops" ,  "아이디를 입력해 주세요!!" ,  "error" );
			return false;
		}
		
		if(!memberForm.find("input[name='userpw']").val()){ 
			swal ( "Oops" ,  "패스워드를 입력해 주세요!!" ,  "error" );
			return false;
		}
		
		if(!memberForm.find("input[name='retypeUserpw']").val()){
			swal ( "Oops" ,  "패스워드를 한번 더 입력해 주세요!!" ,  "error" );
			return false;
		}
		
		if(memberForm.find("input[name='userpw']").val() != memberForm.find("input[name='retypeUserpw']").val()){
			swal ( "Oops" ,  "패스워드가 같지 않습니다!!" ,  "error" );
			return false;
		}

		swal ({ 
				title : "Success",
				text : "회원가입이 완료되었습니다!!",
				icon : "success" 
			 }).then((value) => {
  		  if(value){
  			memberForm.submit();
  		  } 
  		}); 	
	});
});
</script>
</body>
</html>
