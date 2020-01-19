<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp" %>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">Board Register</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
              
                <form id="registerForm" action="/board/register" method="post">
                	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                	
                	<div class="form-group">
                		<label>Title</label>
                		<input class="form-control" name='title' placeholder="title here">
                	</div>
                	<div class="form-group">
                		<label>Text</label>
                		<textarea class="form-control" rows="3" name='content' placeholder="text here"></textarea>
                	</div>
                	<div class="form-group">
                		<label>Writer</label>
                		<input class="form-control" name='writer' value='<sec:authentication property="principal.username"/>' readonly="readonly">
                	</div>
                	
                    <button id="submitBtn" type="submit" class="btn btn-primary">Submit</button>
                    <button type="reset" class="btn btn-default">Reset</button> 
                </form>
                
              </div>
              <!-- /.card-body -->
            </div>
        </div>
      </div>
      <!-- /.card -->
     </div><!-- /.container-fluid -->
   </section>
    <!-- /.content -->
    
<script type="text/javascript">
$(document).ready(function(){
	
	var registerForm = $("#registerForm");
	
	$("#registerForm #submitBtn").on("click", function(e){
		
		if(!registerForm.find("input[name='title']").val()){ // 제목을 입력하지 않았을 경우
			swal ( "Oops" ,  "제목을 입력해 주세요!!" ,  "error" );
			return false;
		}
		
		if(!registerForm.find("input[name='writer']").val()){ // 작성자를 입력하지 않았을 경우
			swal ( "Oops" ,  "작성자를 입력해 주세요!!" ,  "error" );
			return false;
		}

		e.preventDefault();
		
		registerForm.submit();
	
	});
});
</script>
 <%@include file="../includes/footer.jsp" %>