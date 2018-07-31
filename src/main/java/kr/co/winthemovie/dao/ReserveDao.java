package kr.co.winthemovie.dao;

import java.util.List;

import kr.co.winthemovie.vo.QuickReserveVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.winthemovie.vo.TheaterVo;

@Repository
public class ReserveDao {
	
	@Autowired
	private SqlSession sqlsession;
	
	public List<TheaterVo> selectByTheater(String address) {
		return sqlsession.selectList("theater.SelectByReserveTheater", address);
	}
	
	public List<TheaterVo> selectByOneTheater(int theaterno) {
		return sqlsession.selectList("theater.SelectByOneTheater", theaterno);
	}

	public QuickReserveVo getQuickReserve(int nowplayingno){
		return sqlsession.selectOne("movie.getQuickReserve",nowplayingno);
	}
}
