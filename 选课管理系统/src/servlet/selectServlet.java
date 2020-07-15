package servlet;

import Impl.PeopleDAOImpl;
import com.google.gson.Gson;
import dao.PeopleDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/selectServlet")
public class selectServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html; charset=UTF-8");

        String type=req.getParameter("type");
        String value=req.getParameter("value");
        String search=req.getParameter("search");
        String sql="";
        PeopleDAO peopleDao = new PeopleDAOImpl();



        //GoodsImpl goodsService = new GoodsImpl();
        if("teach".equals(type)){
            if(value=="" || value==null){
                sql="select * from course where t_id ="+search+"";
            }else {
                sql = "select * from course where t_id=" + search + " and id=" + value + "";
            }
        }else if ("slist".equals(type)){
            if(value=="" || value==null){
                sql="select * from sc where t_id ="+search+"";
            }else {
                sql = "select * from sc where t_id=" + search + " and id=" + value + "";
            }
        }else if("able".equals(type)){
            if(value=="" || value==null){
                sql="select * from course where choice=true";
            }else{
                sql = "select * from course where id='" + value + "' and choice=true";
            }
        }else{
            if(value=="" || value==null){
                sql="select * from "+type+"";
            }else if (search=="" || search==null){
                sql="select * from "+type+" where id='"+value+"'";
            }else {
                sql="select * from "+type+" where "+search+"='"+value+"'";
            }
        }

        List<Map<String, Object>> goodsList = peopleDao.select(sql);

        Map<String, Object> map = new HashMap<String, Object>();
        /**
         * 进行数据组装，将所有的list的数据变layui-table的所需要的 格式
         */


        if(goodsList != null) {
            map.put("code",0);
            map.put("msg", "");
            map.put("count",goodsList.size());
            map.put("data", goodsList);
        }

        Gson gson = new Gson();                                    //将map数据类型转化为Json数据类型
//    	  System.out.println(gson.toJson(map));

        PrintWriter out = resp.getWriter();
        out.write(gson.toJson(map));
        out.flush();
        out.close();


    }
}
