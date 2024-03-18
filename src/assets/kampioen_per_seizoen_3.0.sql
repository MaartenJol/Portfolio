--Welke team is welk seizoen kampioen geworden en met hoeveel punten?
WITH team_points AS 
(
SELECT
	season,
	team_id,
	SUM((win * 3) + (tie * 1)) AS tot_punten
FROM
	(
	SELECT
		season,
		home_team_api_id as team_id,
		SUM(CASE WHEN home_team_goal > away_team_goal THEN 1 ELSE 0 END) AS win,
		SUM(CASE WHEN home_team_goal = away_team_goal THEN 1 ELSE 0 END) AS tie
	FROM
		"Match" m
	INNER JOIN League l 
ON
		m.league_id = l.id
	WHERE
		l.id = 13274
	GROUP BY
		season,
		home_team_api_id
UNION ALL
	SELECT
		season,
		away_team_api_id as team_id,
		SUM(CASE WHEN away_team_goal > home_team_goal THEN 1 ELSE 0 END) AS win,
		SUM(CASE WHEN away_team_goal = home_team_goal THEN 1 ELSE 0 END) AS tie
	FROM
		"Match" m
	INNER JOIN League l 
ON
		m.league_id = l.id
	WHERE
		l.id = 13274
	GROUP BY
		season,
		away_team_api_id) AS win
GROUP BY
	season,
	team_id),
kampioen AS (
SELECT
	season,
	team_long_name,
	tot_punten,
	RANK() OVER(PARTITION BY season
ORDER BY
	(tot_punten) DESC) AS rnk
FROM
	team_points tp
INNER JOIN Team t
ON
	tp.team_id = t.team_api_id)
SELECT
	--Laat alleen de kampioenen zien die meer punten hebben gehaald dan gemiddeld
	season,
	team_long_name,
	tot_punten,
	(
	SELECT
		ROUND(AVG(tot_punten))
	FROM
		kampioen
	WHERE
		rnk = 1) AS avg_tot_punten
FROM
	kampioen
WHERE
	rnk = 1
	AND tot_punten > (
	SELECT
		AVG(tot_punten)
	FROM
		kampioen
	WHERE
		rnk = 1)
ORDER BY
	season,
	rnk;
