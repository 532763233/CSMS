package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBHelper {
    public static final String driver = "com.mysql.jdbc.Driver";//驱动
    public static final String url = "jdbc:mysql://127.0.0.1:3306/ccmsdb";//连接数据库的地址
    public static final String username = "root";//数据库用户名
    public static final String password = "123456";//数据库密码

    private static Connection connection=null;
    //静态代码块，负责加载驱动
    static {
        try {
            Class.forName(driver);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    //单例模式，返回数据据库连接对象
    public static Connection getConnection() throws Exception {
        if (connection==null){
            connection= DriverManager.getConnection(url,username,password);
            return connection;
        }
        return connection;
    }

}
