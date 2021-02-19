package org.moon.controller;


import java.util.List;

import org.moon.domain.Criteria;
import org.moon.domain.ReplyPageDTO;
import org.moon.domain.ReplyVO;
import org.moon.service.ReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/reply/")
@AllArgsConstructor
@Log4j
public class ReplyController {

	private ReplyService service;
	
	@PostMapping(value = "/insert", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> replyInsert(@RequestBody ReplyVO vo){
		
		log.info("...........At ReplyController..........");
		
		log.info("Reply Insert................ ReplyVO: " + vo);
		
		int insertResult = service.replyInsert(vo);
		
		log.info("insert result : " + insertResult);
		
		return insertResult == 1 
				? new ResponseEntity<> ("success" , HttpStatus.OK)
				: new ResponseEntity<> (HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	@GetMapping(value="/lists/{bno}/{page}",produces = {
			 MediaType.APPLICATION_XML_VALUE,
			 MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("bno")Long bno){
		log.info("...........At ReplyController..........");
		log.info("getList................ page : " + page + ".............bno : " + bno);
		
		Criteria cri = new Criteria(page,10);
		
		log.info("cri .......... " + cri);
		return new ResponseEntity<> (service.getReplyList(cri, bno),HttpStatus.OK);
	}
	
	@GetMapping(value = "/{rno}",produces = {
			 MediaType.APPLICATION_XML_VALUE,
			 MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<ReplyVO> replyRead(@PathVariable("rno") Long rno){
		log.info("...........At ReplyController..........");
		log.info("........replyRead rno........" + rno);
		
		return new ResponseEntity<>(service.replyRead(rno), HttpStatus.OK);
	}
	
	@DeleteMapping(value = "/{rno}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno) {
		log.info("...........At ReplyController..........");
		log.info("...........remove..........");
		log.info("Target RNO : " + rno);
		
		
		return service.replyDelete(rno) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}
	
	@RequestMapping(method = { RequestMethod.PUT,RequestMethod.PATCH }, 
			value = "/{rno}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo,@PathVariable("rno") Long rno) {
		log.info("...........At ReplyController..........");
		log.info("...........modify.............");
		
		vo.setRno(rno);

		log.info("rno : " + rno);
		log.info("ReplyVO : " + vo);

		return service.replyModify(vo) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}
	
}
