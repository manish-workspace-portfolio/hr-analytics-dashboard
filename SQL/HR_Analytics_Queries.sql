USE Project;

CREATE VIEW HR_Data AS
SELECT
    h1.*,
    h2.MonthlyIncome,
    h2.MonthlyRate,
    h2.NumCompaniesWorked,
    h2.Over18,
    h2.OverTime,
    h2.PercentSalaryHike,
    h2.PerformanceRating,
    h2.RelationshipSatisfaction,
    h2.StandardHours,
    h2.StockOptionLevel,
    h2.TotalWorkingYears,
    h2.TrainingTimesLastYear,
    h2.WorkLifeBalance,
    h2.YearsAtCompany,
    h2.YearsInCurrentRole,
    h2.YearsSinceLastPromotion,
    h2.YearsWithCurrManager
FROM hr1 h1
INNER JOIN hr2 h2
ON h1.EmployeeNumber = h2.`Employee ID`;
SELECT * FROM HR_Data LIMIT 5;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#KPI Attrition Rate VS Years Since Last Promotion Relation
SELECT
    YearsSinceLastPromotion,

    ROUND(
        SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
        *100.0 / COUNT(*),
        2
    ) AS Attrition_Rate

FROM HR_Data

GROUP BY YearsSinceLastPromotion

ORDER BY YearsSinceLastPromotion;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#KPI Job Role VS Work-Life Balance
SELECT
    JobRole,
    ROUND(AVG(WorkLifeBalance),2) AS Avg_WorkLifeBalance
FROM HR_Data
GROUP BY JobRole
ORDER BY Avg_WorkLifeBalance DESC;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#KPI Average Working Years for each Department
SELECT
    Department,
    ROUND(AVG(TotalWorkingYears),2) AS Avg_Working_Years
FROM HR_Data
GROUP BY Department;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#KPI Attrition Rate VS Monthly Income Stats
SELECT
    CASE
        WHEN MonthlyIncome < 5000 THEN '0-4999'
        WHEN MonthlyIncome < 10000 THEN '5000-9999'
        WHEN MonthlyIncome < 15000 THEN '10000-14999'
        WHEN MonthlyIncome < 20000 THEN '15000-19999'
        ELSE '20000+'
    END AS Income_Group,

    ROUND(
        SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
        *100.0 / COUNT(*),
        2
    ) AS Attrition_Rate

FROM HR_Data

GROUP BY Income_Group

ORDER BY MIN(MonthlyIncome);
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#KPI Average Hourly Rate of Male Research Scientist
SELECT
    ROUND(AVG(HourlyRate),2) AS Avg_Hourly_Rate
FROM HR_Data
WHERE Gender='Male'
AND JobRole='Research Scientist';
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#KPI Average Attrition Rate of each department
SELECT
    Department,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        *100.0 / COUNT(*),
        2
    ) AS Attrition_Rate
FROM HR_Data
GROUP BY Department;
