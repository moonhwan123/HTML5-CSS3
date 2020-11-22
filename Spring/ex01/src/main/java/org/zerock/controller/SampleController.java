package org.zerock.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.SampleDTO;
import org.zerock.domain.SampleDTOList;
import org.zerock.domain.TodoDTO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/sample/*")
@Log4j
public class SampleController {
	
	//파라미터 변환시 사용
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(dateFormat, false));
	}
	

	@RequestMapping("")
	public void basic() {
		log.info("basic..................");
	}
	
	@RequestMapping(value = "/basic", method = {RequestMethod.GET, RequestMethod.POST})
	public void basicGet() {
		log.info("basicGet..................");
	}
	@GetMapping
	public void basicGet2() {
		log.info("basicGet only get..................");
	}
	
	
	@GetMapping("/ex01")
	public String ex01(SampleDTO dto) {
		log.info("" + dto);
		
		return "ex01";
	}
	@GetMapping("/ex02")
	public String ex02(@RequestParam("name") String name2, @RequestParam("age") int age2) {
		
		log.info("name2 = " + name2);
		log.info("age2 = " + age2);
		return "ex02";
	}
	
	//같은 이름의 파라미터가 여러개 전달 되는 경우 ArrayList를 사용 하여 처리한다.
	@GetMapping("/ex02List")
	public String ex02List(@RequestParam("ids") ArrayList<String> ids) {
		
		log.info("ids : " + ids);
		return "ex02List";
	}
	//배열의 경우에도 동일하게 처리 가능하다.
	@GetMapping("/ex02Array")
	public String ex02Array(@RequestParam("ids") String[] ids) {
		log.info("ids : " + Arrays.toString(ids));
		return "ex02Array";
	}
	
	//파라미터로 동일한 객체를 여러개 받는 경우
	@GetMapping("/ex02Bean")
	public String ex02Bean(SampleDTOList list) {
		
		log.info("list dtos : " + list);
		
		return "ex02Bean";
	}
	
	@GetMapping("/ex03")
	public String ex03(TodoDTO todo) {
		log.info("todo = "+ todo);
		return "ex03";
	}
	
	@GetMapping("/ex04")
	public String ex04(SampleDTO dto ,@ModelAttribute("page") int page) {
		log.info("dto = " + dto);
		log.info("page = " + page);
		
		//dto는 전달이 되지만 page는 jsp페이지로 전달 되지 않는다. 그래서 @ModelAttribute 어노테이션을 사용한다.
		//이 어노테이션은 타입에 관계없이 무조건 모델에 담아서 전달한다. 파라미터로 전달된 데이터를 다시 화면에서 사용해야할 경우 유용하다.
		return "sample/ex04";
	}
	
	@GetMapping("/ex05")
	public void ex05() {
		log.info("ex05............");
	}
	
	@GetMapping("/ex06")
	public @ResponseBody SampleDTO ex06() {
		log.info("/ex06..............");
		
		SampleDTO dto = new SampleDTO();
		dto.setAge(10);
		dto.setName("홍길동");
		
		return dto;
	}
	@GetMapping("/ex07")
	public ResponseEntity<String> ex07(){
		log.info("/ex07............");
		
		String msg = "{\"name\" : \"홍길동\"}";
		
		HttpHeaders header = new HttpHeaders();
		
		header.add("Content-Type", "application/json;charset=UTF-8");
		
		return new ResponseEntity<String>(msg,header,HttpStatus.OK);
	}
	
	@GetMapping("/exUpload")
	public void exUpload() {
		log.info("/exUpload...........");
	}
	
	@PostMapping("/exUploadPost")
	public void exUploadPost(ArrayList<MultipartFile> files) {
		
		files.forEach(file -> {
			log.info("---------------------------------------------");
			log.info("name : " + file.getOriginalFilename());
			log.info("size : " + file.getSize());
		});
	}
}
