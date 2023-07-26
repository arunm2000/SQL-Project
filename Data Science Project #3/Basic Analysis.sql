/*How many public high schools in each zip code?*/
SELECT zip_code AS "Zip Code",COUNT(school_name) AS "Number of Schools"
FROM public_hs_data
GROUP BY zip_code;

/*How many public high schools in each state?*/
SELECT state_code AS "State", COUNT(school_name) AS "Number of Schools"
FROM public_hs_data
GROUP BY state_code;

/*Create case statement to give more information about the location using the 
locale_code*/
SELECT school_name AS "School Name", locale_code AS "Location Code",
CASE WHEN locale_code BETWEEN 11 AND 13 THEN "City"
WHEN locale_code BETWEEN 21 AND 23 THEN "Suburb"
WHEN locale_code BETWEEN 31 AND 33 THEN "Town"
WHEN locale_code BETWEEN 41 AND 43 THEN "Rural"
END AS "Level of Urbanization",
	
CASE
WHEN locale_code <= 23 THEN
CASE substr(locale_code,2,1)
WHEN "1" THEN "Large"
WHEN "2" THEN "Midsize"
WHEN "3" THEN "Small"
END

WHEN locale_code >= 31 THEN
CASE substr(locale_code,2,1)
WHEN "1" THEN "Fringe"
WHEN "2" THEN "Distant"
WHEN "3" THEN "Remote"
END
END AS "Size"

FROM public_hs_data;

/*What is the minimum, maximum and average median_household_income of the nation?*/
SELECT MIN(median_household_income) AS "Minimum median_household_income",
MAX(median_household_income) AS "Maximum median_household_income", 
AVG(median_household_income) AS "Average median_household_income"

FROM census_data
WHERE median_household_income != "NULL";

/*What is the minimum, maximum and average median_household_income of each state?*/
SELECT state_code AS "State",
MIN(median_household_income) AS "Minimum median_household_income",
MAX(median_household_income) AS "Maximum median_household_income", 
AVG(median_household_income) AS "Average median_household_income"

FROM census_data
WHERE median_household_income != "NULL"
GROUP BY state_code;

/*Joint Analysis*/

/*Do characteristics of the zip_code area, such as median_household_income, 
influence students' performance in high school?*/
SELECT

CASE WHEN median_household_income < 50000 THEN "Low Income"
WHEN median_household_income BETWEEN 50000 AND 100000 THEN "Medium Income"
WHEN median_household_income > 100000 THEN "High Income"
END AS IncomeGroup,
	
ROUND(AVG(pct_proficient_math)) AS "Math Proficiency (%)",
ROUND(AVG(pct_proficient_reading)) AS "Reading Proficiency (%)"

FROM public_hs_data
JOIN census_data
ON public_hs_data.zip_code = census_data.zip_code
WHERE median_household_income != "NULL"
GROUP BY 1
ORDER BY 2 DESC;

	