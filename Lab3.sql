--DBI202_AI18D01_LAB3_SU24--

USE [FUH_COMPANY]
GO

--Trunghieu--
 --1.	Cho biết ai đang quản lý phòng ban có tên: Phòng Nghiên cứu và phát triển. --
 SELECT e.empSSN, e.empName, d.depNum, d.depName
FROM tblEmployee e
JOIN tblDepartment d ON e.empSSN = d.mgrSSN
WHERE d.depName = N'Phòng Nghiên cứu và phát triển';

--LanNhi--

--BaoTran--

--Vinh--