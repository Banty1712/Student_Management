package web;

import service.BranchService;
import model.Branch;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.LinkedHashSet;

@WebServlet(urlPatterns = "/branch/*")
public class BranchServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getPathInfo();
        
        if (action == null) {
            action = "/list";
        }
        
        switch (action) {
            case "/list":
                listBranches(request, response);
                break;
            case "/add":
                showAddForm(request, response);
                break;
            case "/details":
                viewBranchDetails(request, response);
                break;
            case "/delete":
                showDeleteForm(request, response);
                break;
            default:
                listBranches(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getPathInfo();
        
        switch (action) {
            case "/add":
                addBranch(request, response);
                break;
            case "/delete":
                deleteBranch(request, response);
                break;
            case "/update":
                updateBranch(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/branch/list");
        }
    }
    
    private void listBranches(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        LinkedHashSet<Branch> branches = BranchService.getAllBranches();
        request.setAttribute("branches", branches);
        request.getRequestDispatcher("/branch-list.jsp").forward(request, response);
    }
    
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/add-branch.jsp").forward(request, response);
    }
    
    private void addBranch(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String branchName = request.getParameter("branchName");
            String branchCode = request.getParameter("branchCode");
            String department = request.getParameter("department");
            
            Branch branch = new Branch(branchName, branchCode, department);
            
            if (BranchService.addBranch(branch)) {
                request.setAttribute("message", "Branch added successfully!");
            } else {
                request.setAttribute("message", "Failed to add branch. Please try again.");
            }
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
        }
        
        listBranches(request, response);
    }
    
    private void viewBranchDetails(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int branchId = Integer.parseInt(request.getParameter("id"));
            Branch branch = BranchService.getBranchById(branchId);
            
            if (branch != null) {
                request.setAttribute("branch", branch);
                request.getRequestDispatcher("/branch-details.jsp").forward(request, response);
            } else {
                request.setAttribute("message", "Branch not found!");
                listBranches(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            listBranches(request, response);
        }
    }
    
    private void showDeleteForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        LinkedHashSet<Branch> branches = BranchService.getAllBranches();
        request.setAttribute("branches", branches);
        request.getRequestDispatcher("/delete-branch.jsp").forward(request, response);
    }
    
    private void deleteBranch(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int branchId = Integer.parseInt(request.getParameter("branchId"));
            
            if (BranchService.deleteBranch(branchId)) {
                request.setAttribute("message", "Branch deleted successfully!");
            } else {
                request.setAttribute("message", "Failed to delete branch. Please try again.");
            }
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
        }
        
        listBranches(request, response);
    }
    
    private void updateBranch(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int branchId = Integer.parseInt(request.getParameter("branchId"));
            String branchName = request.getParameter("branchName");
            String branchCode = request.getParameter("branchCode");
            String department = request.getParameter("department");
            
            Branch branch = new Branch(branchId, branchName, branchCode, department);
            
            if (BranchService.updateBranch(branch)) {
                request.setAttribute("message", "Branch updated successfully!");
            } else {
                request.setAttribute("message", "Failed to update branch. Please try again.");
            }
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
        }
        
        listBranches(request, response);
    }
}
