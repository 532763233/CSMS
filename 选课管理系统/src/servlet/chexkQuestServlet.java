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

@WebServlet("/checkQuest")
public class chexkQuestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String type = req.getParameter("type");
        String quest = req.getParameter("quest");
        String id = req.getParameter("id");

        try {
            Connection connection = DBHelper.getConnection();
            String sql = "select * from "+type+" where ans"+quest+"=? and id="+id+"";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,req.getParameter("ans"));

            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                req.setAttribute("type",type);
                req.setAttribute("id",id);
                if (rs.getString("quest1")==null ){
                    req.setAttribute("forget",'0');
                }else {
                    req.setAttribute("forget",'3');
                }
            }else{
                req.setAttribute("forget",'4');
            }
            req.getRequestDispatcher("forget.jsp").forward(req,resp);

            } catch (Exception e) {
                e.printStackTrace();
            }


    }
}
