package servlet;

import Impl.CourseDAOImpl;
import Impl.PeopleDAOImpl;
import dao.CourseDAO;
import dao.PeopleDAO;
import entity.Course;
import util.DBHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/applyServlet")
public class applyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String id = req.getParameter("id");
        String url="checkcourseSelect.jsp";
        int count=0;

        if(id.contains(",")){
            String arr[] = id.split(",");
            for (int i = 0; i < arr.length; i++) {
                count = apply(arr[i],req);
            }
        }else {
            count = apply(id,req);
        }

        String a = URLEncoder.encode("通过成功！", "UTF-8");
        String b = URLEncoder.encode("通过失败！", "UTF-8");
        if (count!=0){
            resp.getWriter().write("<script>alert(decodeURIComponent('"+a+"')); window.window.location.href='"+url+"';</script>");
        }else{
            resp.getWriter().write("<script>alert(decodeURIComponent('"+b+"')); window.window.location.href='"+url+"';</script>");
        }
    }

    public int apply(String id,HttpServletRequest req){

        try {
            int count = 0;
            String sql="";

            Connection connection = DBHelper.getConnection();
            sql="select * from apply where id="+id+"";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            Course course = new Course();
            CourseDAO courseDAO = new CourseDAOImpl();
            PeopleDAO peopleDAO = new PeopleDAOImpl();
            if (rs.next()) {
                switch (rs.getString("mold")){
                    case "申请发布这门课程":
                        course.setC_name(rs.getString("c_name"));
                        course.setTime_start(rs.getString("time_start"));
                        course.setTime_end(rs.getString("time_end"));
                        course.setT_id(rs.getString("a_id"));
                        course.setT_name(rs.getString("a_name"));
                        course.setSelectable("200");
                        count = courseDAO.courseAdd("course", course);
                        break;
                    case "申请不学习这门课程":
                        String s_id = rs.getString("a_id");
                        String c_name = rs.getString("c_name");
                        sql="delete from sc where s_id="+s_id+" and c_name='"+c_name+"'";
                        count = connection.prepareStatement(sql).executeUpdate();
                        break;
                    case "申请不教授这门课程":
                        c_name = rs.getString("c_name");
                        sql="update course set t_id=null,t_name =null where c_name='"+c_name+"'";
                        count = connection.prepareStatement(sql).executeUpdate();
                        break;
                }
                peopleDAO.delete("apply",id);

                sql = "insert into log value(null," + req.getParameter("admin").split("-")[0] + ",'" + req.getParameter("admin").split("-")[1] + "','通过','" + req.getParameter("time") + "','通过了"+rs.getString("a_id")+"-"+rs.getString("a_name")+"的"+rs.getString("mold")+"："+rs.getString("c_name")+"的申请')";
                connection.prepareStatement(sql).executeUpdate();
            }

            return count;

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }

    }


}
