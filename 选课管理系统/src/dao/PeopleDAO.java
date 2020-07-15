package dao;

import entity.People;

import java.util.List;
import java.util.Map;

public interface PeopleDAO {

    //查询人员{返回json}
    public List<Map<String,Object>> select(String sql);

    //删除人员
    public int delete(String type,String id);

    //添加人员
    public int add(String type, People people);

    //修改人员
    public int update(String type, People people, String id);

    //检查用户名是否重复
    public int check(String type,String username);

}
