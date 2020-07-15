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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.Year;

@WebServlet("/deleteServlet")
public class deleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String type = req.getParameter("type");
        String id =req.getParameter("id");
        String txt=req.getParameter("txt");
        String ret=req.getParameter("return");
        String a="",b="" ,url="" ;
        int count=0;

        if(ret=="" || ret==null){
            url = type+"Select.jsp";
        }else {
            url = ret+"Select.jsp";
        }
        if(id.contains(",")){
            String[] arr = id.split(",");
            for (int i = 0; i < arr.length; i++) {
                count=del(type,arr[i],req);
            }
        }else {
            count=del(type,id,req);
        }

        if (txt==null || txt.equals("")) {
            a = URLEncoder.encode("删除成功！", "UTF-8");
            b = URLEncoder.encode("删除失败！", "UTF-8");
        }else {
            a = URLEncoder.encode(txt+"成功！", "UTF-8");
            b = URLEncoder.encode(txt+"失败！", "UTF-8");
        }
        if (count<0){
            if(count==-1) a = URLEncoder.encode("该学生目前有课程正在学习，无法删除！", "UTF-8");
            else a=URLEncoder.encode("该教师目前有课程正在教授，无法删除！", "UTF-8");
            resp.getWriter().write("<script>alert(decodeURIComponent('"+a+"')); window.window.location.href='"+url+"';</script>");
        }else if (count!=0){
            resp.getWriter().write("<script>alert(decodeURIComponent('"+a+"')); window.window.location.href='"+url+"';</script>");
        }else {
            resp.getWriter().write("<script>alert(decodeURIComponent('"+b+"')); window.window.location.href='"+url+"';</script>");
        }

    }

    public int del(String type,String id,HttpServletRequest req) {
        try {
            PeopleDAO peopleDAO = new PeopleDAOImpl();
            CourseDAO courseDAO = new CourseDAOImpl();
            String name="";
            String shenfen="";
            String caozuo="删除";
            String reason="";
            String c_name="";
            String sql="";
            Connection conn = DBHelper.getConnection();
            ResultSet rs = courseDAO.select("select * from "+type+" where id=" + id + "");
            if (rs.next()) {
                if (!"sc".equals(type) && !"course".equals(type) && !"apply".equals(type)) name =  rs.getString("id")+"-"+rs.getString("name");
            }
        switch (type) {
            case "student":
                shenfen = "学生";
                reason="删除了一名"+shenfen+"："+name+"";
                rs = courseDAO.select("select * from sc where s_id=" + id + "");
                while (rs.next()){
                        if (req.getParameter("getday").compareTo( rs.getString("time_start"))>=0 && req.getParameter("getday").compareTo( rs.getString("time_end"))<=0){
                            return -1;
                        }
                }
                break;
            case "teacher":
                shenfen = "教师";
                reason="删除了一名"+shenfen+"："+name+"";
                rs = courseDAO.select("select * from course where t_id=" + id + "");
                if (rs.next()){
                    if (req.getParameter("getday").compareTo( rs.getString("time_start"))>=0 && req.getParameter("getday").compareTo( rs.getString("time_end"))<=0){
                        return -2;
                    }else{
                        Course course = new Course();
                        course.setC_name(rs.getString("c_name"));
                        course.setTime_start(rs.getString("time_start"));
                        course.setTime_end(rs.getString("time_end"));
                        course.setT_id(null);
                        course.setT_name(null);
                        course.setSelectable(rs.getString("selectable"));
                        course.setChoice(rs.getString("choice"));
                        courseDAO.courseUpdate("course",course,id);
                    }
                }
                break;
            case  "sc":
                rs = courseDAO.select("select * from sc where id=" + id + "");
                if (rs.next()) {
                    courseDAO.numUpdate(rs.getString("c_name"));
                    reason="删除了学生"+rs.getString("s_name")+"选修课程"+rs.getString("c_name")+"的记录";
                    c_name=rs.getString("c_name");
                }
                break;
            case "checkpeople":
                caozuo="拒绝";
                reason="拒绝了"+name.split("-")[1]+"注册"+shenfen+"账号的申请";
                break;
            case "course":
                rs = courseDAO.select("select * from course where id=" + id + "");
                if (rs.next()) {
                    reason="删除了课程："+rs.getString("c_name");
                }
                break;
            case "apply":
                caozuo="拒绝";
                rs = courseDAO.select("select * from apply where id=" + id + "");
                if (rs.next()) {
                    reason="拒绝了"+rs.getString("a_id")+"-"+rs.getString("a_name")+"的"+rs.getString("mold")+"："+rs.getString("c_name")+"的申请";
                }
                break;
        }

            sql = "insert into log value(null," + req.getParameter("admin").split("-")[0] + ",'" + req.getParameter("admin").split("-")[1] + "','"+caozuo+"','" + req.getParameter("time") + "','"+reason+"')";
            conn.prepareStatement(sql).executeUpdate();
            int count = peopleDAO.delete(type, id);
            if (!c_name.equals("")) courseDAO.numUpdate(c_name);
            return count;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}
