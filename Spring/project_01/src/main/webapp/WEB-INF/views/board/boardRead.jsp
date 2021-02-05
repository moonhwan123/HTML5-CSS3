<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<%@include file="../include/header.jsp"%>

 <div class="container">
        <h3>BoardRead</h3>
        <hr>
        <div class="row">
            <div class="col-sm-9">
                <h5>BNO</h5>
                <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon2"></span>
                    <input type="text" class="form-control" aria-describedby="sizing-addon2" 
                    	name='bno' value="<c:out value="${board.bno}" />" readonly="readonly">
                </div>
                <br>
            </div>
            <div class="col-sm-9">
                <h5>TITLE</h5>
                <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon2"></span>
                    <input type="text" class="form-control" aria-describedby="sizing-addon2" 
                    	name='title' value="<c:out value="${board.title}" />" readonly="readonly">
                </div>
            </div>
                <br> 
            <div class="col-sm-9">  
                <h5>CONTENT</h5>
                <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon2"></span>
                    <textarea class="form-control" rows="4" cols="10" style="resize: none; height:200px;" name='content' readonly="readonly"><c:out value="${board.content}" />
                    </textarea>
                </div>
                <br>
            </div>
            <div class="col-sm-9">
                <h5>WRITER</h5>
                <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon2"></span>
                    <input type="text" class="form-control" aria-describedby="sizing-addon2" 
                    	name='writer' value="<c:out value="${board.writer}" />" readonly="readonly">
                </div>
                <br>
            </div>
            <div class="col-sm-4">
            <h5>REGDATE</h5>
	            <div class="input-group">
	            	<span class="input-group-addon" id="sizing-addon2"></span>
	            	<input type="text" class="form-control" aria-describedby="sizing-addon2" 
	            	value="<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}" />" readonly="readonly"/>
	            </div>
            </div>
            <div class="col-sm-4">
            	<h5>LAST UPDATE</h5>
	            <div class="input-group">
	            	<span class="input-group-addon" id="sizing-addon2"></span>
	            	<input type="text" class="form-control" aria-describedby="sizing-addon2" 
	            	value="<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}" />" readonly="readonly"/>
	            </div>
            </div>
        </div><!-- end row -->
        <br><br>
        <button type="button" data-oper='remove' class="btn btn-default pull-left">Remove</button>
        <button type="button" data-oper='modify' class="btn btn-default pull-left">Modify</button>
        <button type="button" data-oper='list' class="btn btn-default pull-left">List</button>
        <br><br>
        
        <form id='operForm' method='get' action='/board/boardModify'> 
			<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'> 
			<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
			<input type='hidden' name='type' value='<c:out value="${cri.type}"/>' />
			<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>' />
			<input type='hidden' name='bno' value='<c:out value="${board.bno}"/>' />
		</form>
		<hr>
    </div><!-- end container -->
	<div class="container">
		<div class="row">
			<div class='col-sm-10'>
				<h3 style=''>Reply</h3>
				<hr>
			</div>
		</div><!-- end row -->
		<div class="row">
			<div class='chat'>	
				<div class='col-xs-6'>
					<p>Replyer</p>
				</div>  
				<div class='col-xs-6'>
					<p class='pull-right'>2021-02-28</p>
				</div>
				<div class='col-xs-12'>
					<p>Reply</p>
					<hr>
				</div>
			</div>	
		</div><!-- end row -->
		
		<div class='row'>
			<div class='col-sm-10'>
				<div class='replyPageList' style='text-align: right;'>
					
				</div>
			</div>
		</div><!-- end row -->
		
		<div class='row'>
			<div class="col-sm-10">
				<form name='replyForm'>
					<h4>New Reply</h4>
					<textarea class="form-control" rows="3" style='resize: none;' name='reply'></textarea>
					<br>
				</form>
				<button class='btn btn-default pull-right' id='replySubmitBtn'>Submit</button>
			</div>
		</div>
	</div><!-- end container -->
	<br><br><br>
	
	<!-- 댓글 처리용 modal -->
	<div class="row">
		<div class="modal" id="myModal" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">Reply</h4>
					</div> 
					<div class="modal-body">
						<div class='form-group'>
							<label>Replyer</label>
							<input class='form-control' name='replyer' value=''/>
						</div>
						<div class='form-group'>
							<label>Reply</label>
							<textarea class='form-control' rows="3" style='resize: none;' name='reply'></textarea>
						</div>
						<div class='form-group'>
							<label>Reply Date</label>
							<input class='form-control' name='replyDate' value=''/>
						</div>
						<input type="hidden" name="rno" value=''/>
					</div>
					<div class="modal-footer">
						<button type="button" id="modalModiBtn" class="btn btn-default">
							Modify
						</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">
							Close
						</button>
					</div>
				</div><!-- end modal-content -->
			</div><!-- end modal-dialog -->
		</div><!-- end modal -->
	</div><!-- end row -->
	<!-- 댓글 처리용 모달 끝 -->

<c:set var="time" value="${System.currentTimeMillis()}"></c:set>
<script type="text/javascript" src="/resources/js/reply.js?time=${time}"></script>

<!-- 기본적인 스크립트 -->
<script type="text/javascript">
$(document).ready(function() {
	
	var operForm = $("#operForm");
	
	$("button[data-oper='list']").on("click", function(e) {

		operForm.find("#bno").remove();
		operForm.attr("action", "/board/boardList");
		operForm.submit();

	});
	$("button[data-oper='modify']").on("click", function(e) {

		operForm.attr("action", "/board/boardModify");
		operForm.submit();

	});
	$("button[data-oper='remove']").on("click", function(e) {
		
		var con_test = confirm("Are you sure you want to delete it?");
		if(con_test == true){
			operForm.attr("method","post");
			operForm.attr("action", "/board/boardRemove");
			operForm.submit();
		}
		else if(con_test == false){
		  return;
		}
	});
	
	
});
</script>

<!-- 댓글 처리용 스크립트 -->
<script type="text/javascript">

$(document).ready(function(){
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");
	console.log("target bno : " + bnoValue);
	
	showList(1);
	
	function showList(page){
		console.log("showList Page : " + page);
		replyService.getList({bno:bnoValue , page:page||1},function(replyCnt,list){
			
			var str = "";
			
			if(page == -1){
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);
				return;
			}
			
			if(list == null || list.length == 0){
				console.log("empty reply list");
				replyUL.html("");
			}
			
			for(var i = 0,len=list.length || 0; i < len; i++){
				str += "<div class='col-xs-5'><strong>"+list[i].replyer+"</strong></div>";
				str += "<div class='col-xs-5'><P class='pull-right'>"+replyService.displayTime(list[i].replyDate)+"</P></div>";
				str += "<div class='col-xs-10'><textarea class='form-control' style='resize:none;' readonly>"+list[i].reply+"</textarea></div>";
				str += "<div class='col-xs-10'><br><button data-rno='"+list[i].rno+"' class='btn btn-default btn-xs' id='modiBtn'>Modify</button>";
				str += "&nbsp;<button data-rno='"+list[i].rno+"' class='btn btn-default btn-xs' id='removeBtn'>Remove</button><hr></div>";
			}
			replyUL.html(str);
			showReplyPage(replyCnt);
		});//end getList
	}//end showList
	
	
	//댓글 페이징  계산
	var pageNum = 1;
	var replyPageList = $(".replyPageList");
	
	function showReplyPage(replyCnt){
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		var startNum = endNum-9;
		var prev = startNum != 1;
		var next = false;
		
		if(endNum * 10 >= replyCnt){
			endNum = Math.ceil(replyCnt/10.0);
		}
		
		if(endNum * 10 < replyCnt){
			next = true;
		}
		
		var str = "<nav aria-label='Page navigation'><ul class='pagination'>";
		
		if(prev){
			str += "<li class='paginate_button'><a href='"+startNum -1+"' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>";
		}
		
		for(var i = startNum; i<= endNum; i++){
			var active = pageNum == i ? "active" : "";
			str += "<li class='paginate_button "+active+" '><a href='"+i+"'>"+i+"</a></li>";
		}
		
		if(next){
			str += "<li class='paginate_button'><a href='"+(endNum + 1)+"' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>";
		}
		
		str += "</ul></nav>";
		
		replyPageList.html(str);
	}
	
	
	//댓글 등록
	var replySubmitBtn = $("#replySubmitBtn");
//	var replyForm = $("#replyForm");
	replySubmitBtn.on("click",function(e){
		
		console.log("submit button click");
		
		if(replyForm.reply.value == "" || replyForm.reply.value == null){
			alert("Please insert reply");
			return;
		}
		
		var reply = {
			reply : replyForm.reply.value,
			bno : bnoValue,
			replyer : 'testReplyer'
		};
		
		console.log(reply);
		
		replyService.add(reply,function(result){
			alert(result);
			replyForm.reply.value = "";
			showList(-1);
		});
		
	});//댓글 등록 끝
	
	
	//모달 버튼 객체등록
	var modal = $(".modal");
	var modalInputReply = modal.find("textarea[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyDate = modal.find("input[name='replyDate']");
	var modalRno = modal.find("input[name='rno']");
	
	var modalModiBtn = $("#modalModiBtn");
	
	//댓글 수정 버튼 클릭시 댓글 정보 불러오기 
	$(".chat").on("click","#modiBtn",function(e){
		
		var rno = $(this).data("rno");
		
		console.log(rno);
		
		replyService.read(rno,function(reply){
			modalInputReplyer.val(reply.replyer).attr("readonly","readonly");
			modalInputReply.val(reply.reply);
			modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
			modal.find("input[name='rno']").val(reply.rno);
		});
		
		$(".modal").modal("show");
		
	});// 댓글 정보 불러오기
	
	//댓글 수정
	modalModiBtn.on("click",function(e){
		var reply = {
			rno : modalRno.val() ,
			reply : modalInputReply.val() , 
		};
		console.log(reply);
		replyService.modify(reply,function(result){
			alert(result);
			modal.modal("hide");
			showList(pageNum);
		});
	});
	
	//댓글 삭제 하기
	$(".chat").on("click","#removeBtn",function(e){
		
		var rno = $(this).data("rno");
			
		console.log(rno);
			
		var con_test = confirm("Are you sure you want to delete it?");
		if(con_test == true){
			replyService.remove(rno,function(deleteResult){
				alert(deleteResult);
				modal.modal("hide");
				showList(pageNum);
			});
		}
		
	});//삭제끝
	
	//댓글 페이지 번호 클릭시 새로운 댓글 불러오기
	replyPageList.on("click","li a",function(e){
		e.preventDefault();
		console.log("reply page click");
		
		var targetPageNum = $(this).attr("href");
		
		pageNum = targetPageNum;
		
		console.log("Current pageNum : " + pageNum);
		
		showList(pageNum);
	});
	
});



</script>


<%@include file="../include/footer.jsp"%>