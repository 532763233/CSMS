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

@WebServlet("/passUpdate")
public class passUpdateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String type = req.getParameter("type");
        String id = req.getParameter("id");

        try {
            Connection connection = DBHelper.getConnection();
            String sql = "update "+type+" set password=? where id="+id+"";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,req.getParameter("password"));

            int count = ps.executeUpdate();
            String a = URLEncoder.encode("修改成功！", "UTF-8");
            String b = URLEncoder.encode("修改失败！", "UTF-8");
            if (count != 0){
                resp.getWriter().write("<script>alert(decodeURIComponent('"+a+"')); window.window.location.href='login.jsp';</script>");
            }else{
                resp.getWriter().write("<script>alert(decodeURIComponent('"+b+"')); window.window.location.href='login.jsp';</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
