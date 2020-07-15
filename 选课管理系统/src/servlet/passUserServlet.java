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
import java.lang.reflect.Type;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/passServlet")
public class passUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String id = req.getParameter("id");

            String url = "checkpeopleSelect.jsp";
            int count=0;

            if(id.contains(",")){
                String[] arr = id.split(",");
                for (int i = 0; i < arr.length; i++) {
                    count = pass(arr[i],req);
                }
            }else {
                count = pass(id,req);
            }

            String a = URLEncoder.encode("通过成功！", "UTF-8");
            String b = URLEncoder.encode("通过失败！", "UTF-8");
            if (count!=0){
                resp.getWriter().write("<script>alert(decodeURIComponent('"+a+"')); window.window.location.href='"+url+"';</script>");
            }else{
                resp.getWriter().write("<script>alert(decodeURIComponent('"+b+"')); window.window.location.href='"+url+"';</script>");
            }


    }

    public int pass(String id,HttpServletRequest req){

        try {
            Connection connection = DBHelper.getConnection();
            String sql="select * from checkpeople where id=?";


            PreparedStatement ps = connection.prepareStatement(sql);
            PeopleDAO peopleDAO = new PeopleDAOImpl();
            ResultSet rs=null;
            int count=0;

            String type = "";
            String name = "";
            String username = "";
            String password ="";
            String shenfen="";
            People people = new People();

            ps.setString(1,id);
            rs = ps.executeQuery();
            if(rs.next()){

                type = rs.getString("type");
                name = rs.getString("name");
                username = rs.getString("username");
                password = rs.getString("password");

                people.setName(name);
                people.setUsername(username);
                people.setPassword(password);
                count = peopleDAO.add(type,people);

            }
            peopleDAO.delete("checkpeople", id);
            switch (type){
                case  "admin":shenfen="管理员";break;
                case  "teacher":shenfen="老师";break;
                case "student":shenfen="学生";break;
            }
            sql = "insert into log value(null," + req.getParameter("admin").split("-")[0] + ",'" + req.getParameter("admin").split("-")[1] + "','通过','" + req.getParameter("time") + "','通过了"+name+"注册一个"+shenfen+"账号的申请')";
            connection.prepareStatement(sql).executeUpdate();

            return count;

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }

    }

}
