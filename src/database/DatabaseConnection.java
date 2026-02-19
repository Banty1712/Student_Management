package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.io.*;
import java.time.LocalDateTime;

public class DatabaseConnection {
    // MySQL 8.0 connection - use proper driver manager approach
    // to avoid embedding credentials in URL
    private static final String DATABASE_URL = "jdbc:mysql://localhost:3306/student_management?" +
            "serverTimezone=UTC&" +
            "useSSL=false&" +
            "allowPublicKeyRetrieval=true&" +
            "useServerPrepStmts=false&" +
            "allowMultiQueries=false&" +
            "cachePrepStmts=false";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "admin";
    private static final String LOG_FILE = "C:\\tools\\tomcat\\logs\\database-connection.log";
    private static Connection connection;

    private static void log(String message) {
        try (FileWriter fw = new FileWriter(LOG_FILE, true);
             BufferedWriter bw = new BufferedWriter(fw);
             PrintWriter out = new PrintWriter(bw)) {
            out.println("[" + LocalDateTime.now() + "] " + message);
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                log("=== Database Connection Attempt ===");
                log("URL: " + DATABASE_URL);
                log("User: " + DB_USER);
                
                connection = DriverManager.getConnection(DATABASE_URL, DB_USER, DB_PASSWORD);
                log("✓ SUCCESS: Connected to MySQL database!");
                return connection;
                
            } catch (ClassNotFoundException e) {
                log("✗ ERROR: MySQL JDBC Driver not found! " + e.getMessage());
                throw new SQLException("MySQL driver not found", e);
                
            } catch (SQLException e) {
                log("✗ ERROR: Connection failed!");
                log("  SQLState: " + e.getSQLState());
                log("  ErrorCode: " + e.getErrorCode());
                log("  Message: " + e.getMessage());
                throw e;
            }
        }
        return connection;
    }

    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            log("Error closing connection: " + e.getMessage());
        }
    }
}
