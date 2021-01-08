package com.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.zerock.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Log4j
@Controller
public class UploadController {
	
	//폴더생성
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		
//		log.info(File.separator);
		
		return str.replace("-", File.separator);
	}
	
	//특정한 파일이 이미지 타입인지 검사
	private boolean checkImageType(File file) {
		
		try {
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload form");
	}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		
		String uploadFolder = "C:\\upload";
		
		for(MultipartFile multipartFile : uploadFile) {
			log.info("---------------------------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			
			File saveFile = new File(uploadFolder,multipartFile.getOriginalFilename());
			
			try {
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}//end for
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax");
	}
	
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		
		log.info("update ajax post....................");
		
		List<AttachFileDTO> list = new ArrayList<AttachFileDTO>();
		String uploadFolder = "C:\\upload";
		
		String uploadFolderPath = getFolder();
		
		//Make Folder
		File uploadPath = new File(uploadFolder,uploadFolderPath);
		log.info("upload Path : " + uploadPath);
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		// make yyyy/MM/dd folder
		
		for(MultipartFile multipartFile : uploadFile) {
			
			AttachFileDTO attachDTO = new AttachFileDTO();
			
			log.info("----------------------------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			//IE has file path
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			attachDTO.setFileName(uploadFileName);
			
			//UUID로 중복된 파일이름 방지하기
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			log.info("only file name : " + uploadFileName);
			
			
			try {
				File saveFile = new File(uploadPath,uploadFileName);
				multipartFile.transferTo(saveFile);
				
				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);
				
				//img파일 체크후 섬네일 생성
				if(checkImageType(saveFile)) {
					
					attachDTO.setImage(true);
					
					FileOutputStream thumbnail = 
							new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					
					Thumbnailator.createThumbnail(multipartFile.getInputStream(),thumbnail,100,100);
					thumbnail.close();
				}//end if
				
				//add to list
				list.add(attachDTO);
				
			}catch (Exception e) {
				log.error(e.getMessage());
			}//end try catch
			
		}//end for
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
	
	//이미지 파일 섬네일 전송용 메서드
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		
		log.info("At display fileName : " + fileName);
		
		File file = new File("C:\\upload\\" + fileName);
		
		log.info("file : " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	//파일 다운로드 처리
	@GetMapping(value = "/download" , produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	//MIME타입은 다운로드를 할 수 있는 APPLICATION_OCTET_STREAM_VALUE으로 지정
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(String fileName,@RequestHeader("User-Agent") String userAgent){
		
		log.info("download file : " + fileName);
		
		Resource resource = new FileSystemResource("c:\\upload\\" + fileName);
		
		if(resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		log.info("resource : " + resource);
		
		String resourceName = resource.getFilename();
		
		HttpHeaders headers = new HttpHeaders();
		
		//remove UUID
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);
		
		try {
			
			String downloadName = null;
			
			if(userAgent.contains("Trident")) {
				log.info("IE browser desu.");
				
				downloadName = URLEncoder.encode(resourceOriginalName,"UTF-8").replaceAll("\\+", " ");
				
			}else if (userAgent.contains("Edge")){
				log.info("Edge browse desu.");
				
				downloadName = URLEncoder.encode(resourceOriginalName,"UTF-8");
				
				log.info("Edge name : " + resourceOriginalName);
				
			}else {
				log.info("Chorme browser desu.");
				
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"),"ISO-8859-1");
			}//end if
			
			headers.add("Content-Disposition", "attachment; filename=" + new String(resourceOriginalName.getBytes("UTF-8"),
					"ISO-8859-1"));
			//다운로드시 저장되는 이름은 Content-Disposition을 이용해서 지정한다.
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource,headers,HttpStatus.OK);
	}
	
	//첨부 파일 삭제
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		log.info("deleteFile : " + fileName);
		
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
