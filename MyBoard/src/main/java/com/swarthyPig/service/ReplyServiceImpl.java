package com.swarthyPig.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.swarthyPig.domain.PageMaker;
import com.swarthyPig.domain.ReplyPageDTO;
import com.swarthyPig.domain.ReplyVO;
import com.swarthyPig.mapper.BoardMapper;
import com.swarthyPig.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService{

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper; // 트랙잭션 처리를 위해
	
	@Transactional
	@Override
	public int register(ReplyVO vo) {

		log.info("register->" + vo);
		
		boardMapper.updateReplyCnt(vo.getBno(), 1); // 게시글의 번호와 댓글의 증가
		
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		
		log.info("get->" + rno);
		
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {

		log.info("modify->" + vo);
		
		return mapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(Long rno) {

		log.info("remove->" + rno);
		
		ReplyVO vo = mapper.read(rno); // 댓글의 번호를 통해 해당 댓글의 게시물을 알아냄
		
		boardMapper.updateReplyCnt(vo.getBno(), -1); // 게시글의 번호와 댓글의 감소
		 
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(PageMaker pm, Long bno) {

		log.info("reply List->" + bno);
		
		return mapper.getListWithPaging(pm, bno);
	}

	@Override
	public ReplyPageDTO getListPage(PageMaker pm, Long bno) { // ReplyPageDTO를 통해 댓글의 전체갯수와 페이징 데이터를 넘긴다.
		
		return new ReplyPageDTO(
			mapper.getCountByBno(bno),
			mapper.getListWithPaging(pm, bno));
	}

}
