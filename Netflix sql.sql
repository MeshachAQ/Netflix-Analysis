select * from netflix_list$
-- Alright today we are exploring the netflix dataset and then we shall export the final data to either power bi or tableau for some visuals
-- To get started, we shall do some data cleaning and standardizations, check and remove duplicates. replace blanks or nulls with something, remove unwanted columns and finally answer some questions
-- so yhh lets kindly get into the project.

---first I wanna go through all columns and analyze my data so yhh
select distinct(imdb_id) from netflix_list$
select distinct(title) from netflix_list$
select distinct(popular_rank) from netflix_list$
select distinct(certificate) from netflix_list$
select distinct(startYear) from netflix_list$ ORDER BY startYear DESC
select distinct(endYear) from netflix_list$ ORDER BY endYear DESC
select distinct(episodes) from netflix_list$ 
select distinct(runtime) from netflix_list$ 
select distinct(type) from netflix_list$ 
select distinct(orign_country) from netflix_list$ 
select distinct(language) from netflix_list$ 
select distinct(plot) from netflix_list$ 
select distinct(summary) from netflix_list$ 
select distinct(rating) from netflix_list$ 
select distinct(numVotes) from netflix_list$ 
select distinct(genres) from netflix_list$ 
select distinct(isAdult) from netflix_list$ 
select distinct(cast) from netflix_list$ 
select distinct(image_url) from netflix_list$ 

--Alright so with what we have above, we are able to tell the columns with null or blank values (certificate, startYear, endYear, episodes, runtime, type
--orign_country, language, plot, summary and so we want to replace the nulls or blanks with unknown

select * from netflix_list$

UPDATE netflix_list$
SET certificate = 0
WHERE certificate is NULL

UPDATE netflix_list$
SET episodes = 0
WHERE episodes is NULL

UPDATE netflix_list$
SET runtime = 0
WHERE runtime is NULL

UPDATE netflix_list$
SET type = 'Unknown'
WHERE type is NULL



--- let's drop unused columns now
ALTER TABLE netflix_list$
DROP COLUMN plot, summary, isAdult, cast

---Alright let's check for duplicate values now
select *,  ROW_NUMBER() OVER(PARTITION BY title, orign_country, genres, imdb_id ORDER BY imdb_id) as row_num from netflix_list$

---Okay so we see that there arent any duplicate value in the dataset.

select * from netflix_list$
---Let's start answering a few questions now, we shall work on the null dates in power bi

---what are the top 10 movies per numVotes
select TOP 10 title, sum(numVotes) as BEST_10 from netflix_list$ WHERE title is not null GROUP BY title
ORDER BY sum(numVotes) DESC

---Find the top 10 movies by AVG rating
select top 10 title, AVG(rating) AS Rating from netflix_list$ WHERE TITLE IS NOT NULL
GROUP BY title
ORDER BY AVG(rating) DESC

---Rank titles by ratings
select title, rating, rank() over(ORDER BY rating DESC) AS Rank from netflix_list$

---We now want to find which countries have the highest movies
select orign_country, count(title) as Total_movies from netflix_list$ Where orign_country not like '%-%'
GROUP BY orign_country
ORDER BY Total_movies DESC

--- Let's try to find the average rating for each movie genre
select distinct(genres), AVG(rating) AS Avg_Rating from netflix_list$
GROUP BY genres
ORDER BY AVG(rating) DESC

--lets find out titles by type count
select distinct(type), count(title) as Type_counts from netflix_list$
GROUP BY type 
ORDER BY Type_counts

SELECT * FROM netflix_list$


---We can also want to find the movies by startyear 2022

select title, genres, startYear from netflix_list$ WHERE startYear = 2022 and title is not null

---can we find the total number of movies only in this dataset?
select count(type) as movie_only from netflix_list$ where type = 'movie'

--Okay we now want to find the totals by type
select type, count(type) as Totals_by_Type from netflix_list$
GROUP BY type
ORDER BY Totals_by_Type DESC

--Now what is the overall total rating across movie titles?
select AVG(rating) as AvgRating from netflix_list$

---We can also find the total votes and avg rating across genres by
select distinct(genres), sum(numVotes) as Votes_per_Genre, AVG(rating) as Avg_Rating from netflix_list$
GROUP BY genres
ORDER BY Votes_per_Genre DESC


--Alright, this was just a brief analysis using sql, we shall now export this to power bi and do the rest. kindly follow. But first, let's create a view
create view Netflix as select * from netflix_list$

select * from Netflix


select cast(startYear as date) from netflix_list$





