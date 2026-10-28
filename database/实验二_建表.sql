-- 实验二：TPCH 三表建表（部门、员工、薪水）

USE TPCH; -- 强制指定在TPCH库下执行
GO

-- 如果之前建过表，先按外键顺序删除（首次执行无表也不报错）
DROP TABLE IF EXISTS Salary;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;
GO

-- 1. 部门表（实体完整性：主键）
CREATE TABLE Department
(
    DepartmentId char(3) PRIMARY KEY,
    DepartmentName char(20),
    Remark char(50)
);
GO

-- 2. 员工表（实体完整性：主键；参照完整性：外键引部门；自定义：姓名非空）
CREATE TABLE Employee
(
    EmployeeId char(6) PRIMARY KEY,
    Name char(10) NOT NULL,
    Education char(10),
    Birthday date,
    Sex char(2),
    Workyear int,
    Address char(50),
    PhoneNum char(12),
    DepartmentId char(3),
    FOREIGN KEY (DepartmentId) REFERENCES Department(DepartmentId)
);
GO

-- 3. 薪水表（实体完整性：主键；参照完整性：外键引员工）
CREATE TABLE Salary
(
    EmployeeId char(6) PRIMARY KEY,
    Income float,
    Outcome float,
    FOREIGN KEY (EmployeeId) REFERENCES Employee(EmployeeId)
);
GO