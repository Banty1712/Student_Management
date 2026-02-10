package model;

public class Student {
    private int studentId;
    private String name;
    private String email;
    private String phoneNumber;
    private int branchId;
    private double cgpa;
    private String enrollmentDate;
    private String studentType; // FULL_TIME or PART_TIME

    public Student() {
    }

    public Student(int studentId, String name, String email, String phoneNumber, int branchId, double cgpa, String enrollmentDate) {
        this.studentId = studentId;
        this.name = name;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.branchId = branchId;
        this.cgpa = cgpa;
        this.enrollmentDate = enrollmentDate;
    }

    public Student(int studentId, String name, String email, String phoneNumber, int branchId, double cgpa, String enrollmentDate, String studentType) {
        this(studentId, name, email, phoneNumber, branchId, cgpa, enrollmentDate);
        this.studentType = studentType;
    }

    public Student(String name, String email, String phoneNumber, int branchId, double cgpa, String enrollmentDate) {
        this.name = name;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.branchId = branchId;
        this.cgpa = cgpa;
        this.enrollmentDate = enrollmentDate;
    }

    public Student(String name, String email, String phoneNumber, int branchId, double cgpa, String enrollmentDate, String studentType) {
        this(name, email, phoneNumber, branchId, cgpa, enrollmentDate);
        this.studentType = studentType;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public int getBranchId() {
        return branchId;
    }

    public void setBranchId(int branchId) {
        this.branchId = branchId;
    }

    public double getCgpa() {
        return cgpa;
    }

    public void setCgpa(double cgpa) {
        this.cgpa = cgpa;
    }

    public String getEnrollmentDate() {
        return enrollmentDate;
    }

    public void setEnrollmentDate(String enrollmentDate) {
        this.enrollmentDate = enrollmentDate;
    }

    public String getStudentType() {
        return studentType;
    }

    public void setStudentType(String studentType) {
        this.studentType = studentType;
    }

    @Override
    public String toString() {
        return "Student{" +
                "studentId=" + studentId +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", branchId=" + branchId +
                ", cgpa=" + cgpa +
                ", enrollmentDate='" + enrollmentDate + '\'' +
                ", studentType='" + studentType + '\'' +
                '}';
    }
}
