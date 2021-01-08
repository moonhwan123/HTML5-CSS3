<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<style>
	.uploadResult{
		width:100%;
		background-color:gray;
	}
	
	.uploadResult ul{
		display:flex;
		flex-flow:row;
		justify-content:center;
		align-item:center;
	}
	
	.uploadResult ul li{
		list-style:none;
		padding:10px;
	}
	.uploadResult ul li img{
		width:20px;
	}
	
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

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<body>
	<h1>Upload With Ajax</h1>
	
	<div class='uploadDiv'>
		<input type='file' name='uploadFile' multiple>
	</div>
	
	<div class='uploadResult'>
		<ul>
		
		</ul>
	</div>
	<button id='uploadBtn'>Upload</button>
	
	<div class ='bigPictureWrapper'>
		<div class='bigPicture'>
		</div>
	</div>
</body>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>
	

		
<script>
//해당 함수는 $(document).ready()의 바깥쪽에 작성 - 나중에 <a>태그에서 직접 호출할수 있게 하기 위함
function showImage(fileCallPath){
	
	  $(".bigPictureWrapper").css("display","flex").show();
	  
	  $(".bigPicture")
	  .html("<img src='/display?fileName="+fileCallPath+"'>")
	  .animate({width:'100%', height: '100%'}, 1000);
	  
}

$(".bigPictureWrapper").on("click", function(e){
	  $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
	  setTimeout(() => {$(this).hide(); }, 1000);
	});

$(document).ready(function(){
	
	//파일 확장자 제한 및 용량 제한
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxsize = 5242880; // 5MB
	
	var cloneObj = $(".uploadDiv").clone(); 
	
	function checkExtension(fileName,fileSize){
		if(fileSize >= maxsize){
			alert("파일 사이즈 초과");
			return false;
		}
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드 불가능");
			return false;
		}
		return true;
	}
	
	//uploadBtn.Click
	$("#uploadBtn").on("click",function(e){
		
		var formData = new FormData();
		var inputFile = $("input[name = 'uploadFile']");
		var files = inputFile[0].files;
		
		console.log(files);
		
		//add filedate to formdata
		for(var i = 0; i < files.length; i++){
			//확장자,용량 체크
			if(!checkExtension(files[i].name,files[i].size)){
				return false;
			}
			formData.append("uploadFile",files[i]);
		}//end for
		
		$.ajax({
			url : '/uploadAjaxAction',
			processData : false,
			contentType : false, //processData,contentType은 반드시 false로 지정해야만 전송된다.
			data : formData,
			type : 'POST',
			dataType: 'json',
			success : function(result){ // result - 응답데이터
										// 인자 result에는 서버에서 리턴해준 배열이 들어감
				console.log(result);
				showUploadedFile(result);
				$(".uploadDiv").html(cloneObj.html());
			}
		}); // end $.ajax
		
	})//uploadBtn.Click
	
	
	var uploadResult = $(".uploadResult ul");

/*
	//업로드한 파일  보여주기1
	function showuploadFile(uploadResultArr){
		var str = "";
		
		$(uploadResultArr).each(function(i, obj){
			
			str += "<li>" + obj.fileName + "</li>";
		});
		
		uploadResult.append(str);
	}//안씀
*/
	
	//업로드한 파일  보여주기2
	function showUploadedFile(uploadResultArr){
		var str ="";
		
		$(uploadResultArr).each(
			function(i,obj){
				
				if(!obj.image){
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + 
							obj.uuid+"_"+obj.fileName);
					
					var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
					
					str += "<li><div><a href='/download?fileName="+fileCallPath+"'>"+
			           "<img src='/resources/img/ERD.png'>"+obj.fileName+"</a>"+
			           "<span data-file=\'"+fileCallPath+"\' data-type='file'> x </span>"+
			           "<div></li>";
					
				} else{
				       var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
				       
				       var originPath = obj.uploadPath+ "\\"+obj.uuid +"_"+obj.fileName;
				       
				       originPath = originPath.replace(new RegExp(/\\/g),"/");
				       
				       str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\">"+
			              "<img src='display?fileName="+fileCallPath+"'></a>"+
			              "<span data-file=\'"+fileCallPath+"\' data-type='image'> x </span>"+
			              "<li>";
				}
			}//end fucntion(i,obj)
		);//end each
		
		uploadResult.append(str);
	}//end showUploadedFile
	
	
	
	//X표시 눌렀을때의 처리 (삭제)
	$(".uploadResult").on("click","sapn",function(e){
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		console.log(targetFile);
		
		$.ajax({
			uri: '/deleteFile',
			data: {fileName : targetFile, type : type},
			dataType: 'text',
			type: 'POST',
			success: function(result){
				alert(result);
			}
		}); //end ajax
		
	})//end x 버튼 처리
})
</script>

</html>



		
