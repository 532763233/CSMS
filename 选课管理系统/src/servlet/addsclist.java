package servlet;

import Impl.CourseDAOImpl;
import dao.CourseDAO;
import entity.Course;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;

@WebServlet("/addsc")
public class addsclist extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String[] c_name=req.getParameter("c_name").split(",");
        String[] time_start=req.getParameter("time_start").split(",");
        String[] time_end=req.getParameter("time_end").split(",");
        String[] t_id=req.getParameter("t_id").split(",");
        String[] t_name=req.getParameter("t_name").split(",");
        String s_id=req.getParameter("s_id");
        String s_name=req.getParameter("s_name");
        String type=req.getParameter("type");
        String url=req.getParameter("return")+"Select.jsp";

        CourseDAO courseDAO = new CourseDAOImpl();
        for (int i = 0; i < c_name.length; i++) {
            Course course = new Course();
            course.setC_name(c_name[i]);
            course.setTime_start(time_start[i]);
            course.setTime_end(time_end[i]);
            course.setT_id(t_id[i]);
            course.setT_name(t_name[i]);
            course.setS_id(s_id);
            course.setS_name(s_name);

            String sql = "select * from sc where c_name='" + c_name[i] + "' and s_id='" + s_id + "'";
            try {
                if (courseDAO.select(sql).next()) {
                    String a = URLEncoder.encode("该选课已存在，请勿重复选课！", "UTF-8");
                    resp.getWriter().write("<script>alert(decodeURIComponent('" + a + "')); window.window.location.href='" + url + "';</script>");
                }else{
                    int count = courseDAO.courseAdd(type, course);
                    String a = URLEncoder.encode("选课成功！", "UTF-8");
                    String b = URLEncoder.encode("选课失败！", "UTF-8");
                    if (count != 0) {
                        resp.getWriter().write("<script>alert(decodeURIComponent('" + a + "')); window.window.location.href='" + url + "';</script>");
                    } else {
                        resp.getWriter().write("<script>alert(decodeURIComponent('" + b + "')); window.window.location.href='" + url + "';</script>");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
