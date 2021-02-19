package org.moon.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.moon.domain.BoardAttachVO;
import org.moon.domain.FileBoardVO;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	
	
	@PostMapping(value = "/uploadAjaxAction" , produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> uploadAjaxAction(MultipartFile[] uploadFile) {
		log.info("============================== uploadAjaxAction =================================");
		log.info(".......At UploadController.......");
		
		//브라우저에 전송할 파일들의 객체 리스트
		List<BoardAttachVO> list = new ArrayList<>();
		
		String uploadFolder = "C:\\upload";
		String uploadFolderPath = getFolder();
		log.info("uplaodFolder : " + uploadFolder);
		log.info("uploadFolderPath : " + uploadFolderPath);
		
		//폴더 생성
		File uploadPath = new File(uploadFolder,uploadFolderPath);
		
		if(uploadPath.exists() == false) {
			log.info("폴더가 존재 하지 않으므로 폴더를 생성 합니다.");
			uploadPath.mkdirs();	//위에서 지정한 uploadPath가 존재하지 않는다면 폴더를 생성한다.
			log.info("생성된 경로 : " + uploadPath);
		}
		
		log.info("저장할 경로 (uploadPath) : " + uploadPath);
		//폴더생성 관련 처리 끝
		
		for(MultipartFile multipartFile : uploadFile) {
			//브라우저에 전송할 파일 객체
			BoardAttachVO boardAttachVO = new BoardAttachVO();
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			//1)
			//브라우저에 전송할 객체에 파일이름 지정 (uuid 붙이기 전에 이름)
			boardAttachVO.setFileName(uploadFileName);
			
			//중복 방지를 위한 UUID 생성
			UUID uuid = UUID.randomUUID();
			//기존 업로드파일이름에 uuid 결합
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			log.info("업로드 할 파일 이름(uuid 포함) : " + uploadFileName);
			log.info("업로드 할 파일 사이즈 : " + multipartFile.getSize());
			
			try {
				//실제 저장할 파일 객체(경로와 파일이름)
				File saveFile = new File(uploadPath,uploadFileName);
				
				multipartFile.transferTo(saveFile);
				log.info("업로드 성공");
				
				//2)
				boardAttachVO.setUuid(uuid.toString());
				//3)
				boardAttachVO.setUploadPath(uploadFolderPath);
				
				//이미지 파일 타입인지 검사한다.
				if(checkImageType(saveFile)) {
					
					//4)
					//참이면 브라우저에 전송할 파일객체에 이미지파일 인지의 여부를 저장한다.
					boardAttachVO.setFileType(true);
					
					//참이면 섬네일을 생성한다.
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath,"s_"+uploadFileName));
					log.info("이미지 파일 이므로 섬네일을 생성 합니다. 생성된 섬네일 : " + thumbnail.getClass());
					Thumbnailator.createThumbnail(multipartFile.getInputStream(),thumbnail,100,100);
					
					thumbnail.close();
				}//end if
				
				list.add(boardAttachVO);
				
			} catch (Exception e) {
				log.error(e.getMessage());
			}//end try&catch
			
		}//end for
		
		
		log.info("============================== end uploadAjaxAction =================================");
		
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
	
	//업로드 폴더 생성
	private String getFolder() {
		
		log.info(" ");
		log.info("  getFoler()  ");
		log.info("폴더 경로를 생성 합니다..........");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		String folderName = str.replace("-", File.separator);
		
		log.info("생성된 폴더 경로 문자열 : " + folderName);
		log.info("    ");
		return folderName;
	}
	
	//특정한 파일이 이미지 타입인지를 검사하는 메서드
	private boolean checkImageType(File file) {
		
		try {
			log.info(" ");
			log.info(" checkImageType() ");
			log.info(".........파일 타입을 검사합니다........");
			String contentType = Files.probeContentType(file.toPath());
			
			log.info("파일 타입 체크 결과 : " + contentType);
			log.info(" ");
			
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	//썸네일 이미지 불러오는 메소드
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		
		log.info(" ...........display()............. ");
		log.info(".........썸네일을 불러옵니다..........");
		log.info("불러올 이미지 파일 이름(파일의 경로가 포함된) : " + fileName);
		
		File file = new File("c:\\upload\\" + fileName);
		
		log.info("생성한 파일 객체 : " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	//첨부파일 삭제 메서드
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		log.info(".......deleteFile().......");
		log.info("fileName : " + fileName + " / type : " + type);
		
		File file;
		
		try {
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName,"UTF-8"));
			file.delete();
			
			if(type.equals("image")) { // 이미지일 경우
				String largeFileName = file.getAbsolutePath().replace("s_", "");//썸네일도 같이 지운다.
				log.info("largeFileName : " + largeFileName);
				
				file = new File(largeFileName);
				file.delete();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}//end try
		
		return new ResponseEntity<>("Deleted",HttpStatus.OK);
	}//end deleteFile Method
	
}
