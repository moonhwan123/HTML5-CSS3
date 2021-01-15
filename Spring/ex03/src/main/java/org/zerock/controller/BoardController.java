package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	
	private BoardService service;
	
//	@GetMapping("/list")
//	public void list(Model model) {
//		log.info("controller....list");
//		model.addAttribute("list",service.getList());
//		
//	}
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list............pageNum : " + cri.getPageNum()+ " , amount : " + cri.getAmount());
		
		int total = service.getTotal(cri);
		log.info("total : " + total);
		
		model.addAttribute("list",service.getList(cri));
//		log.info(service.getList(cri));
		
//		model.addAttribute("pageMaker", new PageDTO(cri, 123));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@GetMapping("/register")
	public void register() {
		log.info("controller....registerGet");
	}
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("controller....registerPost" + board);
		
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		
		service.register(board);
		
		rttr.addFlashAttribute("result",board.getBno());
		
		return "redirect:/board/list";
	}
	
	@GetMapping({"/get","/modify"}) //url을 배열로 처리한다.
	public void get(@RequestParam("bno")Long bno, @ModelAttribute("cri")Criteria cri, Model model) {
		log.info("controller....get or modify");
		model.addAttribute("board",service.get(bno));
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr, @ModelAttribute("cri")Criteria cri) {
		log.info("controller....modify" + board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}
		
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno")Long bno, RedirectAttributes rttr, @ModelAttribute("cri")Criteria cri) {
		log.info("BoardController....remove..... bno = " + bno);
		
		//삭제 전 해당 게시물의 첨부파일 목록을 확보
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		if(service.remove(bno)) { //게시글 삭제
			
			deleteFile(attachList); //실제 첨부파일 삭제
			
			rttr.addFlashAttribute("result","success");
		}
//		rttr.addAttribute("pageNum",cri.getPageNum());
//		rttr.addAttribute("amount",cri.getAmount());
//		rttr.addAttribute("type",cri.getType());
//		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/board/list"+cri.getListLink();
		
	}
	
	@ResponseBody //JSON 데이터를 반환시 사용
	@GetMapping(value = "/getAttachList" , produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		log.info("getAttachList................................ bno = " + bno);
		
		return new ResponseEntity<>(service.getAttachList(bno),HttpStatus.OK);
	}
	
	private void deleteFile(List<BoardAttachVO> attachList) {
		
		if(attachList == null || attachList.size() ==0) {
			return;
		}
		
		log.info(".......At BoardController delete attach file..........");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			
			try {
				Path file = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + 
						attach.getFileName());
				
				Files.delete(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					 Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_" 
				+ attach.getUuid()+"_"+ attach.getFileName());
					 Files.delete(thumbNail);
				}//end if
				
			} catch (Exception e) {
				log.error("delete file error ... " + e.getMessage());
			}//end catch
			
		});
	}//end deletefile method

}
