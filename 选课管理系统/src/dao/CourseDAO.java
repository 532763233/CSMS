package dao;

import entity.Course;

import java.sql.ResultSet;

public interface CourseDAO {

    //添加课程
    public int courseAdd(String type, Course course);

    //修改课程
    public int courseUpdate(String type, Course course,String id);

    //更新人数
    public void  numUpdate(String c_name);

    //查询
    public ResultSet select(String sql);

}
