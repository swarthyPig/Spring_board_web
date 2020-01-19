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
                <h3 class="card-title"><i class="fas fa-clipboard-list"></i>&nbsp; Board Read</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <div class="form-group">
                <label>Bno</label>
                <input class="form-control" name='bno' value='<c:out value="${board.bno}"/>' readonly="readonly">
                </div>
                <div class="form-group">
                <label>Title</label>
                <input class="form-control" name='title' value='<c:out value="${board.title}"/>' readonly="readonly">
                </div>
                <div class="form-group">
                <label>Text</label>
                <textarea class="form-control" rows="3" name='content' readonly="readonly"><c:out value="${board.content}"/></textarea>
                </div>
                <div class="form-group">
                <label>Writer</label>
                <input class="form-control" name='writer' value='<c:out value="${board.writer}"/>' readonly="readonly">
                </div>
                
                <sec:authentication property="principal" var="pinfo"/> <!-- 매번 쓰기 불편하므로 pinfo변수로 선언 -->
                
                <sec:authorize access="isAuthenticated()"> <!-- 로그인한 사용자면 버튼이 보이게 -->
                	<c:if test="${pinfo.username eq board.writer}">
                		<button data-oper="modify" class="btn btn-primary">Modify</button>
                	</c:if>
                </sec:authorize>
                
                <sec:authorize access="hasRole('ROLE_ADMIN')"> <!-- 관리자 권한-->
                	<button data-oper="modify" class="btn btn-primary">Modify</button>
                </sec:authorize>
                
                <button data-oper="list" class="btn btn-default">List</button>
                
                <form id='operForm' action="/board/modify" method="get">
                	<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'>
                	<input type="hidden" name="pageNum" value='<c:out value="${pm.pageNum}"/>'>
                	<input type="hidden" name="amount" value='<c:out value="${pm.amount}"/>'>
                	<input type='hidden' name='searchType' value='<c:out value="${pm.searchType}"/>'>
					<input type='hidden' name='searchKeyword' value='<c:out value="${pm.searchKeyword}"/>'>
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
    
<section class="content">
  <div class="container-fluid"> 
        <!-- Timelime example  -->
        <div class="row">
          <div class="col-12">
          <div class="card">
              <div class="card-header">
                <h3 class="card-title"><i class="fas fa-comment-dots"></i>&nbsp; Reply</h3>
                <sec:authorize access="isAuthenticated()"> <!-- 로그인한 사용자면 댓글 등록버튼이 보이게 -->
                	<button id="addReplyBtn" type="button" class="btn bg-gradient-success btn-xs float-right">
                		<i class="far fa-edit" style="font-size:15px;"></i>
                		댓글 등록
               		</button>
                </sec:authorize>
              </div>
            <!-- The time line -->
            <div class="timeline">
              <!-- timeline time label -->
              <div class="time-label"></div>
              
              <!-- timeline item -->
              <div class="chat">
                <i class="fas fa-comments bg-yellow"></i>
                <div class="timeline-item" data-rno = '1'>
                  <span class="time"><i class="fas fa-clock"></i> 2019-01-01 12:00</span>
                  <h3 class="timeline-header">admin</h3>
                  <div class="timeline-body">
                    test reply
                  </div>
                </div>
              </div>

              <!-- END timeline item -->

              <div>
                <i class="fas fa-clock bg-gray"></i>
              </div>
            </div>
            <!-- /.card-body -->
 			<div class="card-footer clearfix">
     				
 			</div> 
          </div>
          </div>
          <!-- /.col -->
        </div>
      </div>
      <!-- /.timeline -->
</section>

<!-- modal -->
<div class="modal fade" id="modal-default">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Modal Reply</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
        
         	<div class="form-group">
            <label>Reply</label>
            <input class="form-control" name='reply' value='reply'>
            </div>
            
            <div class="form-group">
            <label>Replyer</label>
            <input class="form-control" name='replyer' value='replyer' readonly="readonly">
            </div>
            
            <div class="form-group">
            <label>ReplyDate</label>
            <input class="form-control" name='replyDate' value=''>
            </div>
            
        </div>
        
        <div class="modal-footer">
            <button id='modalModBtn' type="button" class="btn btn-primary">Modify</button>
            <button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
            <button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
            <button id='modalCloseBtn' type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      <!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->
      
<script type="text/javascript" src="/resources/js/reply.js"></script>

<!-- 
<script>

console.log("=========== reply.js Test ===========");

var bnoValue = '<c:out value="${board.bno}"/>';

/*
// add test
replyService.add(
	{reply:"JS Test", replyer:"tester", bno:bnoValue},
	function(result){
		alert("result ->" + result);
	}
);
*/

/*
// getList test
replyService.getList({bno:bnoValue, page:1}, function(list){
	
	for(var i = 0, len = list.length||0; i<len; i++){ // list.length 값이 있으면 그값이 들어가고 없으면 0이들어간다
		console.log(list[i]);
	}
});
*/
/*
// remove test
replyService.remove(2, function(count){
	
	console.log(count);
	
	if(count === "success"){
		alert("삭제완료");
	}
}, function(err){
	alert('ERROR..');
});
*/
/*
// update test
replyService.update({
	rno : 3,
	bno : bnoValue,
	reply : "modify reply"
}, function(result){
	alert("수정완료");
});
*/
/*
// get test
replyService.get(10, function(data){
	console.log(data);
});
*/
</script>
-->

<script type="text/javascript">
$(document).ready(function(){
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");
	
	showList(1);
	
	function showList(page){
		
		console.log("show list:"+ page)
		
		replyService.getList({bno:bnoValue, page: page || 1}, function(replyCnt, list){ 
			
			console.log("replyCnt : " + replyCnt);
			console.log("list : " + list);
			
			if (page == -1){ // 페이지 번호가 -1이 전달되면
				pageNum = Math.ceil(replyCnt / 10.0);
				showList(pageNum); // 찾아서 다시 호출 
				return;
			}
			
			var str="<i class='fas fa-comments bg-yellow'></i>";
			
			if(list == null || list.length == 0){
				replyUL.html("");
				return;
			}
			
			for (var i = 0, len = list.length || 0; i < len; i++){
				str += "<div class='timeline-item' data-rno ='"+list[i].rno+"'>";
				str += "<span class='time'><i class='fas fa-clock'></i>&nbsp;"+replyService.displayTime(list[i].replyDate)+"</span>";
				str += "<h3 class='timeline-header'><b>[작성자] </b>"+list[i].replyer+"</h3>";
				str += "<div class='timeline-body'><b>[댓글 내용] </b>"+list[i].reply+"</div></div><br>";
			}
			replyUL.html(str);
			
			showReplyPage(replyCnt);
		});
	} 
	
	var pageNum = 1;
	var replyPageFooter = $(".card-footer");
	
	function showReplyPage(replyCnt){
		
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		var startNum = endNum - 9;
		
		var prev = startNum != 1; // startNum이 1이 아니면 즉 두번째 페이지는 11부터 시작함
		var next = false;
		
		if(endNum * 10 >= replyCnt){
			endNum = Math.ceil(replyCnt / 10.0);
		}
		
		if(endNum * 10 < replyCnt){
			next = true;
		}
		
		var str = "<ul class='pagination pagination-sm m-0 float-right'>";
		
		if(prev){
			str += "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>&laquo;</a></li>";
		}
		
		for(var i = startNum; i <= endNum; i++){
			var active = pageNum == i ? "active":"";
			
			str += "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		}
		
		if(next){
			str += "<li class='page-item'><a class='page-link' href='"+(endNum +1)+"'>&raquo;</a></li>";
		}
		
		str += "</ul></div>";
		
		replyPageFooter.html(str);
	}
	
	replyPageFooter.on("click","li a", function(e){ // 이벤트 위임, li태그가 생성되면 클릭 이벤트를 준다
	    	
	      e.preventDefault();
	       
	      console.log("page click");
	       
	      var targetPageNum = $(this).attr("href");
	       
	      console.log("targetPageNum: " + targetPageNum);
	       
	      pageNum = targetPageNum;
	       
	      showList(pageNum);
	});    
	
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyDate = modal.find("input[name='replyDate']");
	
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");
	
	var replyer = null;
	
	<sec:authorize access="isAuthenticated()">
		replyer='<sec:authentication property="principal.username"/>';
	</sec:authorize>
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$("#addReplyBtn").on("click", function(e){ // 댓글 등록 버튼이 눌려지면
		
		modal.find("input").val(""); // 모든 input태그를 비운다
		modal.find("input[name='replyer']").val(replyer); // 로그인한 사용자의 이름을 넣음
		modalInputReplyDate.closest("div").hide(); // 모달의 항목 중 댓글의 등록날짜를 표시하는 부분을 숨긴다
		modal.find("button[id != 'modalCloseBtn']").hide(); // 하부 버튼중 close 버튼을 제외하고 전부 숨긴다
		modalRegisterBtn.show(); // 등록 버튼을 활성화 시킨다.
		
		modal.modal("show"); // modal 활성화
	});
	
	// Ajax spring security header
	// ajax전송시 csrf토큰을 같이 전송하기 때문에 beforeSend를 호출해야되는 번거로움을 줄일 수 있음
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	modalRegisterBtn.on("click", function(e){ // 모달에서의 댓글 등록 버튼
		
		var reply = {
				reply:modalInputReply.val(), // 모달에서 작성한 reply
				replyer:modalInputReplyer.val(), // 모달에서 작성한 replyer
				bno:bnoValue // 페이지 번호
			};
	
		if(modalInputReply.val() == ""){
			swal ( "Oops" ,  "댓글 내용을 입력해 주세요." ,  "error" );
			return false;
		}
		
		if(modalInputReplyer.val() == ""){
			swal ( "Oops" ,  "댓글 작성자를 입력해 주세요." ,  "error" );
			return false;
		}
	
		replyService.add(reply, function(){
			
			swal ( "Success" ,  "댓글 등록이 완료되었습니다!!" ,  "success" );
			
			modal.find("input").val(""); // 입력항목 삭제
			modal.modal("hide"); // 모달을 닫아준다
			
			showList(-1); // 댓글 목록 갱신
		});
		
	});
	
	modalModBtn.on("click", function(e){ // 댓글의 수정
		
		var originalReplyer = modalInputReplyer.val();
		
		var reply = {
			rno:modal.data("rno"), // 댓글의 번호
			reply:modalInputReply.val(),//댓글 내용
			replyer:originalReplyer
		};
		
		if(!replyer){
			swal ( "Oops" ,  "로그인 후 수정이 가능합니다." ,  "error" );
			modal.modal("hide");
			return;
		}
		
		console.log("original Replyer -> " + originalReplyer);
	
		if(replyer != originalReplyer){
			swal ( "Oops" ,  "자신이 작성한 댓글만 수정이 가능합니다." ,  "error" );
			modal.modla("hide");
			return;
		}
		
		replyService.update(reply, function(){
			
			swal ( "Success" ,  "댓글 수정이 완료되었습니다!!" ,  "success" );
			
			modal.modal("hide");
			showList(pageNum);
		});
	});
	
	modalRemoveBtn.on("click", function(e){
		
		var rno = modal.data("rno");
		
		console.log("RNO : " + rno);
		console.log("REPLYER: " + replyer);
		
		if(!replyer){
			
			swal ( "Oops" ,  "로그인 후 삭제가 가능합니다." ,  "error" );
			modal.modal("hide");
			return;
		}
		
		var originalReplyer = modalInputReplyer.val();
		
		console.log("Original Replyer : " + originalReplyer); // 댓글의 원래 작성자
		
		if(replyer != originalReplyer){
			swal ( "Oops" ,  "자신이 작성한 댓글만 삭제가 가능합니다." ,  "error" );
			modal.modla("hide");
			return;
		}
		
		replyService.remove(rno, originalReplyer, function(){
			
			swal ( "Success" ,  "댓글 삭제가 완료되었습니다!!" ,  "success" );
			
			modal.modal("hide");
			showList(pageNum);
		})
	});
	
	$(".chat").on("click", ".timeline-item", function(e){ // 댓글을 클릭했을때 (이벤트 위임)
		
		var rno = $(this).data("rno");
	
		console.log(rno);
		
		replyService.get(rno, function(reply){ // 댓글 조회
			
			modalInputReply.val(reply.reply); // reply
			modalInputReplyer.val(reply.replyer); // replyer
			modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly"); // date
			modal.data("rno", reply.rno); // 댓글 번호
			
			modal.find("button[id != 'modalCloseBtn']").hide(); // close태그 말고 모두 지운다
			modalModBtn.show(); // 수정 버튼 활성화
			modalRemoveBtn.show(); // 삭제 버튼 활성화
			
			$(".modal").modal("show");
		});
	});

});
</script>

<script type="text/javascript">
	$(document).ready(function(){
		
		var operForm = $("#operForm");
		
		$("button[data-oper='modify']").on("click", function(e){
			
			operForm.attr("action","/board/modify").submit();
			
		});
		
		$("button[data-oper='list']").on("click", function(e){
			
			operForm.find("#bno").remove();
			operForm.attr("action","/board/list")
			operForm.submit();
			
		});
	});
</script>

  
 <%@include file="../includes/footer.jsp" %>