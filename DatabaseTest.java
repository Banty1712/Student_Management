import java.sql.*;

public class DatabaseTest {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/student_management";
        String user = "root";
        String password = "admin";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);
            
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM branch");
            
            System.out.println("Branches in database:");
            int count = 0;
            while (rs.next()) {
                System.out.println(rs.getInt("branch_id") + " - " + rs.getString("branch_name"));
                count++;
            }
            
            if (count == 0) {
                System.out.println("NO BRANCHES FOUND!");
            } else {
                System.out.println("Total: " + count + " branches");
            }
            
            conn.close();
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
