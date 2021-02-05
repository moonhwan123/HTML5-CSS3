package org.moon.controller;

import java.util.List;

import org.moon.domain.BoardVO;
import org.moon.domain.Criteria;
import org.moon.domain.PageDTO;
import org.moon.service.BoardService;
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
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	
	@Setter(onMethod_ = @Autowired)
	private BoardService boardService;
	
	
	@GetMapping("/boardList")
	public void boardListGet(Criteria cri,Model model) {
		
		log.info("At BoardController ...... boardListGet()......");
		log.info("Board pageNum : " + cri.getPageNum() + " // Board Amount : " + cri.getAmount());
		log.info("Board type : " + cri.getType() + " // Board keyword : " + cri.getKeyword());
		
		int total = boardService.totalCount(cri);
		
		log.info("Total count : " + total);
		
		List<BoardVO> boardList = boardService.boardList(cri);
		
		model.addAttribute("boardList",boardList);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	
	@GetMapping("/boardRegister")
	public void boardRegisterGet() {
		log.info("At BoardController ...... boardRegisterGet()......");
	}
	
	@PostMapping("/boardRegister")
	public String boardRegisterPost(BoardVO vo,RedirectAttributes rttr) {
		log.info("At BoardController ...... boardRegisterPost()......");
		
		log.info(vo.getBno());
		
		boardService.boardRegister(vo);
		
		rttr.addFlashAttribute("result",vo.getBno());
		
		return "redirect:/board/boardList";
	}
	
	@GetMapping({"/boardRead","/boardModify"})
	public void boardReadGet(@RequestParam("bno") Long bno,@ModelAttribute("cri") Criteria cri,Model model) {
		log.info("At BoardController ...... boardReadGet()......or boardModify");
		log.info("Read Bno : " + bno);
		log.info("이전 페이지에서 넘어온 cri 정보 : " + cri);
		
		model.addAttribute("board",boardService.boardRead(bno));
		
	}
	
	@PostMapping("/boardModify")
	public String boardModifyPost(BoardVO vo, @ModelAttribute("cri")Criteria cri,RedirectAttributes rttr) {
		log.info("At BoardController ......  boardModifyPost()");
		log.info("수정 할려는 게시물 번호 : " + vo.getBno());
		log.info("이전 페이지에서 넘어온 cri 정보 : " + cri);
		
		if(boardService.boardModify(vo)) {
			rttr.addFlashAttribute("result","success modify");
		}
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/board/boardList";
	}
	
	@PostMapping("/boardRemove")
	public String boardRemovePost(BoardVO vo,@ModelAttribute("cri")Criteria cri,RedirectAttributes rttr) {
		log.info("At BoardController ......  boardRemovePost()");
		log.info("삭제 하는 게시물 번호 : " + vo.getBno());
		log.info("이전 페이지에서 넘어온 cri 정보 : " + cri);
		
		if(boardService.boardRemove(vo)) {
			rttr.addFlashAttribute("result","success remove");
		}
		
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/board/boardList";
	}
	
}
