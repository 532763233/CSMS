package Impl;

import dao.PeopleDAO;
import entity.People;
import util.DBHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PeopleDAOImpl implements PeopleDAO {

    //查询人员
    @Override
    public List<Map<String, Object>> select(String sql) {
        try {
            Connection connection= DBHelper.getConnection();
            PreparedStatement preparedStatement=connection.prepareStatement(sql);
            ResultSet rs = preparedStatement.executeQuery();

            ResultSetMetaData resultSetMetaData =  preparedStatement.getMetaData();
            int column =  resultSetMetaData.getColumnCount();

            List<Map<String,Object>> list=new ArrayList<>();
            while(rs.next()) {
                HashMap<String, Object> data = new HashMap<>();
                for (int i =1;i<=column;i++) {
                    data.put(resultSetMetaData.getColumnLabel(i), rs.getObject(resultSetMetaData.getColumnLabel(i)));

                }
                list.add(data);

            }
            preparedStatement.close();
            return list;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    //删除人员
    @Override
    public int delete(String type, String id) {
        try {
            Connection connection= DBHelper.getConnection();
            String sql="delete  from "+type+" where id=?";
            PreparedStatement ps=connection.prepareStatement(sql);
            ps.setString(1,id);
            int count=ps.executeUpdate();
            ps.close();
            return count;
        } catch (Exception e) {
            return 0;
        }
    }

    //添加人员
    @Override
    public int add(String type, People people) {

        try {
            Connection connection = DBHelper.getConnection();
            String sql="insert into "+type+"(name,username,password) value(?,?,?);";
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1,people.getName());
            ps.setString(2,people.getUsername());
            ps.setString(3,people.getPassword());

            int count = ps.executeUpdate();
            ps.close();
            return count;

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }

    }

    //修改人员
    @Override
    public int update(String type, People people, String id) {

        try {
            Connection connection=DBHelper.getConnection();
            String sql = "update "+type+" set name=?,username=?,password=? where id=?;";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,people.getName());
            ps.setString(2,people.getUsername());
            ps.setString(3,people.getPassword());
            ps.setString(4,id);

            int count = ps.executeUpdate();
            ps.close();
            return count;

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }

    }

    @Override
    public int check(String type, String username) {

        try {
            Connection connection=DBHelper.getConnection();
            String sql = "select * from "+type+" where username=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,username);

            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return 1;
            }else {
                return 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return  0;
        }
    }
}
