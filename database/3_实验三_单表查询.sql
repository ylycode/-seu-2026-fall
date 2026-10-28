-- 实验一：单表查询、嵌套查询、连接查询、分组排序
-- 日期：2026/10/28
-- 文件：实验一_单表查询.sql

-- =============================================
-- 1，查询语句的基本使用
-- =============================================
-- (1) 查询每个雇员的所有数据
SELECT * FROM Employee;

-- (2) 查询Employee表中每个雇员的地址和电话
SELECT Address, PhoneNum FROM Employee;

-- (3) 查询每个雇员的部门号和性别，消除重复行
SELECT DISTINCT DepartmentId, Sex FROM Employee;

-- (4) 查询月收入高于2000元的员工号码
SELECT EmployeeId FROM Salary WHERE Income > 2000;

-- (5) 查询女雇员的电话和地址，并用AS子句将结果中各列的标题指定为地址、电话
SELECT Address AS 地址, PhoneNum AS 电话 FROM Employee WHERE Sex = 0;

-- (6) 查询所有员工的总收入
SELECT SUM(Income) AS 总收入 FROM Salary;

-- (7) 查询员工的平均收入
SELECT AVG(Income) AS 平均收入 FROM Salary;

-- (8) 查询姓王员工的基本信息
SELECT * FROM Employee WHERE Name LIKE '王%';

-- =============================================
-- 2，嵌套查询
-- =============================================
-- (1) 查询财务部工作的雇员情况
SELECT * FROM Employee 
WHERE DepartmentId = (SELECT DepartmentId FROM Department WHERE DepartmentName='财务部');

-- (2) 查找财务部雇员年龄不低于研发部雇员年龄的姓名
SELECT Name FROM Employee 
WHERE DepartmentId=(SELECT DepartmentId FROM Department WHERE DepartmentName='财务部')
  AND Birthday <= (SELECT MIN(Birthday) FROM Employee 
                   WHERE DepartmentId=(SELECT DepartmentId FROM Department WHERE DepartmentName='研发部'));

-- (3) 查找比所有财务部的雇员收入都高的雇员姓名
SELECT e.Name FROM Employee e JOIN Salary s ON e.EmployeeId=s.EmployeeId
WHERE s.Income > ALL(
   SELECT s2.Income FROM Salary s2 JOIN Employee e2 ON s2.EmployeeId=e2.EmployeeId
   WHERE e2.DepartmentId=(SELECT DepartmentId FROM Department WHERE DepartmentName='财务部'));

-- =============================================
-- 3，连接查询
-- =============================================
-- (1) 查询每个雇员的情况及其薪水情况
SELECT e.*, s.Income, s.Outcome 
FROM Employee e JOIN Salary s ON e.EmployeeId=s.EmployeeId;

-- (2) 查询名字为“王林”的员工所在部门
SELECT d.* FROM Department d 
WHERE d.DepartmentId = (SELECT DepartmentId FROM Employee WHERE Name='王林');
-- 或连接写法
SELECT e.Name, d.DepartmentName FROM Employee e JOIN Department d ON e.DepartmentId=d.DepartmentId WHERE e.Name='王林';

-- (3) 使用外连接的方法查询所有员工的月收入
SELECT e.EmployeeId, e.Name, s.Income 
FROM Employee e LEFT OUTER JOIN Salary s ON e.EmployeeId=s.EmployeeId;

-- (4) 查询财务部收入在2000以上的雇员姓名及其薪水情况
SELECT e.Name, s.Income, s.Outcome 
FROM Employee e JOIN Salary s ON e.EmployeeId=s.EmployeeId
JOIN Department d ON e.DepartmentId=d.DepartmentId
WHERE d.DepartmentName='财务部' AND s.Income>2000;

-- =============================================
-- 4，分组排序
-- =============================================
-- (1) 查询男生和女生的人数
SELECT Sex, COUNT(*) AS 人数 FROM Employee GROUP BY Sex;

-- (2) 按部门查询每个部门的人数
SELECT DepartmentId, COUNT(*) AS 人数 FROM Employee GROUP BY DepartmentId;

-- (3) 查询员工超过2个的部门名称和员工数量（需要连接Department）
SELECT d.DepartmentName, COUNT(*) AS 员工数量
FROM Employee e JOIN Department d ON e.DepartmentId=d.DepartmentId
GROUP BY d.DepartmentId, d.DepartmentName
HAVING COUNT(*) > 2;

-- (4) 将雇员的收入由高到低排列
SELECT e.Name, s.Income FROM Employee e JOIN Salary s ON e.EmployeeId=s.EmployeeId
ORDER BY s.Income DESC;

-- (5) 将员工的出生时间由小到大排列
SELECT Name, Birthday FROM Employee ORDER BY Birthday ASC;