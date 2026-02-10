Student Management Console (Java)

Simple Java console application for managing students and branches.

Prerequisites
- JDK (java/javac) on PATH
- PowerShell or cmd.exe

Quick run (PowerShell):

```powershell
cd D:\Student_Management
# compile
javac -d bin src\database\*.java src\model\*.java src\service\*.java src\ui\*.java src\setup\*.java
# run
java -cp "bin;lib\h2-2.2.224.jar" ui.StudentManagementConsole
```

Or use the helper script:

```powershell
.\run.ps1 -Action run
```

Notes
- The `lib/*.jar` files are ignored by default; download H2 JDBC jar into `lib/`.
- If you prefer, convert to Maven/Gradle for dependency management.

How to push to GitHub
1) Initialize and commit locally:

```bash
cd D:/Student_Management
git init
git branch -M main
git add .
git commit -m "Initial commit"
```

2a) Create remote repository (GitHub website), then add and push:

```bash
git remote add origin https://github.com/<your-username>/<repo-name>.git
git push -u origin main
```

2b) Or use GitHub CLI (if installed):

```bash
gh repo create <repo-name> --public --source=. --remote=origin --push
```

If you want me to create the `pom.xml` (Maven) instead, or add a `run.sh` for Linux/mac, tell me which and I'll add it.