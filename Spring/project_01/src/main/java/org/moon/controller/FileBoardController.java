package org.moon.controller;

import java.util.List;

import org.moon.domain.Criteria;
import org.moon.domain.FileBoardVO;
import org.moon.domain.PageDTO;
import org.moon.service.FileBoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/fileBoard/*")
@AllArgsConstructor
public class FileBoardController {
	
	@Setter(onMethod_ = @Autowired)
	private FileBoardService fileBoardService;
	
	
	@GetMapping("/fileBoardList")
	public void fileBoardListGet(Criteria cri,Model model) {
		
		log.info("At fileBoardController ...... fileBoardListGet()......");
		log.info("Board pageNum : " + cri.getPageNum() + " // Board Amount : " + cri.getAmount());
		log.info("Board type : " + cri.getType() + " // Board keyword : " + cri.getKeyword());
		
		int total = fileBoardService.totalCount(cri);
		
		log.info("Total count : " + total);
		
		List<FileBoardVO> fileBoardList = fileBoardService.fileBoardList(cri);
		
		model.addAttribute("boardList",fileBoardList);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	
	@GetMapping("/fileBoardRegister")
	public void fileBoardRegisterGet() {
		log.info("At fileBoardController ...... fileBoardRegisterGet()......");
	}
	
	@PostMapping("/fileBoardRegister")
	public String fileBoardRegisterPost(FileBoardVO vo,RedirectAttributes rttr) {
		log.info("At fileBoardController ...... fileBoardRegisterPost()......");
		
		log.info(vo.getBno());
		
		fileBoardService.fileBoardRegister(vo);
		
		rttr.addFlashAttribute("result",vo.getBno());
		
		return "redirect:/fileBoard/fileBoardList";
	}
	
	@GetMapping({"/fileBoardRead","/fileBoardModify"})
	public void fileBoardReadGet(@RequestParam("bno") Long bno,@ModelAttribute("cri") Criteria cri,Model model) {
		log.info("At FileBoardController ...... fileBoardReadGet()......or fileBoardModify");
		log.info("Read Bno : " + bno);
		log.info("이전 페이지에서 넘어온 cri 정보 : " + cri);
		
		model.addAttribute("board",fileBoardService.fileBoardRead(bno));
		
	}
	
	@PostMapping("/fileBoardModify")
	public String fileBoardModifyPost(FileBoardVO vo, @ModelAttribute("cri")Criteria cri,RedirectAttributes rttr) {
		log.info("At fileBoardController ......  fileBoardModifyPost()");
		log.info("수정 할려는 게시물 번호 : " + vo.getBno());
		log.info("이전 페이지에서 넘어온 cri 정보 : " + cri);
		
		if(fileBoardService.fileBoardModify(vo)) {
			rttr.addFlashAttribute("result","success modify");
		}
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/fileBoard/fileBoardList";
	}
	
	@PostMapping("/fileBoardRemove")
	public String fileBoardRemovePost(FileBoardVO vo,@ModelAttribute("cri")Criteria cri,RedirectAttributes rttr) {
		log.info("At fileBoardController ......  fileBoardRemovePost()");
		log.info("삭제 하는 게시물 번호 : " + vo.getBno());
		log.info("이전 페이지에서 넘어온 cri 정보 : " + cri);
		
		if(fileBoardService.fileBoardRemove(vo)) {
			rttr.addFlashAttribute("result","success remove");
		}
		
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/fileBoard/fileBoardList";
	}
	
}
