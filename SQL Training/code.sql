--1.1 Quiz Funnel
SELECT question, 
       count(DISTINCT user_id) as distinct_users
 FROM survey
 GROUP BY question;

--1.2 Home Try-On Funnel
SELECT DISTINCT q.user_id,
  h.user_id IS NOT NULL AS 'is_home_try_on',
  h.number_of_pairs,
  p.user_id IS NOT NULL AS 'is_purchase'
  	
FROM quiz as q
LEFT JOIN home_try_on as h
    on q.user_id = h.user_id
LEFT JOIN purchase as p
    on q.user_id = p.user_id
LIMIT 10;

--2.1 Purchase Rates
WITH funnel as 
(  SELECT DISTINCT q.user_id,
     h.user_id IS NOT NULL AS 'is_home_try_on',
     h.number_of_pairs,
     p.user_id IS NOT NULL AS 'is_purchase'
  	
FROM quiz as q
LEFT JOIN home_try_on as h
	on q.user_id = h.user_id
LEFT JOIN purchase as p
	on q.user_id = p.user_id
)

SELECT number_of_pairs,
     CASE WHEN is_purchase = 0
     	THEN "FALSE"
     ELSE "TRUE"
     END as purchased,
   COUNT(DISTINCT user_id) as qty_users
FROM funnel
WHERE number_of_pairs IS NOT NULL
GROUP BY number_of_pairs, is_purchase;

--2.2 Buying Trends
SELECT Style, 
  Model_Name,
  COUNT(user_id) as qty_sold
FROM purchase
Group by 1, 2
;