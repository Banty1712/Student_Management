package model;

public class Branch {
    private int branchId;
    private String branchName;
    private String branchCode;
    private String department;

    public Branch() {
    }

    public Branch(int branchId, String branchName, String branchCode, String department) {
        this.branchId = branchId;
        this.branchName = branchName;
        this.branchCode = branchCode;
        this.department = department;
    }

    public Branch(String branchName, String branchCode, String department) {
        this.branchName = branchName;
        this.branchCode = branchCode;
        this.department = department;
    }

    public int getBranchId() {
        return branchId;
    }

    public void setBranchId(int branchId) {
        this.branchId = branchId;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    @Override
    public String toString() {
        return "Branch{" +
                "branchId=" + branchId +
                ", branchName='" + branchName + '\'' +
                ", branchCode='" + branchCode + '\'' +
                ", department='" + department + '\'' +
                '}';
    }
}
