/* CREATE A NEW DATABASE*/
CREATE DATABASE excelr_project;

/* USE A NEW CREATED DATABASE*/
USE excelr_project;

/* ALTER THE COLUMN*/
ALTER TABLE hrdata1 CHANGE COLUMN `ï»¿Age` `Age` INT;

#------ BASIC KPI'S ---------------------------------#
#====================================================#

/* KPI - 1)   Calculate Total numbers of employees in company */
SELECT COUNT(`EmployeeNumber`) AS `Total Employees` FROM hrdata1;

/* KPI - 2)   Calculate employees average age in company */
SELECT round(AVG(`Age`)) AS `Employees Average Age` FROM hrdata1;

/* KPI - 3)   Calculate employees average age at company */
SELECT round(AVG(`YearsAtCompany`)) AS `Average Age at Company` FROM hrdata2;

/* KPI - 4)   Calculate Total Ex-employees numbers of employees in company */
SELECT COUNT(`EmployeeNumber`) AS `Total Ex-employees` FROM hrdata1 WHERE `Attrition`="Yes";

/* KPI - 5)   Calculate Total Active numbers of employees in company */
SELECT COUNT(`EmployeeNumber`) AS `Total Active Employees` FROM hrdata1 WHERE `Attrition`="No";

/* KPI - 6)   Calculate ATTRITION rate in percentage */
SELECT DISTINCT(CONCAT(ROUND(((SELECT COUNT(`EmployeeNumber`) FROM hrdata1 WHERE `Attrition`="Yes")/(SELECT COUNT(`EmployeeNumber`) FROM hrdata1))*100,2),"%")) AS `Attrition Rate %` FROM hrdata1;

/* KPI - 7)   Calculate Total Monthly income in millions*/
SELECT CONCAT(ROUND(SUM(`MonthlyIncome`)/1000000),"M") AS `Total Monthly Income` FROM hrdata2;

/* KPI - 8)   Calculate MAX Monthly income */
SELECT MAX(`MonthlyIncome`) AS `Max Monthly Income` fROM hrdata2;

/* KPI - 9)   Calculate MIN Monthly income */
SELECT MIN(`MonthlyIncome`) AS `Min Monthly Income` fROM hrdata2;

/* KPI - 10)   Calculate Average Monthly rate */
SELECT CONCAT(ROUND(AVG(`MonthlyRate`)/1000,2),"K") AS `Average Monthly Rate` fROM hrdata2;

/* KPI - 11)   Calculate Average Daily rate */
SELECT ROUND(AVG(`DailyRate`)) AS `Average Daily Rate` fROM hrdata1;

/* KPI - 12)   Calculate Average Daily rate */
SELECT ROUND(AVG(`HourlyRate`)) AS `Average Daily Rate` fROM hrdata1;

/* KPI - 13)   Calculate Average Salary Hike */
SELECT CONCAT(ROUND(AVG(`PercentSalaryHike`),2),"%") AS `Average Salary Hike` fROM hrdata2;

/* KPI - 14)   Calculate MAX Salary Hike */
SELECT CONCAT(MAX(`PercentSalaryHike`),"%") AS `MAX Salary Hike` fROM hrdata2;

/* KPI - 15)   Calculate MIN Salary Hike */
SELECT CONCAT(MIN(`PercentSalaryHike`),"%") AS `MIN Salary Hike` fROM hrdata2 WHERE `PercentSalaryHike`!=0;

/* KPI - 16)   Calculate Average Job Satisfaction */
SELECT ROUND(AVG(`JobSatisfaction`),2) AS `Average Job Satisfaction Rating` fROM hrdata1;

/* KPI - 17)   Calculate Average Relation Satisfaction */
SELECT ROUND(AVG(`RelationshipSatisfaction`),2) AS `Average Relation Satisfaction Rating` fROM hrdata2;

/* KPI - 18)   Calculate Average Environment Satisfaction */
SELECT ROUND(AVG(`EnvironmentSatisfaction`),2) AS `Average Environment Satisfaction Rating` fROM hrdata1;

/* KPI - 19)   Calculate Overall Average Performance Rating */
SELECT  ROUND(AVG(`PerformanceRating`),3) AS `Average Performance Rating` fROM hrdata2;

/* KPI - 20)   Calculate Active Employees Average Performance Rating */
SELECT  ROUND(AVG(hrdata2.PerformanceRating),3) AS `Active Employees Average Performance Rating` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber`
WHERE Attrition="No";

/* KPI - 21)   Calculate Ex-Employees Average Performance Rating */
SELECT  ROUND(AVG(hrdata2.PerformanceRating),3) AS `Ex-Employees Average Performance Rating` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber`
WHERE Attrition="Yes";

#------ GENDER WISE KPI'S ---------------------------------#
#==========================================================#
/* KPI - 1)   Calculate Total numbers of employees in company Gender wise*/
SELECT `Gender`, COUNT(`EmployeeNumber`) AS `Total Employees` FROM hrdata1 GROUP BY `Gender`;

/* KPI - 2)   Calculate Total numbers of Active employees in company Gender wise*/
SELECT `Gender`, COUNT(`EmployeeNumber`) AS `Total Active Employees` FROM hrdata1 WHERE `Attrition`="No" GROUP BY `Gender`;

/* KPI - 3)   Calculate Total numbers of Ex-employees in company Gender wise*/
SELECT `Gender`, COUNT(`EmployeeNumber`) AS `Total Ex-Employees` FROM hrdata1 WHERE `Attrition`="Yes" GROUP BY `Gender`;

/* KPI - 4)   Calculate Active employees % in company Gender wise*/
SELECT `Gender`, CONCAT(ROUND((COUNT(`EmployeeNumber`)/(SELECT COUNT(`EmployeeNumber`) FROM hrdata1))*100,2),"%") AS `Total Active Employees %` FROM hrdata1 WHERE `Attrition`="No" GROUP BY `Gender`;

/* KPI - 5)   Calculate Ex-employees % in company Gender wise*/
SELECT `Gender`, CONCAT(ROUND((COUNT(`EmployeeNumber`)/(SELECT COUNT(`EmployeeNumber`) FROM hrdata1))*100,2),"%") AS `Total Ex-Employees %` FROM hrdata1 WHERE `Attrition`="Yes" GROUP BY `Gender`;

/* KPI - 6)   Calculate Total Monthly income in millions Gender wise*/
SELECT hrdata1.Gender, CONCAT(ROUND(SUM(hrdata2.`MonthlyIncome`)/1000000),"M") AS `Total Monthly Income` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` GROUP BY `Gender`;

/* KPI - 7)   Calculate Average Salary Hike Gender wise*/
SELECT hrdata1.Gender, CONCAT(ROUND(AVG(hrdata2.`PercentSalaryHike`),2),"%") AS `Average Salary Hike` fROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` GROUP BY `Gender`;

/* KPI - 8)   Calculate Average Job Satisfaction Gender wise*/
SELECT Gender, ROUND(AVG(`JobSatisfaction`),3) AS `Average Job Satisfaction Rating` fROM hrdata1 GROUP BY `Gender`;

/* KPI - 9)   Calculate Overall Average Performance Rating Gender wise*/
SELECT hrdata1.Gender, ROUND(AVG(hrdata2.`PerformanceRating`),3) AS `Average Performance Rating` fROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` GROUP BY `Gender`;

#------ DESIGNATION WISE REPORT ---------------------------------#
#=================================================================#

/* REPORT - 1)   Calculate Total numbers of employees by Designation wise*/
SELECT JobRole AS `Designation`, COUNT(`EmployeeNumber`) AS `Total Employees` FROM hrdata1 GROUP BY JobRole ORDER BY `Total Employees` DESC;

/* REPORT - 2)   Calculate Total numbers of Ex-Employees by Designation wise*/
SELECT JobRole AS `Designation`, COUNT(`EmployeeNumber`) AS `Total Ex-Employees` FROM hrdata1 WHERE Attrition="Yes" GROUP BY JobRole ORDER BY `Total Ex-Employees` DESC;

/* REPORT - 3)   Calculate Total numbers of Active Employees by Designation wise*/
SELECT JobRole AS `Designation`, COUNT(`EmployeeNumber`) AS `Total Active Employees` FROM hrdata1 WHERE Attrition="No" GROUP BY JobRole ORDER BY `Total Active Employees` DESC;

/* REPORT - 4)   Calculate Total Monthly Income by Designation wise*/
SELECT hrdata1.JobRole AS `Designation`, CONCAT(ROUND(SUM(hrdata2.`MonthlyIncome`)/1000000),"M") AS `Total Monthly Income` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` GROUP BY hrdata1.JobRole ORDER BY `Total Monthly Income` DESC;

/* REPORT - 5)   Calculate Total Ex-Employees Monthly Income by Designation wise*/
SELECT hrdata1.JobRole AS `Designation`, CONCAT(ROUND(SUM(hrdata2.`MonthlyIncome`)/1000000),"M") AS `Ex-Employees Monthly Income` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata1.Attrition="Yes" GROUP BY hrdata1.JobRole ORDER BY `Ex-Employees Monthly Income` DESC;

/* REPORT - 6)   Calculate Total Active Employees Monthly Income by Designation wise*/
SELECT hrdata1.JobRole AS `Designation`, CONCAT(ROUND(SUM(hrdata2.`MonthlyIncome`)/1000000),"M") AS `Active Employees Monthly Income` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata1.Attrition="No" GROUP BY hrdata1.JobRole ORDER BY `Active Employees Monthly Income` DESC;

/* REPORT - 7)   Calculate Total Monthly Rate by Designation wise*/
SELECT hrdata1.JobRole AS `Designation`, CONCAT(ROUND(SUM(hrdata2.`MonthlyRate`)/1000000),"M") AS `Total Monthly Rate` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` GROUP BY hrdata1.JobRole ORDER BY `Total Monthly Rate` DESC;

/* REPORT - 8)   Calculate Total Ex-Employees Monthly Rate by Designation wise*/
SELECT hrdata1.JobRole AS `Designation`, CONCAT(ROUND(SUM(hrdata2.`MonthlyRate`)/1000000),"M") AS `Ex-Employees Monthly Rate` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata1.Attrition="Yes" GROUP BY hrdata1.JobRole ORDER BY `Ex-Employees Monthly Rate` DESC;

/* REPORT - 9)   Calculate Total Active Employees Monthly Rate by Designation wise*/
SELECT hrdata1.JobRole AS `Designation`, CONCAT(ROUND(SUM(hrdata2.`MonthlyRate`)/1000000),"M") AS `Active Employees Monthly Rate` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata1.Attrition="No" GROUP BY hrdata1.JobRole ORDER BY `Active Employees Monthly Rate` DESC;

/* REPORT - 10)   Calculate Average Salary Hike by Designation wise*/
SELECT hrdata1.JobRole AS `Designation`, CONCAT(ROUND(AVG(hrdata2.`PercentSalaryHike`),3),"%") AS `Average Salary Hike` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` GROUP BY hrdata1.JobRole ORDER BY `Average Salary Hike` DESC;

/* REPORT - 11)   Calculate Active Employees Average Salary Hike by Designation wise*/
SELECT hrdata1.JobRole AS `Designation`, CONCAT(ROUND(AVG(hrdata2.`PercentSalaryHike`),3),"%") AS `Active Employees Average Salary Hike` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata1.Attrition="No" GROUP BY hrdata1.JobRole ORDER BY `Active Employees Average Salary Hike` DESC;

/* REPORT - 12)   Calculate Ex-Employees Average Salary Hike by Designation wise*/
SELECT hrdata1.JobRole AS `Designation`, CONCAT(ROUND(AVG(hrdata2.`PercentSalaryHike`),3),"%") AS `Ex-Employees Average Salary Hike` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata1.Attrition="Yes" GROUP BY hrdata1.JobRole ORDER BY `Ex-Employees Average Salary Hike` DESC;

/* REPORT - 13)   Calculate Average Job Satisfaction by Designation wise*/
SELECT JobRole AS `Designation`, ROUND(AVG(`JobSatisfaction`),3) AS `Average Job Satisfaction Rating` fROM hrdata1 GROUP BY JobRole ORDER BY `Average Job Satisfaction Rating` DESC;

/* REPORT - 14)   Calculate Active Employees Average Job Satisfaction by Designation wise*/
SELECT JobRole AS `Designation`, ROUND(AVG(`JobSatisfaction`),3) AS `Active Employees Job Satisfaction Rating` fROM hrdata1 WHERE Attrition="No" GROUP BY JobRole ORDER BY `Active Employees Job Satisfaction Rating` DESC;

/* REPORT - 15)   Calculate Ex-Employees Average Job Satisfaction by Designation wise*/
SELECT JobRole AS `Designation`, ROUND(AVG(`JobSatisfaction`),3) AS `Ex-Employees Job Satisfaction Rating` fROM hrdata1 WHERE Attrition="Yes" GROUP BY JobRole ORDER BY `Ex-Employees Job Satisfaction Rating` DESC;

/* REPORT - 16)   Calculate Overall Performance Rating by Designation wise*/
SELECT a.`Designation`, a.`Excellent`, b.`Good`, c.`Average`, d.`Poor` FROM
(SELECT hrdata1.JobRole AS `Designation`, COUNT(hrdata2.PerformanceRating) AS `Excellent` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=4 GROUP BY hrdata1.JobRole) AS a
JOIN 
(SELECT hrdata1.JobRole AS `Designation`, COUNT(hrdata2.PerformanceRating) AS `Good` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=3 GROUP BY hrdata1.JobRole) AS b
ON a.`Designation`=b.`Designation`
JOIN
(SELECT hrdata1.JobRole AS `Designation`, COUNT(hrdata2.PerformanceRating) AS `Average` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=2 GROUP BY hrdata1.JobRole) AS c
ON b.`Designation`=c.`Designation`
JOIN
(SELECT hrdata1.JobRole AS `Designation`, COUNT(hrdata2.PerformanceRating) AS `Poor` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=1 GROUP BY hrdata1.JobRole) AS d
ON c.`Designation`=d.`Designation`;


/* REPORT - 17)   Calculate Active Employees Overall Performance Rating by Designation wise*/
SELECT a.`Designation`, a.`Excellent`, b.`Good`, c.`Average`, d.`Poor` FROM
(SELECT hrdata1.JobRole AS `Designation`, COUNT(hrdata2.PerformanceRating) AS `Excellent` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=4 AND hrdata1.Attrition="No" GROUP BY hrdata1.JobRole) AS a
JOIN 
(SELECT hrdata1.JobRole AS `Designation`, COUNT(hrdata2.PerformanceRating) AS `Good` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=3 AND hrdata1.Attrition="No" GROUP BY hrdata1.JobRole) AS b
ON a.`Designation`=b.`Designation`
JOIN
(SELECT hrdata1.JobRole AS `Designation`, COUNT(hrdata2.PerformanceRating) AS `Average` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=2 AND hrdata1.Attrition="No" GROUP BY hrdata1.JobRole) AS c
ON b.`Designation`=c.`Designation`
JOIN
(SELECT hrdata1.JobRole AS `Designation`, COUNT(hrdata2.PerformanceRating) AS `Poor` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=1 AND hrdata1.Attrition="No" GROUP BY hrdata1.JobRole) AS d
ON c.`Designation`=d.`Designation`;

/* REPORT - 18)   Calculate Ex-Employees Overall Performance Rating by Designation wise*/
SELECT a.`Designation`, a.`Excellent`, b.`Good`, c.`Average`, d.`Poor` FROM
(SELECT hrdata1.JobRole AS `Designation`, COUNT(hrdata2.PerformanceRating) AS `Excellent` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=4 AND hrdata1.Attrition="Yes" GROUP BY hrdata1.JobRole) AS a
JOIN 
(SELECT hrdata1.JobRole AS `Designation`, COUNT(hrdata2.PerformanceRating) AS `Good` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=3 AND hrdata1.Attrition="Yes" GROUP BY hrdata1.JobRole) AS b
ON a.`Designation`=b.`Designation`
JOIN
(SELECT hrdata1.JobRole AS `Designation`, COUNT(hrdata2.PerformanceRating) AS `Average` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=2 AND hrdata1.Attrition="Yes" GROUP BY hrdata1.JobRole) AS c
ON b.`Designation`=c.`Designation`
JOIN
(SELECT hrdata1.JobRole AS `Designation`, COUNT(hrdata2.PerformanceRating) AS `Poor` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=1 AND hrdata1.Attrition="Yes" GROUP BY hrdata1.JobRole) AS d
ON c.`Designation`=d.`Designation`;

#------ EDUCATION FIELD WISE REPORT ---------------------------------#
#====================================================================#

/* REPORT - 1)   Calculate Total numbers of employees by Education Field wise*/
SELECT EducationField AS `Education`, COUNT(`EmployeeNumber`) AS `Total Employees` FROM hrdata1 GROUP BY EducationField ORDER BY `Total Employees` DESC;

/* REPORT - 2)   Calculate Total numbers of Ex-Employees by Education Field wise*/
SELECT EducationField AS `Education`, COUNT(`EmployeeNumber`) AS `Total Ex-Employees` FROM hrdata1 WHERE Attrition="Yes" GROUP BY EducationField ORDER BY `Total Ex-Employees` DESC;

/* REPORT - 3)   Calculate Total numbers of Active Employees by Education Field wise*/
SELECT EducationField AS `Education`, COUNT(`EmployeeNumber`) AS `Total Active Employees` FROM hrdata1 WHERE Attrition="No" GROUP BY EducationField ORDER BY `Total Active Employees` DESC;

/* REPORT - 4)   Calculate Total Monthly Income by Education Field wise*/
SELECT hrdata1.EducationField AS `Education`, CONCAT(ROUND(SUM(hrdata2.`MonthlyIncome`)/1000000),"M") AS `Total Monthly Income` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` GROUP BY hrdata1.EducationField ORDER BY `Total Monthly Income` DESC;

/* REPORT - 5)   Calculate Total Ex-Employees Monthly Income by Education Field wise*/
SELECT hrdata1.EducationField AS `Education`, CONCAT(ROUND(SUM(hrdata2.`MonthlyIncome`)/1000000),"M") AS `Ex-Employees Monthly Income` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata1.Attrition="Yes" GROUP BY hrdata1.EducationField ORDER BY `Ex-Employees Monthly Income` DESC;

/* REPORT - 6)   Calculate Total Active Employees Monthly Income by Education Field wise*/
SELECT hrdata1.EducationField AS `Education`, CONCAT(ROUND(SUM(hrdata2.`MonthlyIncome`)/1000000),"M") AS `Active Employees Monthly Income` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata1.Attrition="No" GROUP BY hrdata1.EducationField ORDER BY `Active Employees Monthly Income` DESC;

/* REPORT - 7)   Calculate Total Monthly Rate by Education Field wise*/
SELECT hrdata1.EducationField AS `Education`, CONCAT(ROUND(SUM(hrdata2.`MonthlyRate`)/1000000),"M") AS `Total Monthly Rate` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` GROUP BY hrdata1.EducationField ORDER BY `Total Monthly Rate` DESC;

/* REPORT - 8)   Calculate Total Ex-Employees Monthly Rate by Education Field wise*/
SELECT hrdata1.EducationField AS `Education`, CONCAT(ROUND(SUM(hrdata2.`MonthlyRate`)/1000000),"M") AS `Ex-Employees Monthly Rate` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata1.Attrition="Yes" GROUP BY hrdata1.EducationField ORDER BY `Ex-Employees Monthly Rate` DESC;

/* REPORT - 9)   Calculate Total Active Employees Monthly Rate by Education Field wise*/
SELECT hrdata1.EducationField AS `Education`, CONCAT(ROUND(SUM(hrdata2.`MonthlyRate`)/1000000),"M") AS `Active Employees Monthly Rate` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata1.Attrition="No" GROUP BY hrdata1.EducationField ORDER BY `Active Employees Monthly Rate` DESC;

/* REPORT - 10)   Calculate Average Salary Hike by Education Field wise*/
SELECT hrdata1.EducationField AS `Education`, CONCAT(ROUND(AVG(hrdata2.`PercentSalaryHike`),3),"%") AS `Average Salary Hike` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` GROUP BY hrdata1.EducationField ORDER BY `Average Salary Hike` DESC;

/* REPORT - 11)   Calculate Active Employees Average Salary Hike by Education Field wise*/
SELECT hrdata1.EducationField AS `Education`, CONCAT(ROUND(AVG(hrdata2.`PercentSalaryHike`),3),"%") AS `Active Employees Average Salary Hike` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata1.Attrition="No" GROUP BY hrdata1.EducationField ORDER BY `Active Employees Average Salary Hike` DESC;

/* REPORT - 12)   Calculate Ex-Employees Average Salary Hike by Education Field wise*/
SELECT hrdata1.EducationField AS `Education`, CONCAT(ROUND(AVG(hrdata2.`PercentSalaryHike`),3),"%") AS `Ex-Employees Average Salary Hike` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata1.Attrition="Yes" GROUP BY hrdata1.EducationField ORDER BY `Ex-Employees Average Salary Hike` DESC;

/* REPORT - 13)   Calculate Average Job Satisfaction by Education Field wise*/
SELECT EducationField AS `Education`, ROUND(AVG(`JobSatisfaction`),3) AS `Average Job Satisfaction Rating` fROM hrdata1 GROUP BY EducationField ORDER BY `Average Job Satisfaction Rating` DESC;

/* REPORT - 14)   Calculate Active Employees Average Job Satisfaction by Education Field wise*/
SELECT EducationField AS `Education`, ROUND(AVG(`JobSatisfaction`),3) AS `Active Employees Job Satisfaction Rating` fROM hrdata1 WHERE Attrition="No" GROUP BY EducationField ORDER BY `Active Employees Job Satisfaction Rating` DESC;

/* REPORT - 15)   Calculate Ex-Employees Average Job Satisfaction by Education Field wise*/
SELECT EducationField AS `Education`, ROUND(AVG(`JobSatisfaction`),3) AS `Ex-Employees Job Satisfaction Rating` fROM hrdata1 WHERE Attrition="Yes" GROUP BY EducationField ORDER BY `Ex-Employees Job Satisfaction Rating` DESC;

/* REPORT - 16)   Calculate Overall Performance Rating by Education Field wise*/
SELECT a.`Education`, a.`Excellent`, b.`Good`, c.`Average`, d.`Poor` FROM
(SELECT hrdata1.EducationField AS `Education`, COUNT(hrdata2.PerformanceRating) AS `Excellent` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=4 GROUP BY hrdata1.EducationField) AS a
JOIN 
(SELECT hrdata1.EducationField AS `Education`, COUNT(hrdata2.PerformanceRating) AS `Good` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=3 GROUP BY hrdata1.EducationField) AS b
ON a.`Education`=b.`Education`
JOIN
(SELECT hrdata1.EducationField AS `Education`, COUNT(hrdata2.PerformanceRating) AS `Average` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=2 GROUP BY hrdata1.EducationField) AS c
ON b.`Education`=c.`Education`
JOIN
(SELECT hrdata1.EducationField AS `Education`, COUNT(hrdata2.PerformanceRating) AS `Poor` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=1 GROUP BY hrdata1.EducationField) AS d
ON c.`Education`=d.`Education`;

/* REPORT - 17)   Calculate Active Employees Overall Performance Rating by Education Field wise*/
SELECT a.`Education`, a.`Excellent`, b.`Good`, c.`Average`, d.`Poor` FROM
(SELECT hrdata1.EducationField AS `Education`, COUNT(hrdata2.PerformanceRating) AS `Excellent` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=4 AND hrdata1.Attrition="No" GROUP BY hrdata1.EducationField) AS a
JOIN 
(SELECT hrdata1.EducationField AS `Education`, COUNT(hrdata2.PerformanceRating) AS `Good` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=3 AND hrdata1.Attrition="No" GROUP BY hrdata1.EducationField) AS b
ON a.`Education`=b.`Education`
JOIN
(SELECT hrdata1.EducationField AS `Education`, COUNT(hrdata2.PerformanceRating) AS `Average` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=2 AND hrdata1.Attrition="No" GROUP BY hrdata1.EducationField) AS c
ON b.`Education`=c.`Education`
JOIN
(SELECT hrdata1.EducationField AS `Education`, COUNT(hrdata2.PerformanceRating) AS `Poor` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=1 AND hrdata1.Attrition="No" GROUP BY hrdata1.EducationField) AS d
ON c.`Education`=d.`Education`;

/* REPORT - 18)   Calculate Ex-Employees Overall Performance Rating by Education Field wise*/
SELECT a.`Education`, a.`Excellent`, b.`Good`, c.`Average`, d.`Poor` FROM
(SELECT hrdata1.EducationField AS `Education`, COUNT(hrdata2.PerformanceRating) AS `Excellent` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=4 AND hrdata1.Attrition="Yes" GROUP BY hrdata1.EducationField) AS a
JOIN 
(SELECT hrdata1.EducationField AS `Education`, COUNT(hrdata2.PerformanceRating) AS `Good` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=3 AND hrdata1.Attrition="Yes" GROUP BY hrdata1.EducationField) AS b
ON a.`Education`=b.`Education`
JOIN
(SELECT hrdata1.EducationField AS `Education`, COUNT(hrdata2.PerformanceRating) AS `Average` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=2 AND hrdata1.Attrition="Yes" GROUP BY hrdata1.EducationField) AS c
ON b.`Education`=c.`Education`
JOIN
(SELECT hrdata1.EducationField AS `Education`, COUNT(hrdata2.PerformanceRating) AS `Poor` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=1 AND hrdata1.Attrition="Yes" GROUP BY hrdata1.EducationField) AS d
ON c.`Education`=d.`Education`;

#------ DEPARTMENT WISE REPORT ---------------------------------#
#===============================================================#

/* REPORT - 1)   Calculate Total numbers of employees by DEPARTMENT Field wise*/
SELECT Department AS `Department`, COUNT(`EmployeeNumber`) AS `Total Employees` FROM hrdata1 GROUP BY Department ORDER BY `Total Employees` DESC;

/* REPORT - 2)   Calculate Total numbers of Ex-Employees by DEPARTMENT Field wise*/
SELECT Department AS `Department`, COUNT(`EmployeeNumber`) AS `Total Ex-Employees` FROM hrdata1 WHERE Attrition="Yes" GROUP BY Department ORDER BY `Total Ex-Employees` DESC;

/* REPORT - 3)   Calculate Total numbers of Active Employees by DEPARTMENT Field wise*/
SELECT Department AS `Department`, COUNT(`EmployeeNumber`) AS `Total Active Employees` FROM hrdata1 WHERE Attrition="No" GROUP BY Department ORDER BY `Total Active Employees` DESC;

/* REPORT - 4)   Calculate Total Monthly Income by DEPARTMENT Field wise*/
SELECT hrdata1.Department AS `Department`, CONCAT(ROUND(SUM(hrdata2.`MonthlyIncome`)/1000000),"M") AS `Total Monthly Income` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` GROUP BY hrdata1.Department ORDER BY `Total Monthly Income` DESC;

/* REPORT - 5)   Calculate Total Ex-Employees Monthly Income by DEPARTMENT Field wise*/
SELECT hrdata1.Department AS `Department`, CONCAT(ROUND(SUM(hrdata2.`MonthlyIncome`)/1000000),"M") AS `Ex-Employees Monthly Income` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata1.Attrition="Yes" GROUP BY hrdata1.Department ORDER BY `Ex-Employees Monthly Income` DESC;

/* REPORT - 6)   Calculate Total Active Employees Monthly Income by DEPARTMENT Field wise*/
SELECT hrdata1.Department AS `Department`, CONCAT(ROUND(SUM(hrdata2.`MonthlyIncome`)/1000000),"M") AS `Active Employees Monthly Income` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata1.Attrition="No" GROUP BY hrdata1.Department ORDER BY `Active Employees Monthly Income` DESC;

/* REPORT - 7)   Calculate Total Monthly Rate by DEPARTMENT Field wise*/
SELECT hrdata1.Department AS `Department`, CONCAT(ROUND(SUM(hrdata2.`MonthlyRate`)/1000000),"M") AS `Total Monthly Rate` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` GROUP BY hrdata1.Department ORDER BY `Total Monthly Rate` DESC;

/* REPORT - 8)   Calculate Total Ex-Employees Monthly Rate by DEPARTMENT Field wise*/
SELECT hrdata1.Department AS `Department`, CONCAT(ROUND(SUM(hrdata2.`MonthlyRate`)/1000000),"M") AS `Ex-Employees Monthly Rate` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata1.Attrition="Yes" GROUP BY hrdata1.Department ORDER BY `Ex-Employees Monthly Rate` DESC;

/* REPORT - 9)   Calculate Total Active Employees Monthly Rate by DEPARTMENT Field wise*/
SELECT hrdata1.Department AS `Department`, CONCAT(ROUND(SUM(hrdata2.`MonthlyRate`)/1000000),"M") AS `Active Employees Monthly Rate` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata1.Attrition="No" GROUP BY hrdata1.Department ORDER BY `Active Employees Monthly Rate` DESC;

/* REPORT - 10)   Calculate Average Salary Hike by DEPARTMENT Field wise*/
SELECT hrdata1.Department AS `Department`, CONCAT(ROUND(AVG(hrdata2.`PercentSalaryHike`),3),"%") AS `Average Salary Hike` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` GROUP BY hrdata1.Department ORDER BY `Average Salary Hike` DESC;

/* REPORT - 11)   Calculate Active Employees Average Salary Hike by DEPARTMENT Field wise*/
SELECT hrdata1.Department AS `Department`, CONCAT(ROUND(AVG(hrdata2.`PercentSalaryHike`),3),"%") AS `Active Employees Average Salary Hike` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata1.Attrition="No" GROUP BY hrdata1.Department ORDER BY `Active Employees Average Salary Hike` DESC;

/* REPORT - 12)   Calculate Ex-Employees Average Salary Hike by DEPARTMENT Field wise*/
SELECT hrdata1.Department AS `Department`, CONCAT(ROUND(AVG(hrdata2.`PercentSalaryHike`),3),"%") AS `Ex-Employees Average Salary Hike` FROM hrdata2 JOIN hrdata1 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata1.Attrition="Yes" GROUP BY hrdata1.Department ORDER BY `Ex-Employees Average Salary Hike` DESC;

/* REPORT - 13)   Calculate Average Job Satisfaction by DEPARTMENT Field wise*/
SELECT Department AS `Department`, ROUND(AVG(`JobSatisfaction`),3) AS `Average Job Satisfaction Rating` fROM hrdata1 GROUP BY Department ORDER BY `Average Job Satisfaction Rating` DESC;

/* REPORT - 14)   Calculate Active Employees Average Job Satisfaction by DEPARTMENT Field wise*/
SELECT Department AS `Department`, ROUND(AVG(`JobSatisfaction`),3) AS `Active Employees Job Satisfaction Rating` fROM hrdata1 WHERE Attrition="No" GROUP BY Department ORDER BY `Active Employees Job Satisfaction Rating` DESC;

/* REPORT - 15)   Calculate Ex-Employees Average Job Satisfaction by DEPARTMENT Field wise*/
SELECT Department AS `Department`, ROUND(AVG(`JobSatisfaction`),3) AS `Ex-Employees Job Satisfaction Rating` fROM hrdata1 WHERE Attrition="Yes" GROUP BY Department ORDER BY `Ex-Employees Job Satisfaction Rating` DESC;

/* REPORT - 16)   Calculate Overall Performance Rating by DEPARTMENT Field wise*/
SELECT a.`Department`, a.`Excellent`, b.`Good`, c.`Average`, d.`Poor` FROM
(SELECT hrdata1.Department AS `Department`, COUNT(hrdata2.PerformanceRating) AS `Excellent` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=4 GROUP BY hrdata1.Department) AS a
JOIN 
(SELECT hrdata1.Department AS `Department`, COUNT(hrdata2.PerformanceRating) AS `Good` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=3 GROUP BY hrdata1.Department) AS b
ON a.`Department`=b.`Department`
JOIN
(SELECT hrdata1.Department AS `Department`, COUNT(hrdata2.PerformanceRating) AS `Average` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=2 GROUP BY hrdata1.Department) AS c
ON b.`Department`=c.`Department`
JOIN
(SELECT hrdata1.Department AS `Department`, COUNT(hrdata2.PerformanceRating) AS `Poor` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=1 GROUP BY hrdata1.Department) AS d
ON c.`Department`=d.`Department`;

/* REPORT - 17)   Calculate Active Employees Overall Performance Rating by DEPARTMENT Field wise*/
SELECT a.`Department`, a.`Excellent`, b.`Good`, c.`Average`, d.`Poor` FROM
(SELECT hrdata1.Department AS `Department`, COUNT(hrdata2.PerformanceRating) AS `Excellent` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=4 AND hrdata1.Attrition="No" GROUP BY hrdata1.Department) AS a
JOIN 
(SELECT hrdata1.Department AS `Department`, COUNT(hrdata2.PerformanceRating) AS `Good` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=3 AND hrdata1.Attrition="No" GROUP BY hrdata1.Department) AS b
ON a.`Department`=b.`Department`
JOIN
(SELECT hrdata1.Department AS `Department`, COUNT(hrdata2.PerformanceRating) AS `Average` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=2 AND hrdata1.Attrition="No" GROUP BY hrdata1.Department) AS c
ON b.`Department`=c.`Department`
JOIN
(SELECT hrdata1.Department AS `Department`, COUNT(hrdata2.PerformanceRating) AS `Poor` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=1 AND hrdata1.Attrition="No" GROUP BY hrdata1.Department) AS d
ON c.`Department`=d.`Department`;

/* REPORT - 18)   Calculate Ex-Employees Overall Performance Rating by DEPARTMENT Field wise*/
SELECT a.`Department`, a.`Excellent`, b.`Good`, c.`Average`, d.`Poor` FROM
(SELECT hrdata1.Department AS `Department`, COUNT(hrdata2.PerformanceRating) AS `Excellent` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=4 AND hrdata1.Attrition="Yes" GROUP BY hrdata1.Department) AS a
JOIN 
(SELECT hrdata1.Department AS `Department`, COUNT(hrdata2.PerformanceRating) AS `Good` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=3 AND hrdata1.Attrition="Yes" GROUP BY hrdata1.Department) AS b
ON a.`Department`=b.`Department`
JOIN
(SELECT hrdata1.Department AS `Department`, COUNT(hrdata2.PerformanceRating) AS `Average` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=2 AND hrdata1.Attrition="Yes" GROUP BY hrdata1.Department) AS c
ON b.`Department`=c.`Department`
JOIN
(SELECT hrdata1.Department AS `Department`, COUNT(hrdata2.PerformanceRating) AS `Poor` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE hrdata2.PerformanceRating=1 AND hrdata1.Attrition="Yes" GROUP BY hrdata1.Department) AS d
ON c.`Department`=d.`Department`;


#------ WORKING YEAR WISE REPORT ---------------------------------#
#=================================================================#

/* REPORT - 1) Calculate Total Employees by Working Years wise*/
SELECT a.`Years`, a.`0-10`, b.`11-20`, c.`21-30`, d.`31+` FROM
(SELECT "Total Employees" AS `Years`, COUNT(hrdata1.`EmployeeNumber`) AS `0-10` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` <=10) AS a
JOIN
(SELECT "Total Employees" AS `Years`, COUNT(hrdata1.`EmployeeNumber`) AS `11-20` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=11 AND `TotalWorkingYears` <=20) AS b
ON a.`Years`=b.`Years`
JOIN
(SELECT "Total Employees" AS `Years`, COUNT(hrdata1.`EmployeeNumber`) AS `21-30` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=21 AND `TotalWorkingYears` <=30) AS c
ON b.`Years`=c.`Years`
JOIN
(SELECT "Total Employees" AS `Years`, COUNT(hrdata1.`EmployeeNumber`) AS `31+` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=31) AS d
ON c.`Years`=d.`Years`;

/* REPORT - 2) Calculate Total Ex-Employees by Working Years wise*/
SELECT a.`Years`, a.`0-10`, b.`11-20`, c.`21-30`, d.`31+` FROM
(SELECT "Total Ex-Employees" AS `Years`, COUNT(hrdata1.`EmployeeNumber`) AS `0-10` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` <=10 AND hrdata1.Attrition="Yes") AS a
JOIN
(SELECT "Total Ex-Employees" AS `Years`, COUNT(hrdata1.`EmployeeNumber`) AS `11-20` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=11 AND `TotalWorkingYears` <=20 AND hrdata1.Attrition="Yes") AS b
ON a.`Years`=b.`Years`
JOIN
(SELECT "Total Ex-Employees" AS `Years`, COUNT(hrdata1.`EmployeeNumber`) AS `21-30` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=21 AND `TotalWorkingYears` <=30 AND hrdata1.Attrition="Yes") AS c
ON b.`Years`=c.`Years`
JOIN
(SELECT "Total Ex-Employees" AS `Years`, COUNT(hrdata1.`EmployeeNumber`) AS `31+` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=31 AND hrdata1.Attrition="Yes") AS d
ON c.`Years`=d.`Years`;

/* REPORT - 3) Calculate Total Active Employees by Working Years wise*/
SELECT a.`Years`, a.`0-10`, b.`11-20`, c.`21-30`, d.`31+` FROM
(SELECT "Total Active Employees" AS `Years`, COUNT(hrdata1.`EmployeeNumber`) AS `0-10` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` <=10 AND hrdata1.Attrition="No") AS a
JOIN
(SELECT "Total Active Employees" AS `Years`, COUNT(hrdata1.`EmployeeNumber`) AS `11-20` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=11 AND `TotalWorkingYears` <=20 AND hrdata1.Attrition="No") AS b
ON a.`Years`=b.`Years`
JOIN
(SELECT "Total Active Employees" AS `Years`, COUNT(hrdata1.`EmployeeNumber`) AS `21-30` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=21 AND `TotalWorkingYears` <=30 AND hrdata1.Attrition="No") AS c
ON b.`Years`=c.`Years`
JOIN
(SELECT "Total Active Employees" AS `Years`, COUNT(hrdata1.`EmployeeNumber`) AS `31+` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=31 AND hrdata1.Attrition="No") AS d
ON c.`Years`=d.`Years`;

/* REPORT - 4) Calculate Total Mothly Income by Working Years wise*/
SELECT a.`Years`, a.`0-10`, b.`11-20`, c.`21-30`, d.`31+` FROM
(SELECT "Total Mothly Income" AS `Years`, CONCAT(ROUND(SUM(hrdata2.`MonthlyIncome`)/1000000),"M") AS `0-10` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` <=10) AS a
JOIN
(SELECT "Total Mothly Income" AS `Years`, CONCAT(ROUND(SUM(hrdata2.`MonthlyIncome`)/1000000),"M") AS `11-20` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=11 AND `TotalWorkingYears` <=20) AS b
ON a.`Years`=b.`Years`
JOIN
(SELECT "Total Mothly Income" AS `Years`, CONCAT(ROUND(SUM(hrdata2.`MonthlyIncome`)/1000000),"M") AS `21-30` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=21 AND `TotalWorkingYears` <=30) AS c
ON b.`Years`=c.`Years`
JOIN
(SELECT "Total Mothly Income" AS `Years`, CONCAT(ROUND(SUM(hrdata2.`MonthlyIncome`)/1000000),"M") AS `31+` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=31) AS d
ON c.`Years`=d.`Years`;

/* REPORT - 5) Calculate Total Mothly Rate by Working Years wise*/
SELECT a.`Years`, a.`0-10`, b.`11-20`, c.`21-30`, d.`31+` FROM
(SELECT "Total Mothly Rate" AS `Years`, CONCAT(ROUND(AVG(hrdata2.`MonthlyRate`)/1000,2),"K") AS `0-10` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` <=10) AS a
JOIN
(SELECT "Total Mothly Rate" AS `Years`, CONCAT(ROUND(AVG(hrdata2.`MonthlyRate`)/1000,2),"K") AS `11-20` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=11 AND `TotalWorkingYears` <=20) AS b
ON a.`Years`=b.`Years`
JOIN
(SELECT "Total Mothly Rate" AS `Years`, CONCAT(ROUND(AVG(hrdata2.`MonthlyRate`)/1000,2),"K") AS `21-30` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=21 AND `TotalWorkingYears` <=30) AS c
ON b.`Years`=c.`Years`
JOIN
(SELECT "Total Mothly Rate" AS `Years`, CONCAT(ROUND(AVG(hrdata2.`MonthlyRate`)/1000,2),"K") AS `31+` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=31) AS d
ON c.`Years`=d.`Years`;

/* REPORT - 6) Calculate Average Salary Hike by Working Years wise*/
SELECT a.`Years`, a.`0-10`, b.`11-20`, c.`21-30`, d.`31+` FROM
(SELECT "Average Salary Hike" AS `Years`, CONCAT(ROUND(AVG(hrdata2.`PercentSalaryHike`),2),"%") AS `0-10` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` <=10) AS a
JOIN
(SELECT "Average Salary Hike" AS `Years`, CONCAT(ROUND(AVG(hrdata2.`PercentSalaryHike`),2),"%") AS `11-20` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=11 AND `TotalWorkingYears` <=20) AS b
ON a.`Years`=b.`Years`
JOIN
(SELECT "Average Salary Hike" AS `Years`, CONCAT(ROUND(AVG(hrdata2.`PercentSalaryHike`),2),"%") AS `21-30` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=21 AND `TotalWorkingYears` <=30) AS c
ON b.`Years`=c.`Years`
JOIN
(SELECT "Average Salary Hike" AS `Years`, CONCAT(ROUND(AVG(hrdata2.`PercentSalaryHike`),2),"%") AS `31+` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=31) AS d
ON c.`Years`=d.`Years`;

/* REPORT - 7) Calculate Average Job Satisfaction by Working Years wise*/
SELECT a.`Years`, a.`0-10`, b.`11-20`, c.`21-30`, d.`31+` FROM
(SELECT "Job Satisfaction" AS `Years`, ROUND(AVG(hrdata1.`JobSatisfaction`),2) AS `0-10` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` <=10) AS a
JOIN
(SELECT "Job Satisfaction" AS `Years`, ROUND(AVG(hrdata1.`JobSatisfaction`),2) AS `11-20` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=11 AND `TotalWorkingYears` <=20) AS b
ON a.`Years`=b.`Years`
JOIN
(SELECT "Job Satisfaction" AS `Years`, ROUND(AVG(hrdata1.`JobSatisfaction`),2) AS `21-30` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=21 AND `TotalWorkingYears` <=30) AS c
ON b.`Years`=c.`Years`
JOIN
(SELECT "Job Satisfaction" AS `Years`, ROUND(AVG(hrdata1.`JobSatisfaction`),2) AS `31+` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=31) AS d
ON c.`Years`=d.`Years`;

/* REPORT - 8) Calculate Average Performance Ratings by Working Years wise*/
SELECT a.`Years`, a.`0-10`, b.`11-20`, c.`21-30`, d.`31+` FROM
(SELECT "Performance Ratings" AS `Years`, ROUND(AVG(hrdata2.`PerformanceRating`),3) AS `0-10` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` <=10) AS a
JOIN
(SELECT "Performance Ratings" AS `Years`, ROUND(AVG(hrdata2.`PerformanceRating`),3) AS `11-20` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=11 AND `TotalWorkingYears` <=20) AS b
ON a.`Years`=b.`Years`
JOIN
(SELECT "Performance Ratings" AS `Years`, ROUND(AVG(hrdata2.`PerformanceRating`),3) AS `21-30` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=21 AND `TotalWorkingYears` <=30) AS c
ON b.`Years`=c.`Years`
JOIN
(SELECT "Performance Ratings" AS `Years`, ROUND(AVG(hrdata2.`PerformanceRating`),3) AS `31+` FROM hrdata1 JOIN hrdata2 ON hrdata2.`Employee ID`=hrdata1.`EmployeeNumber` WHERE `TotalWorkingYears` >=31) AS d
ON c.`Years`=d.`Years`;

#------ MARITAL/TRAVEL WISE REPORT ---------------------------------#
#===================================================================#

/* REPORT - 1) Calculate Total Employees by Marital/Travel wise*/
SELECT a.`Travel Status`, a.`Single`, b.`Married`, c.`Divorced` FROM
(SELECT BusinessTravel AS `Travel Status`, COUNT(`EmployeeNumber`) AS `Single` FROM hrdata1 WHERE MaritalStatus = "Single" GROUP BY `Travel Status`) AS a
JOIN
(SELECT BusinessTravel AS `Travel Status`, COUNT(`EmployeeNumber`) AS `Married` FROM hrdata1 WHERE MaritalStatus = "Married" GROUP BY `Travel Status`) AS b
ON a.`Travel Status`=b.`Travel Status`
JOIN
(SELECT BusinessTravel AS `Travel Status`, COUNT(`EmployeeNumber`) AS `Divorced` FROM hrdata1 WHERE MaritalStatus = "Divorced" GROUP BY `Travel Status`) AS c
ON b.`Travel Status`=c.`Travel Status`;

/* REPORT - 2) Calculate Total Ex-Employees by Marital/Travel wise*/
SELECT a.`Travel Status`, a.`Single`, b.`Married`, c.`Divorced` FROM
(SELECT BusinessTravel AS `Travel Status`, COUNT(`EmployeeNumber`) AS `Single` FROM hrdata1 WHERE MaritalStatus = "Single" AND hrdata1.Attrition="Yes" GROUP BY `Travel Status`) AS a
JOIN
(SELECT BusinessTravel AS `Travel Status`, COUNT(`EmployeeNumber`) AS `Married` FROM hrdata1 WHERE MaritalStatus = "Married" AND hrdata1.Attrition="Yes" GROUP BY `Travel Status`) AS b
ON a.`Travel Status`=b.`Travel Status`
JOIN
(SELECT BusinessTravel AS `Travel Status`, COUNT(`EmployeeNumber`) AS `Divorced` FROM hrdata1 WHERE MaritalStatus = "Divorced" AND hrdata1.Attrition="Yes" GROUP BY `Travel Status`) AS c
ON b.`Travel Status`=c.`Travel Status`;

/* REPORT - 3) Calculate Total Active Employees by Marital/Travel wise*/
SELECT a.`Travel Status`, a.`Single`, b.`Married`, c.`Divorced` FROM
(SELECT BusinessTravel AS `Travel Status`, COUNT(`EmployeeNumber`) AS `Single` FROM hrdata1 WHERE MaritalStatus = "Single" AND hrdata1.Attrition="No" GROUP BY `Travel Status`) AS a
JOIN
(SELECT BusinessTravel AS `Travel Status`, COUNT(`EmployeeNumber`) AS `Married` FROM hrdata1 WHERE MaritalStatus = "Married" AND hrdata1.Attrition="No" GROUP BY `Travel Status`) AS b
ON a.`Travel Status`=b.`Travel Status`
JOIN
(SELECT BusinessTravel AS `Travel Status`, COUNT(`EmployeeNumber`) AS `Divorced` FROM hrdata1 WHERE MaritalStatus = "Divorced" AND hrdata1.Attrition="No" GROUP BY `Travel Status`) AS c
ON b.`Travel Status`=c.`Travel Status`;