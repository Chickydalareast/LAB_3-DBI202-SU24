﻿--DBI202_AI18D01_LAB3_SU24--

USE [FUH_COMPANY]
GO

--Trunghieu--
 --1. Cho biết ai đang quản lý phòng ban có tên: Phòng Nghiên cứu và phát triển. --
 SELECT e.empSSN, e.empName, d.depNum, d.depName
FROM tblEmployee e
JOIN tblDepartment d ON e.empSSN = d.mgrSSN
WHERE d.depName = N'Phòng Nghiên cứu và phát triển';
 --2. Cho phòng ban có tên: Phòng Nghiên cứu và phát triển hiện đang quản lý dự án nào.--
 SELECT  p.proNum, p.proName, d.depName
FROM  tblProject p
JOIN  tblDepartment d ON p.depNum = d.depNum
WHERE  d.depName = N'Phòng Nghiên cứu và phát triển';
 --3.	Cho biết dự án có tên ProjectB hiện đang được quản lý bởi phòng ban nào. --
 SELECT  p.proNum, p.proName, d.depName
FROM  tblProject p
JOIN tblDepartment d ON p.depNum = d.depNum
WHERE  p.proName = 'ProjectB';
 --4. Cho biết những nhân viên nào đang bị giám sát bởi nhân viên có tên Mai Duy An.--
 SELECT e1.empSSN, e1.empName
FROM tblEmployee e1
JOIN  tblEmployee e2 ON e1.supervisorSSN = e2.empSSN
WHERE e2.empName = N'Mai Duy An';
 --5. Cho biết ai hiện đang giám sát những nhân viên có tên Mai Duy An.--
 SELECT e2.empSSN, e2.empName
FROM tblEmployee e1
JOIN  tblEmployee e2 ON e1.supervisorSSN = e2.empSSN
WHERE e1.empName = N'Mai Duy An';
 --6.	Cho biết dự án có tên ProjectA hiện đang làm việc ở đâu--
 SELECT p.proNum,  l.locName
FROM tblProject p
JOIN  tblLocation l ON p.locNum = l.locNum
WHERE  p.proName = 'ProjectA';
 --7.	Cho biết vị trí làm việc có tên Tp. HCM hiện đang là chỗ làm việc của những dự án nào. --
 SELECT p.proNum, p.proName
FROM  tblProject p
JOIN tblLocation l ON p.locNum = l.locNum
WHERE  l.locName = N'TP Hồ Chí Minh';
 --8.	Cho biết những người phụ thuộc trên 18 tuổi --
 SELECT  d.depName, d.depBirthdate, e.empName
FROM tblDependent d
JOIN tblEmployee e ON d.empSSN = e.empSSN
WHERE DATEDIFF(YEAR, d.depBirthdate, GETDATE()) > 18;
 --9.	Cho biết những người phụ thuộc  là nam giới. --
 SELECT d.depName,d.depBirthdate, e.empName
FROM  tblDependent d
JOIN  tblEmployee e ON d.empSSN = e.empSSN
WHERE d.depSex = 'M';
 --10.	Cho biết những nơi làm việc của phòng ban có tên : Phòng Nghiên cứu và phát triển.--
 SELECT d.depNum, d.depName, l.locName
FROM  tblDepLocation dl
JOIN tblDepartment d ON dl.depNum = d.depNum
JOIN tblLocation l ON dl.locNum = l.locNum
WHERE d.depName = N'Phòng Nghiên cứu và phát triển';
 --11.	Cho biết các dự án làm việc tại Tp. HCM. --
 SELECT  p.proNum, p.proName, d.depName
FROM tblProject p
JOIN tblLocation l ON p.locNum = l.locNum
JOIN tblDepartment d ON p.depNum = d.depNum
WHERE l.locName = N'TP Hồ Chí Minh';
 --12.	Cho biết những người phụ thuộc là nữ giới, của nhân viên thuộc phòng ban có tên: Phòng Nghiên cứu và phát triển .--
 SELECT e.empName,d.depName, d.depRelationship
FROM tblDependent d
JOIN  tblEmployee e ON d.empSSN = e.empSSN
JOIN tblDepartment dep ON e.depNum = dep.depNum
WHERE d.depSex = N'F' AND dep.depName = N'Phòng Nghiên cứu và phát triển';
 --13.	Cho biết những người phụ thuộc trên 18 tuổi, của nhân viên thuộc phòng ban có tên: Phòng Nghiên cứu và phát triển.--
 SELECT e.empName,d.depName,d.depRelationship
FROM tblDependent d
JOIN tblEmployee e ON d.empSSN = e.empSSN
JOIN tblDepartment dep ON e.depNum = dep.depNum
WHERE DATEDIFF(YEAR, d.depBirthdate, GETDATE()) > 18 AND dep.depName = N'Phòng Nghiên cứu và phát triển';

--LanNhi--
use FUH_COMPANY;
go
--14.Cho biết số lượng người phụ thuộc theo giới tính. 
--Thông tin yêu cầu: giới tính, số lượng người phụ thuộc
SELECT 
    depSex,
    COUNT(*) AS numOfDep
FROM 
    tblDependent
GROUP BY 
    depSex;
go
--15.Cho biết số lượng người phụ thuộc theo mối liên hệ với nhân viên. Thông tin yêu cầu: mối liên hệ, số lượng người phụ thuộc
SELECT 
    depRelationship, 
    COUNT(depName) AS numOfDep
FROM 
    tblDependent
GROUP BY 
    depRelationship; 
go
--16.Cho biết số lượng người phụ thuộc theo mỗi phòng ban. 
--Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc
SELECT 
    d.depNum,
    d.depName,
    COUNT(dep.depName) AS numOfDep
FROM 
    tblDepartment d
LEFT JOIN 
    tblEmployee e ON d.depNum = e.depNum
LEFT JOIN 
    tblDependent dep ON e.empSSN = dep.empSSN
GROUP BY 
    d.depNum, d.depName
ORDER BY 
    d.depNum;
go
--17.Cho biết phòng ban nào có số lượng người phụ thuộc là ít nhất. 
--Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc
SELECT 
    d.depNum, 
    d.depName, 
    COUNT(dep.depName) AS numOfDep
FROM 
    tblDepartment d
LEFT JOIN 
    tblEmployee e ON d.depNum = e.depNum
LEFT JOIN 
    tblDependent dep ON e.empSSN = dep.empSSN
GROUP BY 
    d.depNum, d.depName
HAVING 
    COUNT(dep.depName) = (
        SELECT 
            MIN(dep_count)
        FROM (
            SELECT 
                COUNT(dep2.depName) AS dep_count
            FROM 
                tblDepartment d2
            LEFT JOIN 
                tblEmployee e2 ON d2.depNum = e2.depNum
            LEFT JOIN 
                tblDependent dep2 ON e2.empSSN = dep2.empSSN
            GROUP BY 
                d2.depNum, d2.depName
        ) AS Subquery
    )
ORDER BY 
    d.depNum;
go
--18.Cho biết phòng ban nào có số lượng người phụ thuộc là nhiều nhất.
--Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc
SELECT 
    d.depNum,
    d.depName,
    COUNT(dep.depName) AS numOfDep
FROM 
    tblDepartment d
LEFT JOIN 
    tblEmployee e ON d.depNum = e.depNum
LEFT JOIN 
    tblDependent dep ON e.empSSN = dep.empSSN
GROUP BY 
    d.depNum, d.depName
HAVING 
    COUNT(dep.depName) = (
        SELECT 
            MAX(dependent_count)
        FROM (
            SELECT 
                COUNT(dep2.depName) AS dependent_count
            FROM 
                tblDepartment d2
            LEFT JOIN 
                tblEmployee e2 ON d2.depNum = e2.depNum
            LEFT JOIN 
                tblDependent dep2 ON e2.empSSN = dep2.empSSN
            GROUP BY 
                d2.depNum, d2.depName
        ) AS max_counts
	);
go
--19.Cho biết tổng số giờ tham gia dự án của mỗi nhân viên. 
--Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
SELECT 
    e.empSSN, 
    e.empName, 
    d.depName, 
    SUM(w.workHours) AS total_hours
FROM 
    tblEmployee e
JOIN 
    tblDepartment d ON e.depNum = d.depNum
JOIN 
    tblWorksOn w ON e.empSSN = w.empSSN
JOIN 
    tblProject p ON w.proNum = p.proNum
GROUP BY 
    e.empSSN, e.empName, d.depName;
go
--20.Cho biết tổng số giờ làm dự án của mỗi phòng ban. 
--Thông tin yêu cầu: mã phòng ban,  tên phòng ban, tổng số giờ
SELECT 
    d.depNum, 
    d.depName, 
    SUM(w.workHours) AS total_hours
FROM 
    tblDepartment d
JOIN 
    tblProject p ON d.depNum = p.depNum
JOIN 
    tblWorksOn w ON p.proNum = w.proNum
JOIN 
    tblEmployee e ON w.empSSN = e.empSSN
GROUP BY 
    d.depNum, d.depName;
go
--21.Cho biết nhân viên nào có số giờ tham gia dự án là ít nhất. 
--Thông tin yêu cầu: mã nhân viên, tên nhân viên, tổng số giờ tham gia dự án
SELECT TOP 1
    e.empSSN,
    e.empName,
    SUM(w.workHours) AS total_hours
FROM
    tblEmployee e
JOIN
    tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY
    e.empSSN, e.empName
ORDER BY
    total_hours ASC;
go
--22.Cho biết nhân viên nào có số giờ tham gia dự án là nhiều nhất. 
--Thông tin yêu cầu: mã nhân viên, tên nhân viên, tổng số giờ tham gia dự án
SELECT TOP 1
    e.empSSN,
    e.empName,
    SUM(w.workHours) AS total_hours
FROM
    tblEmployee e
JOIN
    tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY
    e.empSSN, e.empName
ORDER BY
    total_hours DESC;
go
--23.Cho biết những nhân viên nào lần đầu tiên tham gia dụ án. 
--Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
SELECT 
    e.empSSN,
    e.empName,
    d.depName
FROM 
    tblEmployee e
JOIN 
    tblDepartment d ON e.depNum = d.depNum
JOIN 
    tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY 
    e.empSSN, e.empName, d.depName
HAVING 
    COUNT(w.proNum) = 1;
go
--24.Cho biết những nhân viên nào lần thứ hai tham gia dụ án. 
--Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
SELECT 
    e.empSSN,
    e.empName,
    d.depName
FROM 
    tblEmployee e
JOIN 
    tblDepartment d ON e.depNum = d.depNum
JOIN 
    tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY 
    e.empSSN, e.empName, d.depName
HAVING 
    COUNT(DISTINCT w.proNum) = 2;
go
--25.Cho biết những nhân viên nào tham gia tối thiểu hai dụ án. 
--Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
SELECT 
    e.empSSN,
    e.empName,
    d.depName
FROM 
    tblEmployee e
JOIN 
    tblDepartment d ON e.depNum = d.depNum
JOIN 
    tblWorksOn w ON e.empSSN = w.empSSN
GROUP BY 
    e.empSSN, e.empName, d.depName
HAVING 
    COUNT(DISTINCT w.proNum) >= 2;
go
--26.Cho biết số lượng thành viên của mỗi dự án. 
--Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
SELECT 
    p.proNum,
    p.proName,
    COUNT(w.empSSN) AS numOfMem
FROM 
    tblProject p
LEFT JOIN 
    tblWorksOn w ON p.proNum = w.proNum
GROUP BY 
    p.proNum, p.proName;

--BaoTran--

--Vinh--