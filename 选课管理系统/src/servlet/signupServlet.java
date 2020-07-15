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
import java.sql.ResultSet;

@WebServlet("/signup")
public class signupServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String name =req.getParameter("name");
        String username=req.getParameter("username");
        String password=req.getParameter("password");
        String type=req.getParameter("select");
        String sql;
        try {
            Connection connection= DBHelper.getConnection();
            sql="select * from "+type+" where username=?";
            PreparedStatement ps =connection.prepareStatement(sql);
            ps.setString(1,username);

            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                String a= URLEncoder.encode("用户名已存在！", "UTF-8");
                resp.getWriter().write("<script>alert(decodeURIComponent('"+a+"')); window.window.location.href='login.jsp';</script>");
            }else {

                sql="select * from checkpeople where username=?";
                ps =connection.prepareStatement(sql);
                ps.setString(1,username);

                rs = ps.executeQuery();
                if (rs.next()){
                    String a= URLEncoder.encode("用户名已存在！", "UTF-8");
                    resp.getWriter().write("<script>alert(decodeURIComponent('"+a+"')); window.window.location.href='login.jsp';</script>");
                }else {

                    sql = "insert into checkpeople value(null,?,?,?,?)";
                    ps = connection.prepareStatement(sql);
                    ps.setString(1, type);
                    ps.setString(2, name);
                    ps.setString(3, username);
                    ps.setString(4, password);

                    int count = ps.executeUpdate();
                    String a = URLEncoder.encode("已提交审核，请耐心等待！", "UTF-8");
                    String b = URLEncoder.encode("提交审核失败！", "UTF-8");
                    if (count != 0) {
                        resp.getWriter().write("<script>alert(decodeURIComponent('" + a + "')); window.window.location.href='login.jsp';</script>");
                    } else {
                        resp.getWriter().write("<script>alert(decodeURIComponent('" + b + "')); window.window.location.href='login.jsp';</script>");
                    }
                }

            }


        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
