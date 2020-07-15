package servlet;

import util.DBHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/forget")
public class forgetServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String type=req.getParameter("type");
        String username=req.getParameter("username");

        try {
            Connection connection = DBHelper.getConnection();
            String sql = "select * from "+type+" where username=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,username);

            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                req.setAttribute("type",type);
                req.setAttribute("id",rs.getString("id"));
                req.setAttribute("quest1",rs.getString("quest1"));
                req.setAttribute("quest2",rs.getString("quest2"));
                req.setAttribute("quest3",rs.getString("quest3"));
                if (rs.getString("quest1")==null ){
                    req.setAttribute("forget",'0');
                }else {
                    req.setAttribute("forget",'2');
                }
            }else{
                req.setAttribute("forget",'0');
            }
            req.getRequestDispatcher("forget.jsp").forward(req,resp);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
