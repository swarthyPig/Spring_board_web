package com.swarthyPig.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.swarthyPig.domain.BoardVO;
import com.swarthyPig.domain.PageMaker;

public interface BoardMapper {
	
	
	public List<BoardVO> getList(); // 게시글의 목록을 불러옴

	public List<BoardVO> getListWithPaging(PageMaker pm); // 페이징 처리
	
	public int getTotalCount(PageMaker pm); // 게시글의 전체 수를 구함, 목록과 전체 데이터 개수는 항상 같이 동작하므로 PageMaker파라미터 같이 지정
	
	public void insert(BoardVO board); // insert만 처리, pk값 알 필요없음
	 
	public void insertSelectKey(BoardVO board); // insert 처리 후 생성된 pk값을 따로 저장해놓고 사용하기위함
	
	public BoardVO read(Long bno); // insert된 특정 게시글 조회(BoardVO 클래스의 bno정보를 이용)
	
	public int delete(Long bno); // pk값을 이용하여 데이터 삭제, 타입은 int로 설정해서 정상적으로 삭제되면 1이상의 값을 가진다. 게시물이 없다면 0이 출력됨
	
	public int update(BoardVO board); // 최종 수정시간을 데이터베이스 내 현재 시간으로 수정, 몇개의 데이터가 수정되었는가 알기위해 int타입으로설정
	
	// amount : 댓글의 증가 감소
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
	
}
