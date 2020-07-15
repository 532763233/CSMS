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
import java.sql.PreparedStatement;

@WebServlet("/addServlet")
public class addServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String type = req.getParameter("type");
        String name = req.getParameter("name");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String url = type+"Select.jsp";

        People people = new People();
        people.setName(name);
        people.setUsername(username);
        people.setPassword(password);

        PeopleDAO peopleDAO =new PeopleDAOImpl();
        int check = peopleDAO.check(type,username);
        if(check==1){
            String a= URLEncoder.encode("用户名已存在！", "UTF-8");
            resp.getWriter().write("<script>alert(decodeURIComponent('"+a+"')); window.window.location.href='"+url+"';</script>");
        }else {

            int count = peopleDAO.add(type,people);

            String a = URLEncoder.encode("添加成功！", "UTF-8");
            String b = URLEncoder.encode("添加失败！", "UTF-8");
            if (count!=0){
                try {
                    String shenfen="";
                    Connection conn = DBHelper.getConnection();
                    switch (type){
                        case "admin": shenfen="管理员";
                            break;
                        case "student": shenfen="学生";
                            break;
                        case "teacher": shenfen="教师";
                            break;
                    }
                    String sql="insert into log value(null,"+ req.getParameter("admin").split("-")[0]+",'"+req.getParameter("admin").split("-")[1]+"','添加','"+req.getParameter("time")+"','添加了一名新的"+shenfen+"："+name+"')";
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
}
