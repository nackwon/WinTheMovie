package kr.co.winthemovie.dao;

import kr.co.winthemovie.vo.UserVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Repository
public class UserDao {
    @Autowired
    private SqlSession sqlsession;

    public int join(UserVo userVo) {
        if(userVo.getUserpw()!=null) {
            int result = sqlsession.insert("users.joinbyemail", userVo);
            return result;
        }else{
            int result = sqlsession.insert("users.joinbynaver",userVo);
            return result;
        }
    }


    public String emailcheck(String email) {
        System.out.println("check");
        String result = sqlsession.selectOne("users.emailcheck", email);

        return result;
    }

    public UserVo login(UserVo userVo) {
        System.out.println("userdao 입장");
        UserVo vo = sqlsession.selectOne("users.login", userVo);
        System.out.println("userdao 퇴장"+vo.toString());

        return vo;
    }

    public UserVo loginbysns(UserVo userVo) {

        UserVo vo = sqlsession.selectOne("users.loginbynaver", userVo);

        return vo;
    }
}
