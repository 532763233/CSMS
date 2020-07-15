package Impl;

import dao.CourseDAO;
import entity.Course;
import util.DBHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CourseDAOImpl implements CourseDAO {
    @Override
    public int courseAdd(String type, Course course) {
        String sql="";
        try {
            Connection connection = DBHelper.getConnection();
            PreparedStatement ps = null;
            switch (type){
                case "course":
                    if (course.getT_id()==null){
                        sql = "insert into course (c_name,time_start,time_end,selectable,num,choice) value(?,?,?,?,0,false)";
                        ps = connection.prepareStatement(sql);
                    }else {
                        sql = "insert into course (c_name,time_start,time_end,selectable,t_id,t_name,num,choice)  value(?,?,?,?,?,?,0,true);";
                        ps = connection.prepareStatement(sql);
                        ps.setInt(5,Integer.parseInt(course.getT_id()));
                        ps.setString(6,course.getT_name());
                    }
                    ps.setInt(4,Integer.parseInt(course.getSelectable()));
                    break;
                case "sc":
                    sql = "insert into sc  value(null,?,?,?,?,?,?,?);";
                    ps = connection.prepareStatement(sql);
                    ps.setInt(4,Integer.parseInt(course.getT_id()));
                    ps.setString(5,course.getT_name());
                    ps.setInt(6,Integer.parseInt(course.getS_id()));
                    ps.setString(7,course.getS_name());

                    connection.prepareStatement("update course set num=num+1 where c_name='"+course.getC_name()+"'").executeUpdate();
                    break;
                case "apply":
                        sql = "insert into apply(c_name,time_start,time_end,a_id,a_name,mold,reason)  value(?,?,?,?,?,?,?);";
                        ps = connection.prepareStatement(sql);
                        ps.setInt(4,Integer.parseInt(course.getT_id()));
                        ps.setString(5,course.getT_name());
                        ps.setString(6,course.getMold());
                        ps.setString(7,course.getReason());

                    break;
                default:
            }
            ps.setString(1,course.getC_name());
            ps.setString(2,course.getTime_start());
            ps.setString(3,course.getTime_end());

            int count = ps.executeUpdate();
            ps.close();
            return count;

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }

    }

    @Override
    public int courseUpdate(String type, Course course, String id) {

        try {

            String sql="";
            Connection connection = DBHelper.getConnection();
            PreparedStatement ps=null;
            if("sc".equals(type)){
                sql = "update sc set c_name=?,time_start=?,time_end=?,t_id=?,t_name=?,s_id=?,s_name=? where id=?";
                ps = connection.prepareStatement(sql);
                ps.setInt(6,Integer.parseInt(course.getS_id()));
                ps.setString(7,course.getS_name());
                ps.setInt(8,Integer.parseInt(id));
            }else{
                sql = "update course set c_name=?,time_start=?,time_end=?,t_id=?,t_name=?,selectable=?,choice=? where id=?";
                ps = connection.prepareStatement(sql);
                ps.setString(6,course.getSelectable());
                ps.setBoolean(7,Boolean.parseBoolean(course.getChoice()));
                ps.setInt(8,Integer.parseInt(id));

            }

            ps.setString(1,course.getC_name());
            ps.setString(2,course.getTime_start());
            ps.setString(3,course.getTime_end());
            ps.setInt(4,Integer.parseInt(course.getT_id()));
            ps.setString(5,course.getT_name());

            int count = ps.executeUpdate();
            ps.close();
            return count;

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public void numUpdate(String c_name) {

        try {
            Connection connection = DBHelper.getConnection();
            String sql = "update course set num=(select  COUNT(*) from sc where c_name='"+c_name+"') where c_name='"+c_name+"'";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.executeUpdate();
            ps.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public ResultSet select(String sql) {

        try {
            Connection connection = DBHelper.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            return rs;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
