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
                <h3 class="card-title">Board Modify</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
          		<form role="form" action="/board/modify" method="Post">
          		
          			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> <!-- 사용자의 url조작을 통한 접근 방지 -->
          			
          			<input type="hidden" name='pageNum' value='<c:out value="${pm.pageNum}"/>'>
          			<input type="hidden" name='amount' value='<c:out value="${pm.amount}"/>'>
          			<input type='hidden' name='searchType' value='<c:out value="${pm.searchType}"/>'>
					<input type='hidden' name='searchKeyword' value='<c:out value="${pm.searchKeyword}"/>'>
          			
          			<div class="form-group">
                	<label>Bno</label>
                	<input class="form-control" name='bno' value='<c:out value="${board.bno}"/>' readonly="readonly">
                	</div>
                	<div class="form-group">
                	<label>Title</label>
                	<input class="form-control" name='title' value='<c:out value="${board.title}"/>'>
                	</div>
                	<div class="form-group">
                	<label>Text</label>
                	<textarea class="form-control" rows="3" name='content'><c:out value="${board.content}"/></textarea>
                	</div>
                	<div class="form-group">
                	<label>Writer</label>
                	<input class="form-control" name='writer' value='<c:out value="${board.writer}"/>' readonly="readonly">
                	</div>
                	<div class="form-group">
                	<label>RegDate</label>
                	<input class="form-control" name='regDate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/>' readonly="readonly">
                	</div>
                	<div class="form-group">
                	<label>UpdateDate</label>
                	<input class="form-control" name='updateDate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}"/>' readonly="readonly">
                	</div>
                	
                	<sec:authentication property="principal" var="pinfo"/> <!-- 매번 쓰기 불편하므로 pinfo변수로 선언 -->
                	<sec:authorize access="isAuthenticated()"> <!-- 로그인한 사용자만 버튼이 보이게 -->
                		<c:if test="${pinfo.username eq board.writer}">
                			<button type="submit" data-oper="modify" class="btn btn-default">Modify</button>
                			<button type="submit" data-oper="remove" class="btn btn-danger">Remove</button>
                		</c:if>
                	</sec:authorize>
                	
                	<sec:authorize access="hasRole('ROLE_ADMIN')"> <!-- 관리자 권한 -->
                			<button type="submit" data-oper="modify" class="btn btn-default">Modify</button>
                			<button type="submit" data-oper="remove" class="btn btn-danger">Remove</button>
                	</sec:authorize>
                 
                	<button type="submit" data-oper="list" class="btn btn-primary">List</button> 
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
	
	var formObj = $("form");
	
	$('button').on("click", function(e){
		
		e.preventDefault(); // form태그의 모든 버튼은 submit으로 처리하기때문에 기본동작을 막고 따로 submit처리를 수행합니다.
		
		var operation = $(this).data("oper"); // html태그에서 클릭된 buttom의 data-"oper" 값을 가지고옴. 
		
		console.log(operation);
		
		if(operation === 'remove'){ // remove 버튼을 누르면 
			
			formObj.attr("action", "/board/remove"); // form의 action속성의 값을 remove페이지로 바꿔줌
			
		}else if(operation === 'list'){ // list 버튼을 누르면 
			
			formObj.attr("action", "/board/list").attr("method","get"); // modify로 들어오면 post가 되므로 list를 눌렀을 때 다시 get으로 바꿔준다
			
			// 수정 삭제 페이지에서 작업을 취소하고 list로 갈때 
			// form태그에서 필요한 부분만 잠시 복사
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var searchKeywordTag = $("input[name='searchKeyword']").clone();
			var searchTypeTag = $("input[name='searchType']").clone();
			
			formObj.empty(); // /board/list 로의 이동은 아무런 파라미터가 없기 때문에 form태그를 비워줍니다.
			// form태그 내용을 지운뒤 복사해놓은 페이지에 대한 정보를 추가해서 list로 이동
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(searchKeywordTag);
			formObj.append(searchTypeTag);
		}
		
		formObj.submit(); // 수정 후 modify버튼을 눌렀을때
	});
});

</script>
  
 <%@include file="../includes/footer.jsp" %>