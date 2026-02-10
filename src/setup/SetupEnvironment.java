package setup;

public class SetupEnvironment {
    public static void main(String[] args) {
        System.out.println("Setting up Student Management System...");
        System.out.println("Please ensure h2-2.2.224.jar is in the root directory.");
        System.out.println("\nDownload from: https://www.h2database.com/html/download.html");
        System.out.println("Place the JAR file in: " + System.getProperty("user.dir"));
        System.out.println("\nTo compile and run:");
        System.out.println("1. Compile: javac -d bin src/**/*.java");
        System.out.println("2. Run: java -cp bin;h2-2.2.224.jar ui.StudentManagementConsole");
    }
}
