import java.sql.*;

public class SimpleBranchTest {
    public static void main(String[] args) throws Exception {
        // Using socket connection instead of TCP/IP
        String url = "jdbc:mysql://localhost:3306/student_management?allowLoadLocalInfile=false&allowLoadLocalInfileInPath=/&allowUrlInLocalInfile=false&allowLoadLocalInfile=false&serverTimezone=UTC";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("Driver class loaded successfully");
            
            Connection conn = DriverManager.getConnection(url, "root", ""); // Try empty password
            System.out.println("Connection successful with empty password!");
            
            Statement stmt = conn.createStatement();
            
            // Check if branches exist
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as cnt FROM branch");
            if (rs.next()) {
                int count = rs.getInt("cnt");
                System.out.println("Branch count: " + count);
            }
            
            // List branches
            rs = stmt.executeQuery("SELECT * FROM branch");
            while (rs.next()) {
                System.out.println(rs.getInt("branch_id") + ": " + rs.getString("branch_name"));
            }
            
            conn.close();
        } catch (Exception e) {
            System.err.println("ERROR: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
