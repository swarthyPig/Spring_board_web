package com.swarthyPig.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.swarthyPig.domain.PageMaker;
import com.swarthyPig.domain.ReplyVO;

public interface ReplyMapper {
	
	public int insert(ReplyVO vo); // 등록 작업
	
	public ReplyVO read(Long bno); // 특정 댓글 조회 작업
	
	public int update(ReplyVO reply); // 수정 작업
	
	public int delete(Long rno); // 삭제 작업
	
	public List<ReplyVO> getListWithPaging(@Param("pm") PageMaker pm, @Param("bno") Long bno); // @Param으로 2개 이상의 데이터(pm, bno)를 전달, 해당 페이지의 댓글 리스트
	
	public int getCountByBno(Long bno);
	
	
}
