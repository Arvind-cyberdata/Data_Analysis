# Creating new database
create database preplacement;
use preplacement;

# Data Cleaning has been done on the CSV file
# Importing the data using Table Data Import Wizard

select * from esports;

# Objective 1: Has the Total Earnings increased through the years?
select ReleaseDate, round(sum(TotalEarnings),2) as Total from esports group by ReleaseDate order by Total desc;
# TOTAL EARNINGS HAS SPIKED IN YEARS 2013 AND 2017. 

# Objective 2: Which Genre has the highest and Lowest Total Earnings?
select Genre, round(sum(TotalEarnings),2) as TotalEarnings from esports group by Genre order by sum(TotalEarnings) desc;
# MULTIPLAYER ONLINE BATTLE ARENA AND PUZZLE GAME HAVE HAD THE HIGHEST AND LOWEST TOTAL EARNINGS RESPECTIVELY

# Objective 3: Among the top 5 Genres, which one has the highest earnings in 2022?
select Genre, round(sum(TotalEarnings),2) as Total from esports where ReleaseDate = 2022 
group by Genre order by sum(TotalEarnings) desc limit 5;
# FIRST PERSON SHOOTER GENRE HAS THE HIGHEST EARNINGS IN 2022

# Objective 4: Which game has the highest offline total earnings?
select Game, OfflineEarnings from esports where OfflineEarnings = (select max(OfflineEarnings) from esports);
# DOTA 2 IS THE GAME WITH HIGHEST OFFLINE EARNINGS

# Objective 5: Which game has the highest online earnings?
select Game, OnlineEarnings from esports where OnlineEarnings = (select max(OnlineEarnings) from esports);
# FORTNITE IS THE GAME WITH HIGHEST ONLINE EARNINGS

# Objective 6: Does the number of players have an impact on the Total Earnings?
select TotalPlayers, TotalEarnings from esports order by TotalEarnings desc;
# THE INCREASE IN THE NUMBER OF PLAYERS SLIGHTLY INCREASES THE REVENUE GENERATED

# Objective 7: How has Covid-19 pandemic affected the number of games released each year?
select ReleaseDate, count(Game) as TotalGamesReleased from esports where ReleaseDate >2018 group by ReleaseDate;
# THE NUMBER OF GAMES RELEASED EACH YEAR HAS DECLINED POST COVID

# Objective 8: Has the online earnings increased post covid?
select ReleaseDate, round(sum(OnlineEarnings),2) as OnlineEarnings from esports 
where ReleaseDate >2018 group by ReleaseDate order by OnlineEarnings;
#  THERE HAS BEEN A STEEP DROP IN ONLINE EARNINGS FROM 2020 TO 2021 AND THEN A GRADUAL DECREASE TO 2023.

# Objective 9: In the past decade, which genre has contributed to the Total Earnings the most
select Genre, round(sum(TotalEarnings),2) as TotalEarnings from esports 
where ReleaseDate > 2013 group by Genre order by TotalEarnings desc; 
# BATTLE ROYALE HAS CONTRIBUTED THE MOST TO THE TOTAL EARNINGS IN THE PAST DECADE

# Objective 10: Which genres have hosted the most tournaments in the past decade?
select Genre, sum(TotalTournaments) as TotalTournaments from esports 
where ReleaseDate >2013 group by Genre order by TotalTournaments desc; 
# FIGHTING GAMES HAVE HELD THE MOST NUMBER OF TOURNAMENTS IN THE PAST DECADE

# Objective 11: Among the top5 genre, which one has had increase in Total Earnings post covid?
select e.Genre, e.ReleaseDate, sum(e.TotalEarnings) as Total from esports e join 
(select Genre from esports group by Genre order by sum(TotalEarnings) desc limit 5) g on e.Genre = g.Genre
where e.ReleaseDate > 2018 group by e.Genre, e.ReleaseDate;
# Multiplayer Online Battle Arena has an increase in Total Earnings in 2021
# First-Person Shooter has a slight increase in 2022 after its decrease in 2021
# Battle Royale has a drastic decrease after 2019
# Strategy has gradually decreasing Total Earnings
# Sports has a slight increase in 2022 but huge decrease in 2023
# Among the genres, First-Person Shooter is consistently generating revenue throughout the pandemic

# Objective 12: In which year was the maximum number of games released?
select ReleaseDate, count(Game) as TotalGamesReleased from esports group by ReleaseDate order by TotalGamesReleased desc limit 1;
# THE MAXIMUM NUMBER OF GAMES WERE RELEASED IN 2019

# Objective 13: Games with the highest earnings in the last decade
select Game, TotalEarnings from esports where ReleaseDate > 2013 order by TotalEarnings desc;
# FORTNITE HAS THE HIGHEST EARNINGS IN THE PAST DECADE

# Objective 14: Total Earnings generated per player for the top 10 games in the last decade
select e.Game, round((e.TotalEarnings/e.TotalPlayers),2) as EarningsPerPlayer from esports e join
(select Game from esports group by Game order by sum(TotalEarnings) desc limit 10) top on e.Game = top.Game
where e.ReleaseDate > 2013 order by EarningsPerPlayer desc;
# AMONG THE TOP 10 GAMES, ARENA OF VALOR HAS THE HIGHEST EARNINGS PER PLAYER

# Objective 15: Total Offline Earnings generated per tournament for the top 10 games
select e.Game, round((e.OfflineEarnings/e.TotalTournaments),2) as OfflPerTour from esports e join
(select Game from esports group by Game order by sum(TotalEarnings) desc limit 10) top on e.Game = top.Game
where ReleaseDate >2013 order by OfflPerTour desc;
# AMONG THE TOP 10 GAMES, ARENA OF VALOR GENERATES THE HIGHEST OFFLINE EARNINGS PER TOURNAMENT