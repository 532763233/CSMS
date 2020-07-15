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
import java.net.URLEncoder;
import java.sql.Connection;

@WebServlet("/courseUpdate")
public class courseUpdate extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String type = req.getParameter("type");
        String id = req.getParameter("id");
        String ret = req.getParameter("return");
        String url="";

        String c_name = req.getParameter("c_name");
        String time_start = req.getParameter("time_start");
        String time_end = req.getParameter("time_end");
        String selectable = req.getParameter("selectable");
        String choice = req.getParameter("open");

        int count=0;
        if (ret!=null && !ret.equals("")){
            url = ret + "Select.jsp";
        }else {
            url = type + "Select.jsp";
        }

        if(id.contains(",")){
            String[] arr = id.split(",");
            String[] brr = c_name.split(",");
            String[] crr = time_start.split(",");
            String[] drr = time_end.split(",");
            String[] err = selectable.split(",");
            String[] frr = choice.split(",");
            for (int i = 0; i < arr.length; i++) {
                count=update(type,arr[i],brr[i],crr[i],drr[i],err[i],frr[i],req);
            }
        }else {
            count=update(type,id,c_name,time_start,time_end,selectable,choice,req);
        }

        String a="",b="";
        if (ret!=null && !ret.equals("")){
            a = URLEncoder.encode("执教成功！", "UTF-8");
            b = URLEncoder.encode("执教失败！", "UTF-8");
        }else {
            a = URLEncoder.encode("修改成功！", "UTF-8");
            b = URLEncoder.encode("修改失败！", "UTF-8");
        }

        if (count!=0){
            resp.getWriter().write("<script>alert(decodeURIComponent('"+a+"')); window.window.location.href='"+url+"';</script>");
        }else{
            resp.getWriter().write("<script>alert(decodeURIComponent('"+b+"')); window.window.location.href='"+url+"';</script>");
        }
    }

    public int update(String type,String id,String c_name,String time_start,String time_end,String selectable,String choice,HttpServletRequest req){

            String t_id = req.getParameter("teacher").split("-")[0];
            String t_name = req.getParameter("teacher").split("-")[1];

            CourseDAO courseDAO = new CourseDAOImpl();

            if(choice==null){choice="false";}

            Course course =new Course();
            course.setC_name(c_name);
            course.setTime_start(time_start);
            course.setTime_end(time_end);
            course.setT_id(t_id);
            course.setT_name(t_name);
            course.setSelectable(selectable);
            course.setChoice(choice);

            int count = courseDAO.courseUpdate(type,course,id);
            if (req.getParameter("admin")!=null) {
                try {
                    Connection conn = DBHelper.getConnection();
                    String sql = "insert into log value(null," + req.getParameter("admin").split("-")[0] + ",'" + req.getParameter("admin").split("-")[1] + "','修改','" + req.getParameter("time") + "','修改了课程：" + c_name + "的课程信息')";
                    conn.prepareStatement(sql).executeUpdate();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            return count;

    }
}
