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
import org.springframework.web.bind.annotation.RequestMapping;

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
		log.info("At BoardController ...... boardListGet......");
		log.info("Board pageNum : " + cri.getPageNum() + "// Board Amount : " + cri.getAmount());
		
		int total = boardService.totalCount();
		
		List<BoardVO> boardList = boardService.boardList(cri);
		
		model.addAttribute("boardList",boardList);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
}
