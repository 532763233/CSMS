package servlet;

import Impl.CourseDAOImpl;
import dao.CourseDAO;
import entity.Course;
import util.DBHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.Socket;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/courseAdd")
public class courseAdd extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String type = req.getParameter("type");
        String c_name = req.getParameter("c_name");
        String timestart = req.getParameter("timestart");
        String timeend = req.getParameter("timeend");
        String selectable = req.getParameter("num");
        String mold=req.getParameter("mold");
        String reason=req.getParameter("reason");
        String ret = req.getParameter("return");
        String txt=req.getParameter("txt");
        String url="";
        String a="",b="";
        if (ret!=null && !ret.equals("")){
            url = ret + "Select.jsp";
        }else {
            url = type + "Select.jsp";
        }
        boolean bool=true;

        String teacher = req.getParameter("teacher");
        String t_id="";
        String t_name="";
        String student = req.getParameter("student");
        String s_id="";
        String s_name="";
        try {
        Course course = new Course();
        Connection conn = DBHelper.getConnection();
        CourseDAO courseDAO = new CourseDAOImpl();

            if (student != null && student != "") {
                s_id = student.split("-")[0];
                s_name = student.split("-")[1];

                String sql = "select * from sc where c_name='" + c_name + "' and s_id='" + s_id + "'";
                if (courseDAO.select(sql).next()) {
                    bool=false;
                    a = URLEncoder.encode("该选课已存在，请勿重复选课！", "UTF-8");
                    resp.getWriter().write("<script>alert(decodeURIComponent('" + a + "')); window.window.location.href='" + url + "';</script>");
                }

                    ResultSet rs = courseDAO.select("select * from course where c_name='" + c_name + "'");

                    if (rs.next()) {

                        timestart = rs.getString("time_start");
                        timeend = rs.getString("time_end");
                        course.setT_id(rs.getString("t_id"));
                        course.setT_name(rs.getString("t_name"));
                        course.setS_id(s_id);
                        course.setS_name(s_name);
                        if (req.getParameter("admin")!=null && req.getParameter("admin")!="") {
                            sql = "insert into log value(null," + req.getParameter("admin").split("-")[0] + ",'" + req.getParameter("admin").split("-")[1] + "','添加','" + req.getParameter("time") + "','添加了一个新的选课记录：" + s_name + "选修了课程" + c_name + "')";
                            conn.prepareStatement(sql).executeUpdate();
                        }
                    }
            } else {
                course.setSelectable(selectable);
                if (teacher != "" && teacher != null) {
                    course.setMold(mold);
                    course.setReason(reason);
                    t_id = teacher.split("-")[0];
                    t_name = teacher.split("-")[1];
                    course.setT_id(t_id);
                    course.setT_name(t_name);
                }
                if (!"apply".equals(type)){
                    String sql="insert into log value(null,"+ req.getParameter("admin").split("-")[0]+",'"+req.getParameter("admin").split("-")[1]+"','添加','"+req.getParameter("time")+"','添加了新课程："+c_name+"')";
                    conn.prepareStatement(sql).executeUpdate();
                }
            }

        course.setC_name(c_name);
        course.setTime_start(timestart);
        course.setTime_end(timeend);

        if ("apply".equals(type)){
            bool=false;
            int count = courseDAO.courseAdd(type, course);
                a = URLEncoder.encode("已提交申请，请耐心等候！", "UTF-8");
                b = URLEncoder.encode("提交申请失败！", "UTF-8");
            if (count != 0) {
                resp.getWriter().write("<script>alert(decodeURIComponent('" + a + "')); window.window.location.href='" + url + "';</script>");
            } else {
                resp.getWriter().write("<script>alert(decodeURIComponent('" + b + "')); window.window.location.href='" + url + "';</script>");
            }
        }

        if (bool) {
            int count = courseDAO.courseAdd(type, course);
            if (txt == "" || txt == null) {
                a = URLEncoder.encode("添加成功！", "UTF-8");
                b = URLEncoder.encode("添加失败！", "UTF-8");
            } else {
                a = URLEncoder.encode(txt + "成功！", "UTF-8");
                b = URLEncoder.encode(txt + "失败！", "UTF-8");
            }
            if (count != 0) {
                resp.getWriter().write("<script>alert(decodeURIComponent('" + a + "')); window.window.location.href='" + url + "';</script>");
            } else {
                resp.getWriter().write("<script>alert(decodeURIComponent('" + b + "')); window.window.location.href='" + url + "';</script>");
            }
        }
        } catch (Exception e) {
            e.printStackTrace();
        }
        }

}
