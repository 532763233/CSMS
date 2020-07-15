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

@WebServlet("/addapply")
public class addapplyList extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String[] c_name=req.getParameter("c_name").split(",");
        String[] time_start=req.getParameter("time_start").split(",");
        String[] time_end=req.getParameter("time_end").split(",");
        String[] t_id=req.getParameter("t_id").split(",");
        String[] t_name=req.getParameter("t_name").split(",");
        String reason=req.getParameter("reason");
        String ret=req.getParameter("ret");
        String mold=req.getParameter("mold");
        String type="apply";
        String url=ret+"Select.jsp";

        CourseDAO courseDAO = new CourseDAOImpl();
        for (int i = 0; i < c_name.length; i++) {
            Course course = new Course();
            course.setC_name(c_name[i]);
            course.setTime_start(time_start[i]);
            course.setTime_end(time_end[i]);
            course.setT_id(t_id[i]);
            course.setT_name(t_name[i]);
            course.setMold(mold);
            course.setReason(reason);

            int count =courseDAO.courseAdd(type,course);
            String a = URLEncoder.encode("已提交申请，请耐心等候！", "UTF-8");
            String b = URLEncoder.encode("提交申请失败！", "UTF-8");
            if (count != 0) {
                resp.getWriter().write("<script>alert(decodeURIComponent('" + a + "')); window.window.location.href='" + url + "';</script>");
            } else {
                resp.getWriter().write("<script>alert(decodeURIComponent('" + b + "')); window.window.location.href='" + url + "';</script>");
            }
        }

    }
}
