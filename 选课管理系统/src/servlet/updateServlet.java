package servlet;

import Impl.PeopleDAOImpl;
import dao.PeopleDAO;
import entity.People;
import util.DBHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;

@WebServlet("/updateServlet")
public class updateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String type = req.getParameter("type");
        String id = req.getParameter("id");
        String url = type+"Select.jsp";

        String name = req.getParameter("name");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        People people = new People();
        people.setName(name);
        people.setUsername(username);
        people.setPassword(password);

        PeopleDAO peopleDAO = new PeopleDAOImpl();
        int count = peopleDAO.update(type,people,id);

        String a = URLEncoder.encode("修改成功！", "UTF-8");
        String b = URLEncoder.encode("修改失败！", "UTF-8");
        if (count!=0){
            try {
                String shenfen="";
                Connection conn = DBHelper.getConnection();
                switch (type){
                    case "student": shenfen="学生";
                        break;
                    case "teacher": shenfen="教师";
                        break;
                }
                String sql="insert into log value(null,"+ req.getParameter("admin").split("-")[0]+",'"+req.getParameter("admin").split("-")[1]+"','修改','"+req.getParameter("time")+"','修改了"+shenfen+"："+id+"-"+name+"的账号信息')";
                conn.prepareStatement(sql).executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.getWriter().write("<script>alert(decodeURIComponent('"+a+"')); window.window.location.href='"+url+"';</script>");
        }else{
            resp.getWriter().write("<script>alert(decodeURIComponent('"+b+"')); window.window.location.href='"+url+"';</script>");
        }
    }
}
