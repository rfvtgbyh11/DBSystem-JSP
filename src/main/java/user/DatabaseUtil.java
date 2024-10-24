package user;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {

    public static Connection getConnection() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/Proj1?serverTimezone=Asia/Seoul";
            String dbID = "root";
            String dbPassword = "4197";
            Class.forName("com.mysql.cj.jdbc.Drier");
            return DriverManager.getConnection(dbURL, dbID, dbPassword);
        }
        catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

}
