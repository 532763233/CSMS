package servlet;

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

@WebServlet("/setSafe")
public class setSafeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String type = req.getParameter("type");
        String id = req.getParameter("id");
        String url="safeSelect.jsp";

        try {
            Connection connection = DBHelper.getConnection();
            String sql="update "+ type +" set password=?,quest1=?,ans1=?,quest2=?,ans2=?,quest3=?,ans3=? where id="+id+"";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,req.getParameter("password"));
            ps.setString(2,req.getParameter("quest1"));
            ps.setString(3,req.getParameter("ans1"));
            ps.setString(4,req.getParameter("quest2"));
            ps.setString(5,req.getParameter("ans2"));
            ps.setString(6,req.getParameter("quest3"));
            ps.setString(7,req.getParameter("ans3"));

            int count = ps.executeUpdate();
            if (count!=0){
                req.setAttribute("login",'1');
                req.getRequestDispatcher(url).forward(req,resp);
            }else{
                req.setAttribute("login",'2');
                req.getRequestDispatcher(url).forward(req,resp);
            }


        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
