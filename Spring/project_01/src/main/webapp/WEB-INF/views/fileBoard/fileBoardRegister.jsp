<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<%@include file="../include/header.jsp"%>

<style>
	.uploadResult {
		width: 100%;
		background-color: white;
	}
	.uploadResult ul {
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	.uploadResult ul li {
		list-style: none;
		padding: 10px;
	}
	.uploadResult ul li img {
		width: 100px;
	}
</style>

<style>
	.bigPictureWrapper {
	  position: absolute;
	  display: none;
	  justify-content: center;
	  align-items: center;
	  top:0%;
	  width:100%;
	  height:100%;
	  background-color: gray; 
	  z-index: 100;
	}
	.bigPicture {
	  position: relative;
	  display:flex;
	  justify-content: center;
	  align-items: center;
	}
</style>

 <div class="container">
        <h4>File Board Register</h4>
        <hr>
        <form name="regiForm" action="/fileBoard/fileBoardRegister" method="post">
        <div class="row">
            <div class="col-sm-9">
                <h5>TITLE</h5>
                <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon2"></span>
                    <input type="text" class="form-control" placeholder="TITLE" aria-describedby="sizing-addon2" name='title'>
                </div>
                
                <br>  
                 
                <h5>CONTENT</h5>
                <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon2"></span>
                    <textarea class="form-control" placeholder="CONTENT" rows="4" cols="10" 
                    	style="resize: none; height:200px;" name='content'></textarea>
                </div>
                
                <br>
                
                <h5>WRITER</h5>
                <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon2"></span>
                    <input type="text" class="form-control" placeholder="WRITER" aria-describedby="sizing-addon2" name='writer'>
                </div>
                
                <br>
                
                <div class='uploadDiv'>
				   	<h5>Attach File Upload</h5>
					<input type="file" name='uploadFile' multiple/>
				</div>
				
				<br>
				
				<div class='uploadResult'>
					<ul>
					
					</ul>
				</div>
				
                <br>
            </div><!-- end col-sm-4 -->
            
        </div><!-- end row -->
        <hr>
        <button type="submit" class="btn btn-default pull-right">Submit</button>
        <button type="reset" class="btn btn-default pull-right">Reset</button>
        <br><br><br><br><br>
        </form>
    </div>

	


<script type="text/javascript">
$(document).ready(function() {

	var formObj = $("form[name='regiForm']");
	
	$("button[type='submit']").on("click",function(e){
		e.preventDefault();
		
		if(regiForm.title.value == null || regiForm.title.value == ""){
			alert("please insert title");
			return;
		}
		
		if(regiForm.content.value == null || regiForm.content.value == ""){
			alert("please insert content");
			return;
		}
		
		console.log("submit clicked");
		
		var str = "";
		
		//파일 등록
		$(".uploadResult ul li").each(function(i,obj){
			
			var jobj = $(obj);
			
			console.dir("jobj"+jobj);
			
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
			
		});
		console.log(str);
		formObj.append(str).submit();
		
	});
	
});
</script>

<!-- 파일 업로드 관련 -->
<script type="text/javascript">
$(document).ready(function(){
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880 * 2; //5MB * 2
	
	//파일 유효성 검사
	function checkExtension(fileName,fileSize){
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드 불가능 합니다.");
			return false;
		}
		return true;
	}
	
	//파일 업로드 결과 화면 처리 함수
	var uploadResult = $(".uploadResult ul");
	
	function showUploadResult(uploadResultArr){
		
		var str = "";
		
		$(uploadResultArr).each(function(i,obj){
			
			if(!obj.fileType){ // img 아닐때
				
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
				console.log("fileCallPath : "+fileCallPath);
				
				var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
				console.log("fileLink : "+fileLink);
				
				str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>"
						+ "<img src='/resources/img/attach.png'>" + obj.fileName 
						+ "<br><button type='button' class='btn btn-default' data-file=\'"+fileCallPath+"\' data-type='file'> Delete </button>" +"</li>"
				
			}else{ // img 일때
				
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				console.log("fileCallPath : "+fileCallPath);
				
				str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>"
						+ "<img src='/display?fileName="+fileCallPath+"'>"
						+ "<br><button type='button' class='btn btn-default' data-file=\'"+fileCallPath+"\' data-type='image'> Delete </button></li>";
				
			}
			
			
		});
		
		uploadResult.append(str);
	}
	
	//Delete 버튼 클릭시 첨부 파일 삭제 처리
	$(".uploadResult").on("click","button",function(e){
		
		console.log("delete file");
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		
		var targetLi = $(this).closest("li");
		
		$.ajax({
			url : '/deleteFile',
			data : {
				fileName : targetFile,
				type : type
			},
			dataType : 'text',
			type : 'POST',
			success : function(result){
				alert(result);
				targetLi.remove();
			}
		});
		
	});
	
	//실제 업로드 처리 로직
	$("input[type='file']").change(function(e){
		//Ajax를 이용해서 파일업로드를 할시에는 formData라는 객체를 이용한다.
		//이는 가상의 폼태그와 같다고 생각하면 된다.
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		
//		console.log(files);
		
		//업로드할 파일들을 formData에 저장 
		for(var i = 0 ; i< files.length; i++){
			if(!checkExtension(files[i].name,files[i].size)){
				return false;
			}
			formData.append("uploadFile",files[i]);
		}
		
		$.ajax({
			url : '/uploadAjaxAction',
			//파일 전송시 processData,contentType 은 false로 지정해야된다.
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			dataType : 'json',
			success : function(result){
				console.log(result);
				showUploadResult(result);
			}
		});//end $.ajax
	});//end .change(function(e))
	
	
	
	
});
</script>

<%@include file="../include/footer.jsp"%>