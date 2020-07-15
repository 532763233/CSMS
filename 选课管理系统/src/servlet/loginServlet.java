package servlet;

import util.DBHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/login")
public class loginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String username=req.getParameter("username");
        String password=req.getParameter("password");
        String type=req.getParameter("select");

        try {
            Connection connection = DBHelper.getConnection();
            String sql = "select * from  "+type+" where  username=? and password=?";
            PreparedStatement ps=connection.prepareStatement(sql);
            ps.setString(1,username);
            ps.setString(2,password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()){
                HttpSession session=req.getSession();
                session.setAttribute("id",rs.getString("id"));
                session.setAttribute("name",rs.getString("name"));
                session.setAttribute("username",rs.getString("username"));
                session.setAttribute("password",rs.getString("password"));
                session.setAttribute("telephone",rs.getString("telephone")==null?"":rs.getString("telephone"));
                session.setAttribute("email",rs.getString("email")==null?"":rs.getString("email"));
                session.setAttribute("date",rs.getString("date"));
                session.setAttribute("sex",rs.getString("sex"));
                session.setAttribute("quest1",rs.getString("quest1")==null?"":rs.getString("quest1"));
                session.setAttribute("ans1",rs.getString("ans1")==null?"":rs.getString("ans1"));
                session.setAttribute("quest2",rs.getString("quest1")==null?"":rs.getString("quest2"));
                session.setAttribute("ans2",rs.getString("ans1")==null?"":rs.getString("ans2"));
                session.setAttribute("quest3",rs.getString("quest1")==null?"":rs.getString("quest3"));
                session.setAttribute("ans3",rs.getString("ans1")==null?"":rs.getString("ans3"));
                session.setAttribute("signature",rs.getString("signature")==null?"":rs.getString("signature"));
                session.setAttribute("type",type);
                resp.sendRedirect("admin.jsp");
            }else {
                String a= URLEncoder.encode("用户名或密码错误！", "UTF-8");
                resp.getWriter().write("<script>alert(decodeURIComponent('"+a+"')); window.window.location.href='login.jsp';</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
