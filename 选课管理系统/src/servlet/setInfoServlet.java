package servlet;

import util.DBHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.lang.reflect.Type;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/setInfo")
public class setInfoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setHeader("Content-type", "application/json;charset=UTF-8");

        String type = req.getParameter("type");
        String id = req.getParameter("id");
        String url="informationSelect.jsp";

        try {
            Connection connection = DBHelper.getConnection();
            String sql="update "+ type +" set telephone=?,email=?,date=?,sex=?,signature=? where id="+id+"";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,req.getParameter("telephone"));
            ps.setString(2,req.getParameter("email"));
            ps.setString(3,req.getParameter("date"));
            ps.setString(4,req.getParameter("sex"));
            ps.setString(5,req.getParameter("signature"));

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
