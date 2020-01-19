console.log("Reply Module load...");

// 즉시 실행 함수
var replyService = (function(){
	
	// 댓글 추가
	function add(reply, callback, error){ // ajax 호출이 성공하고 callback값으로 적절한 함수가 존재하면 해당 함수를 호출해서 결과를 반영.
		
		console.log("add reply");
		
		$.ajax({
			type :'post',
			url : '/reply/newReply',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8", // json전송 타입
			success : function(result, status, xhr) {
				if (callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	// 댓글 조회
	function get(rno, callback, error){
		
		// 비동기적으로 GET/POST 방식 요청
		$.get("/reply/"+rno+".json", function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		})
	}
	
	// 댓글의 전체목록
	function getList(param, callback, error){
		
		var bno = param.bno;
		var page = param.page || 1; // param.page값이 있으면 그 값이 들어가고 없으면 1이 들어간다
		
		// 서버로부터 비동기적으로 JSON데이터를 받아온다.
		$.getJSON("/reply/pages/" + bno + "/" + page + ".json", // .json형태가 필요함
				function(data){
					if (callback) {
						// callback(data); // 댓글의 목록만 가져올 경우
						callback(data.replyCnt, data.list); // 댓글의 숫자와 목록의 가져오는 경우
					}
				}).fail(function(xhr, status, err){
					if(errer){
						error();
					}
		});
	}
	
	// 댓글의 수정
	function update(reply, callback, error){
		
		console.log("rno ->" + reply.rno);
		
		$.ajax({
			type : 'put',
			url : '/reply/' + reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	// 댓글의 삭제
	function remove(rno, replyer, callback, error){
		$.ajax({
			type :'delete',
			url : '/reply/'+ rno,
			data : JSON.stringify({rno:rno, replyer:replyer}),
			contentType: "application/json; charset=utf-8",
			success : function(deleteResult, status, xhr) {
				if (callback){
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	// 댓글의 시간
	function displayTime(timeValue){
		
		var today = new Date();
		var gap = today.getTime() - timeValue; // 
		var dateObj = new Date(timeValue);
		var str = "";
		
		// (1000 * 60 * 60 * 24) : 24시간(하루)
		if (gap < (1000 * 60 * 60 * 24)){ // 시간의 차이가 하루 이하 이면 시:분:초 을 출력해줌
			
			var hh = dateObj.getHours(); // 시간
			var mi = dateObj.getMinutes(); // 분
			var ss = dateObj.getSeconds(); // 초
			
			// 단위당 한 자리 숫자를 두 자리 숫자로 만들어주기 위함 
			return [(hh > 9 ? '' : '0') + hh,
					':', 
					(mi > 9 ? '' : '0') + mi,
					':',
					(ss > 9 ? '' : '0') + ss
					].join('');
		} else {
			 var yy = dateObj.getFullYear(); // 현지시간 기준 연도 반환
			 var mm = dateObj.getMonth() + 1; // 1월부터 시작하므로 + 1
			 var dd = dateObj.getDate(); // 일
			 
			// 단위당 한 자리 숫자를 두 자리 숫자로 만들어주기 위함 
			 return [yy, 
				 	'/', 
				 	(mm > 9 ? '' : '0') + mm,
				 	'/', 
				 	(dd > 9 ? '' : '0') + dd
				 	].join('');
		}
	};

	
	return {
		add : add,
		get : get,
		getList : getList,
		update:update,
		remove : remove,
		displayTime : displayTime
	};
})();