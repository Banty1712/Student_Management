package service;

import model.Branch;
import database.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BranchService {
    
    public static boolean addBranch(Branch branch) {
        String sql = "INSERT INTO branch (branch_name, branch_code, department) VALUES (?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, branch.getBranchName());
            pstmt.setString(2, branch.getBranchCode());
            pstmt.setString(3, branch.getDepartment());
            
            int rowsInserted = pstmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.err.println("Error adding branch: " + e.getMessage());
            return false;
        }
    }

    public static List<Branch> getAllBranches() {
        List<Branch> branches = new ArrayList<>();
        String sql = "SELECT * FROM branch";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Branch branch = new Branch(
                        rs.getInt("branch_id"),
                        rs.getString("branch_name"),
                        rs.getString("branch_code"),
                        rs.getString("department")
                );
                branches.add(branch);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving branches: " + e.getMessage());
        }
        return branches;
    }

    public static Branch getBranchById(int branchId) {
        String sql = "SELECT * FROM branch WHERE branch_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, branchId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Branch(
                            rs.getInt("branch_id"),
                            rs.getString("branch_name"),
                            rs.getString("branch_code"),
                            rs.getString("department")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving branch: " + e.getMessage());
        }
        return null;
    }

    public static boolean updateBranch(Branch branch) {
        String sql = "UPDATE branch SET branch_name = ?, branch_code = ?, department = ? WHERE branch_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, branch.getBranchName());
            pstmt.setString(2, branch.getBranchCode());
            pstmt.setString(3, branch.getDepartment());
            pstmt.setInt(4, branch.getBranchId());
            
            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("Error updating branch: " + e.getMessage());
            return false;
        }
    }

    public static boolean deleteBranch(int branchId) {
        String sql = "DELETE FROM branch WHERE branch_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, branchId);
            
            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting branch: " + e.getMessage());
            return false;
        }
    }

    public static void displayAllBranches() {
        List<Branch> branches = getAllBranches();
        if (branches.isEmpty()) {
            System.out.println("No branches found.");
            return;
        }
        
        System.out.println("\n========== ALL BRANCHES ==========");
        System.out.printf("%-5s %-30s %-10s %-20s%n", "ID", "Branch Name", "Code", "Department");
        System.out.println("==================================");
        for (Branch branch : branches) {
            System.out.printf("%-5d %-30s %-10s %-20s%n", 
                    branch.getBranchId(), 
                    branch.getBranchName(), 
                    branch.getBranchCode(), 
                    branch.getDepartment());
        }
        System.out.println("==================================\n");
    }
}
