#R CODE MASTER THESIS JUISTE VERSIE 
#Set working directory and load in necessary pacakges -----
setwd("/Users/maartenjol/Documents/Erasmus/Master/MasterThesis/Data")
library(lubridate)
library(dplyr)
library(tibble)
library(stargazer)
library(psych)
library(funModeling)
library(devtools)
library(TouRnament)
install_github("jalapic/engsoccerdata")
library(engsoccerdata)
library(ggplot2)
library(ggthemes)
library(XML)
library(tidyr)
library(tidyverse)
library(mefa)
library(base)
library(lme4)
library(sjPlot)
library(ggpubr)
library(irr)
library(rstatix)
library(haven)
library(lme4)
require(reshape)
require(foreign)
library(geepack)
library(fitdistrplus)
require(lavaan)
library(GLMMadaptive)
library(performance)
install.packages("lm.beta")         
library("lm.beta") 

#Insert and read all data files with match stats ------
data22.23 <- read.csv("Eredivisie 2022-2023 tm 22 mei.csv")
data21.22 <- read.csv("Eredivisie 2021-2022.csv")
data20.21 <- read.csv("Eredivisie 2020-2021.csv")
data19.20 <- read.csv("Eredivisie 2019-2020.csv")
data18.19 <- read.csv("Eredivisie 2018-2019.csv")
data17.18 <- read.csv("Eredivisie 2017-2018.csv")

#Delete useless columns (and rows for 22-23 season) -----
data22.23 <- data22.23[-c(24:105)]
data21.22 <- data21.22[-c(24:105)]
data20.21 <- data20.21[-c(24:105)]
data19.20 <- data19.20[-c(24:105)]
data18.19 <- data18.19[-c(23:61)]
data17.18 <- data17.18[-c(23:64)]
#change date of FC Groningen - Ajax
data22.23$Date[data22.23$HomeTeam == "Groningen" & data22.23$AwayTeam == "Ajax"] <- "16/05/2023"

#Adding GAME TIMES for season 2017-2018 ----
sp1 <- c("18:00", "19:45", "17:30", "19:45", "17:30", "13:30", "15:45", "13:30", "11:30")
sp2 <- c("19:00", "18:45", "19:45", "17:30", "13:30", "11:30", "15:45", "15:45", "13:30")
sp3 <- c("19:00", "18:45", "19:45", "17:30", "18:45", "11:30", "15:45", "15:45", "13:30")
sp4 <- c("19:45", "19:45", "17:30", "17:30", "13:30", "15:45", "11:30", "13:30", "13:30")
sp5 <- c("19:00", "17:30", "18:45", "18:45", "19:45", "13:30", "15:45", "13:30", "15:45")
sp6 <- c("19:45", "18:45", "18:45", "17:30", "13:30", "15:45", "13:30", "11:30", "13:30")
sp7 <- c("19:00", "19:45", "17:30", "19:45", "17:30", "13:30", "15:45", "13:30", "11:30")
sp8 <- c("17:30", "19:45", "17:30", "19:45", "15:45", "13:30", "11:30", "13:30", "13:30")
sp9 <- c("19:00", "18:45", "17:30", "19:45", "18:45", "13:30", "13:30", "15:45", "11:30")
sp10 <- c("19:00", "17:30", "17:30", "19:45", "19:45", "15:45", "13:30", "13:30", "11:30")
sp11 <- c("19:00", "17:30", "18:45", "18:45", "19:45", "13:30", "11:30", "15:45", "13:30")
sp12 <- c("17:30", "19:45", "17:30", "19:45", "11:30", "13:30", "15:45", "13:30", "13:30")
sp13 <- c("19:00", "18:45", "19:45", "18:45", "17:30", "11:30", "13:30", "13:30", "15:45")
sp14 <- c("19:00", "17:30", "19:45", "17:30", "19:45", "15:45", "13:30", "13:30", "11:30")
sp15 <- c("19:00", "18:45", "18:45", "17:30", "19:45", "16:00", "11:30")
sp16 <- c("17:30", "19:45", "19:45", "19:45", "17:30", "17:30", "18:45", "19:45", "17:30")
sp17 <- c("17:30", "18:45", "19:45", "19:45", "17:30", "13:30", "15:45", "11:30", "13:30")
sp18 <- c("19:00", "18:45", "19:45", "17:30", "18:45", "13:30", "15:45", "11:30", "13:30")
sp19 <- c("19:00", "19:00", "18:45", "17:30", "19:45", "18:45", "13:30", "15:45", "13:30", "13:30")
sp20 <- c("19:00", "19:00", "17:30", "19:45", "18:45", "18:45", "13:30", "13:30", "11:30", "15:45")
sp21 <- c("19:00", "17:30", "19:45", "18:45", "15:45", "13:30", "11:30", "13:30", "13:30")
sp22 <- c("19:45", "19:45", "17:30", "19:45", "17:30", "17:30", "19:45", "17:30", "19:45")
sp23 <- c("19:45", "19:45", "17:30", "18:45", "17:30", "11:30", "13:30", "15:45", "13:30")
sp24 <- c("19:00", "19:45", "18:45", "18:45", "17:30", "13:30", "11:30", "13:30", "15:45")
sp25 <- c("19:00", "17:30", "18:45", "18:45", "19:45", "11:30", "13:30", "15:45", "13:30")
sp26 <- c("19:00", "17:30", "19:45", "19:45", "17:30", "13:30", "15:45", "13:30", "11:30")
sp27 <- c("19:00", "17:30", "19:45", "18:45", "18:45", "13:30", "15:45", "11:30", "13:30")
sp28 <- c("19:00", "19:45", "18:45", "17:30", "18:45", "11:30", "13:30", "13:30", "15:45")
sp29 <- c("19:45", "18:45", "17:30", "19:45", "17:30", "15:45", "13:30", "13:30", "11:30")
sp30 <- c("19:00", "18:45", "17:30", "18:45", "19:45", "15:45", "13:30", "13:30", "11:30")
sp31 <- c("19:00", "17:30", "18:45", "18:45", "19:45", "13:30", "13:30", "11:30", "15:45")
sp32 <- c("19:45", "17:30", "17:30", "18:45", "17:30", "19:45", "19:45", "19:45", "17:30")
sp33 <- c("13:30", "13:30", "13:30", "13:30", "13:30", "13:30", "13:30", "13:30", "13:30")
sp34 <- c("13:30", "13:30", "13:30", "13:30", "13:30", "13:30", "13:30", "13:30", "13:30")

Time <- c(sp1, sp2, sp3, sp4, sp5, sp6, sp7, sp8, sp9, sp10, sp11, sp12, sp13, sp14, sp15, sp16, sp17,
          sp18, sp19, sp20, sp21, sp22, sp23, sp24, sp25, sp26, sp27, sp28, sp29, sp30, sp31, sp32, sp33, sp34)

data17.18$Time <- Time

#Adding GAME TIMES for season 2018-2019 -----
sp1.1 <- c("19:00", "17:30", "19:45", "19:45", "17:30", "15:45", "11:15", "13:30", "13:30")
sp2.1 <- c("19:00", "19:45", "17:30", "19:45", "17:30", "13:30", "13:30", "15:45", "11:15")
sp3.1 <- c("19:00", "17:30", "17:30", "19:45", "19:45", "15:45", "13:30", "13:30", "11:15")
sp4.1 <- c("19:00", "18:45", "19:45", "18:45", "17:30", "15:45", "11:15", "13:30", "13:30")
sp5.1 <- c("19:45", "17:30", "17:30", "19:45", "11:15", "13:30", "13:30", "13:30", "15:45")
sp6.1 <- c("19:00", "18:45", "17:30", "19:45", "18:45", "13:30", "11:15", "13:30", "15:45")
sp7.1 <- c("19:45", "19:45", "17:30", "17:30", "13:30", "15:45", "13:30", "13:30", "11:15")
sp8.1 <- c("19:00", "17:30", "19:45", "18:45", "18:45", "15:45", "11:15", "13:30", "13:30")
sp9.1 <- c("17:30", "19:45", "17:30", "19:45", "13:30", "15:45", "13:30", "11:15", "13:30")
sp10.1 <- c("19:00", "17:30", "18:45", "18:45", "19:45", "13:30", "15:45", "11:15", "13:30")
sp11.1 <- c("19:00", "19:45", "19:45", "17:30", "17:30", "13:30", "11:15", "13:30")
sp12.1 <- c("19:00", "17:30", "18:45", "18:45", "19:45", "13:30", "13:30", "11:15", "15:45")
sp13.1 <- c("19:45", "17:30", "19:45", "17:30", "11:15", "13:30", "13:30", "15:45", "13:30")
sp14.1 <- c("19:00", "18:45", "18:45", "19:45", "17:30", "11:15", "13:30", "15:45", "13:30")
sp15.1 <- c("19:00", "17:30", "19:45", "19:45", "17:30", "18:45", "13:30", "15:45", "11:15", "13:30")
sp16.1 <- c("19:00", "18:45", "18:45", "19:45", "17:30", "13:30", "15:45", "13:30", "11:15")
sp17.1 <- c("19:00", "19:45", "17:30", "19:45", "18:45", "13:30", "15:45", "13:30", "11:15")
sp18.1 <- c("19:00", "17:30", "18:45", "19:45", "18:45", "15:45", "13:30", "13:30", "11:15")
sp19.1 <- c("19:00", "18:45", "17:30", "18:45", "19:45", "13:30", "11:15", "15:45", "13:30")
sp20.1 <- c("19:00", "18:45", "19:45", "17:30", "18:45", "15:45", "11:15", "13:30", "13:30")
sp21.1 <- c("19:00", "19:45", "17:30", "17:30", "19:45", "13:30", "11:15", "13:30", "15:45")
sp22.1 <- c("19:00", "17:30", "18:45", "18:45", "19:45", "11:15", "13:30", "15:45", "13:30")
sp23.1 <- c("19:00", "18:45", "19:45", "17:30", "18:45", "11:15", "13:30", "13:30", "15:45")
sp24.1 <- c("19:00", "18:45", "17:30", "19:45", "15:45", "15:45", "13:30", "13:30")
sp25.1 <- c("19:00", "18:45", "18:45", "17:30", "19:45", "15:45", "13:30", "13:30", "11:15", "17:30")
sp26.1 <- c("19:00", "18:45", "17:30", "19:45", "18:45", "13:30", "15:45", "13:30", "11:15")
sp27.1 <- c("19:45", "17:30", "18:45", "19:45", "17:30", "15:45", "11:15", "13:30", "13:30")
sp28.1 <- c("19:45", "18:45", "17:30", "18:45", "19:45", "18:45", "17:30", "19:45", "17:30")
sp29.1 <- c("17:30", "19:45", "18:45", "19:45", "17:30", "11:15", "15:45", "13:30", "13:30")
sp30.1 <- c("19:00", "17:30", "17:30", "19:45", "19:45", "13:30", "11:15", "15:45", "13:30")
sp31.1 <- c("19:00", "17:30", "19:45", "17:30", "18:45", "19:45", "11:15", "13:30", "15:45")
sp32.1 <- c("19:45", "18:45", "17:30", "18:45", "19:45", "18:45", "17:30", "19:45", "19:00")
sp33.1 <- c("18:30", "18:30", "18:30", "18:30", "18:30", "18:30", "18:30", "18:30", "18:30")
sp34.1 <- c("13:30", "13:30", "13:30", "13:30", "13:30", "13:30", "13:30", "13:30", "13:30")

Time2 <- c(sp1.1, sp2.1, sp3.1, sp4.1, sp5.1, sp6.1, sp7.1, sp8.1, sp9.1, sp10.1, sp11.1, sp12.1, sp13.1,
           sp14.1, sp15.1, sp16.1, sp17.1, sp18.1, sp19.1, sp20.1, sp21.1, sp22.1, sp23.1, sp24.1, sp25.1,
           sp26.1, sp27.1, sp28.1, sp29.1, sp30.1, sp31.1, sp32.1, sp33.1, sp34.1)

data18.19$Time2 <- Time2
colnames(data18.19)[23] <- "Time"

#Adding attendance per matchday, grass & promoted dummy for season 2017-2018 and changing date type ----
s1718.1 <- c(12134, 12080, 32700, 13921, 5832, 47500, 19255, 12800, 13000)
s1718.2 <- c(12004, 12749, 18300, 23800, 51152, 4400, 18788, 10012, 16093)
s1718.3 <- c(17912, 7902, 10067, 15131, 12800, 47500, 16032, 32200, 8000)
s1718.4 <- c(50902, 4100, 11331, 11123, 12511, 15832, 22345, 10034, 19042)
s1718.5 <- c(10210, 4034, 18563, 11668, 12500, 12016, 35000, 24200, 15213)
s1718.6 <- c(9641, 47500, 9943, 10740, 51236, 12527, 20110, 22006, 6621)
s1718.7 <- c(27100, 3704, 18523, 31565, 13160, 14644, 25600, 9834, 15432 )
s1718.8 <- c(51567, 47500, 12230, 17771, 10805, 17680, 11164, 8000, 12019)
s1718.9 <- c(16394, 4400, 18423, 23600, 6532, 14056, 47500, 21034, 32800)
s1718.10 <- c(23200, 10364, 13491, 13907, 13030, 19136, 10010, 20123, 18232)
s1718.11 <- c(10231, 14613, 4086, 10411, 6521, 51758, 13870, 33040, 18349)
s1718.12 <- c(47500, 18969, 25600, 11511, 11175, 17263, 12411, 18336, 13250)
s1718.13 <- c(14601, 20294, 20832, 10626, 6782, 51685, 4400, 10432, 14754)
s1718.14 <- c(13250, 10416, 47500, 27500, 11230, 18340, 33000, 10482, 6353)
s1718.15 <- c(14400, 13863, 4069, 18893, 23600, 52379, 10515)
s1718.16 <- c(17589, 12875, 9151, 40000, 20103, 13961, 5778, 51695, 9203)
s1718.17 <- c(19361, 32700, 13189, 23600, 12900, 16900, 3808, 10606, 16859)
s1718.18 <- c(11107, 15012, 4369, 18769, 33800, 51921, 40000, 17617, 7528, 9258)
s1718.19 <- c(18457, 11008, 12475, 15363, 13120, 53320, 11211, 10224, 12160, 22111)
s1718.20 <- c(18790, 17526, 18443, 25700, 13115, 47500, 11226, 21768, 11350)
s1718.21 <- c(14675, 22290, 10127, 32800, 51886, 15007, 3997, 10433, 8000)
s1718.22  <- c(12920, 17035, 32100, 14484, 23400, 15929, 11500, 12303, 37500)
s1718.23  <- c(14023, 17780, 10232, 10591, 17301, 52443, 3876, 16723, 16459)
s1718.24  <- c(6624, 9966, 18628, 33500, 15432, 47500, 11361, 25400, 13250)
s1718.25  <- c(21875, 14884, 18920, 9031, 6168, 52822, 47500, 17755, 13277)
s1718.26  <- c(12946, 4218, 17300, 18963, 33800, 10482, 23900, 19876, 12985)
s1718.27  <- c(12080, 13620, 12644, 6021, 13660, 52523, 45000, 17896, 19607)
s1718.28  <- c(4400, 18700, 33900, 29300, 16231, 16459, 18412, 10606, 13250)
s1718.29  <- c(13115, 34300, 16591, 13660, 13250, 45000, 22568, 10086, 6623)
s1718.30  <- c(4400, 17002, 18567, 14115, 10139, 52495, 23150, 25600, 20145)
s1718.31  <- c(10724, 13876, 16345, 7054, 13028, 47500, 20402, 18481, 35000)
s1718.32  <- c(18730, 24900, 16067, 4065, 15383, 10606, 13320, 52145, 19540)
s1718.33  <- c(52687, 14031, 45000, 18847, 11187, 18456, 17939, 7255, 13055)
s1718.34  <- c(16532, 4400, 24640, 33700, 13794, 8846, 25600, 19669, 11600)

Attendance <- c(s1718.1, s1718.2, s1718.3, s1718.4, s1718.5, s1718.6, s1718.7, s1718.8, s1718.9, s1718.10,
                s1718.11, s1718.12, s1718.13, s1718.14, s1718.15, s1718.16, s1718.17, s1718.18, s1718.19, s1718.20, 
                s1718.21, s1718.22, s1718.23, s1718.24, s1718.25, s1718.26, s1718.27, s1718.28, s1718.29, s1718.30, 
                s1718.31, s1718.32, s1718.33, s1718.34)
data17.18$Attendance <- Attendance
#Changing date type format for season 2017-2018
data17.18$Date <- as.Date(data17.18$Date, format = "%d/%m/%y")
#adding dummy for promoted teams
data17.18$PromotedH <- ifelse(data17.18$HomeTeam == "VVV Venlo" | data17.18$HomeTeam == "NAC Breda", "1", "0")
data17.18$PromotedA <- ifelse(data17.18$AwayTeam == "VVV Venlo" | data17.18$AwayTeam == "NAC Breda", "1", "0")
#adding dummy for type of grass
data17.18$ArtGrass <- ifelse(data17.18$HomeTeam == "Den Haag" | data17.18$HomeTeam == "Excelsior" | data17.18$HomeTeam == "Heracles" 
                             | data17.18$HomeTeam == "Roda" | data17.18$HomeTeam == "Zwolle" | data17.18$HomeTeam == "Sparta Rotterdam"
                             | data17.18$HomeTeam == "VVV Venlo", "1", "0")

#Adding attendance per matchday, grass & promoted dummy for season 2018-2019 ----
s1819.1 <- c(14000, 51949, 4250, 33100, 11800, 14299, 11324, 12600, 13434)
s1819.2 <- c(16500, 10414, 18710, 11135, 8000, 8085, 45000, 16080, 18036)
s1819.3 <- c(11600, 52885, 12143, 18227, 13255, 14702, 21700, 15226, 11677)
s1819.4 <- c(8218, 3940, 7643, 33300, 6235, 45000, 16014, 10462, 19231)
s1819.5 <- c(52720, 14519, 11702, 11894, 14362, 15500, 18712, 16720, 13325)
s1819.6 <- c(10829, 4008, 8537, 14023, 6167, 8401, 45000, 15091, 35000)
s1819.7 <- c(4106, 12004, 16550, 18926, 15354, 45000, 12005, 16293, 10217)
s1819.8 <- c(17386, 11584, 12102, 33800, 13562, 53185, 8300, 14338, 13550)
s1819.9 <- c(4397, 23315, 34200, 18294, 45600, 8527, 11237, 18892, 7051)
s1819.10 <- c(8300, 12199, 12108, 18445, 13523, 53720, 16535, 15879, 12742)
s1819.11 <- c(4257, 53432, 15428, 18385, 34100, 8332, 19835, 15946)
s1819.12 <- c(13222, 8300, 12313, 15131, 7534, 12717, 4400, 20731, 11754)
s1819.13 <- c(7545, 18969, 34100, 12152, 8021, 45000, 18802, 6217, 11879)
s1819.14 <- c(4400, 15787, 12008, 15626, 15821, 53644, 47500, 18377, 10223, 40000)
s1819.15 <- c(7133, 33100, 11105, 12595, 14000, 8301, 18280, 21812, 6668)
s1819.16 <- c(12163, 14427, 12080, 13249, 13242, 53388, 42500, 21965, 17575)
s1819.17 <- c(7235, 4032, 8283, 18352, 34300, 13851, 8301, 12600, 23226)
s1819.18 <- c(13231, 16104, 10181, 16143, 13850, 52553, 8301, 12304, 14400)
s1819.19 <- c(18547, 4400, 10667, 33900, 6145, 47500, 8123, 17182, 17256)
s1819.20 <- c(12502, 52868, 14328, 15342, 12633, 11464, 4400, 34400, 13024)
s1819.21 <- c(18205, 40000, 19822, 12080, 6134, 8301, 8479, 16498, 19005)
s1819.22 <- c(12253, 14675, 23522, 10568, 14186, 52952, 4200, 12464, 20259)
s1819.23 <- c(6534, 8523, 18572, 18676, 13823, 14352, 8301, 34600, 12423)
s1819.24 <- c(12498, 4400, 11200, 12757, 13823, 35000, 16757, 17882)
s1819.25 <- c(18146, 13118, 34300, 6382, 12796, 53381, 8185, 17208, 13954, 52385)
s1819.26 <- c(10232, 37000, 19020, 11086, 18613, 17026, 4093, 17291, 8000)
s1819.27 <- c(15404, 13721, 12502, 18021, 14270, 52669, 17946, 21758, 13721)
s1819.28 <- c(18008, 10442, 14162, 4400, 8301, 8125, 6723, 25000, 34000)
s1819.29 <- c(13022, 12503, 17456, 10530, 14700, 8268, 21248, 8000, 13334)
s1819.30 <- c(18422, 52664, 15034, 35000, 9511, 21056, 34500, 22064, 12947)
s1819.31 <- c(11586, 8269, 45000, 22288, 15387, 6545, 4140, 10266, 34300)
s1819.32 <- c(52869, 13531, 12511, 17450, 18473, 19295, 13392, 14700, 13942)
s1819.33 <- c(53520, 16555, 45000, 19738, 18500, 11485, 16250, 13800, 13189)
s1819.34 <- c(13128, 3811, 8301, 12300, 12600, 14216, 34200, 18646, 6512)

Attendance1819 <- c(s1819.1, s1819.2, s1819.3, s1819.4, s1819.5, s1819.6, s1819.7, s1819.8, s1819.9, s1819.10,
                    s1819.11, s1819.12, s1819.13, s1819.14, s1819.15, s1819.16, s1819.17, s1819.18, s1819.19, s1819.20,
                    s1819.21, s1819.22, s1819.23, s1819.24, s1819.25, s1819.26, s1819.27, s1819.28, s1819.29, s1819.30,
                    s1819.31, s1819.32, s1819.33, s1819.34)
data18.19$Attendance1819 <- Attendance1819
colnames(data18.19)[24] <- "Attendance"
#Changing date type format for season 2018-19
data18.19$Date <- as.Date(data18.19$Date, format = "%d/%m/%Y")
#adding dummy for promoted teams
data18.19$PromotedH <- ifelse(data18.19$HomeTeam == "For Sittard" | data18.19$HomeTeam == "FC Emmen" | data18.19$HomeTeam == "Graafschap", "1", "0")
data18.19$PromotedA <- ifelse(data18.19$AwayTeam == "For Sittard" | data18.19$AwayTeam == "FC Emmen" | data18.19$AwayTeam == "Graafschap", "1", "0")
#adding dummy for type of grass
data18.19$ArtGrass <- ifelse(data18.19$HomeTeam == "Den Haag" | data18.19$HomeTeam == "Excelsior" | data18.19$HomeTeam == "FC Emmen" 
                             | data18.19$HomeTeam == "Heracles" | data18.19$HomeTeam == "Zwolle" | data18.19$HomeTeam == "VVV Venlo", "1", "0")

#Adding attendance per matchday, grass & promoted dummy for season 2019-2020 ----
s1920.1 <- c(13824, 8245, 18100, 27200, 5560, 9640, 45585, 10633, 12858)
s1920.2 <- c(10012, 19049, 53124, 12825, 5866, 18600, 6023, 18736, 32000)
s1920.3 <- c(12273, 12479, 8000, 8145, 7273, 25700, 8563, 44352, 10063)
s1920.4 <- c(13300, 9344, 16328, 5034, 17986, 12532)
s1920.5 <- c(8293, 15128, 15934, 10617, 25500, 10599, 13290, 13875, 7035)
s1920.6 <- c(52921, 8327, 6265, 33300, 17661, 13028, 45496, 11254, 7377)
s1920.7 <- c(29300, 10231, 16471, 13227, 20800, 16593, 8309, 12091, 35000, 32800, 53121, 42866)
s1920.8 <- c(8002, 5944, 53228, 7483, 4858, 19419, 13482, 7241, 42866)
s1920.9 <- c(16029, 10376, 10435, 12704, 16632, 14733, 8511, 33000, 12707)
s1920.10 <- c(7648, 7508, 27500, 22632, 5992, 12943, 8130, 17582, 44303)
s1920.11 <- c(27400, 13877, 8388, 12663, 10157, 22428, 34000, 10322, 53968)
s1920.12 <- c(14000, 4689, 10387, 7597, 8048, 16590, 18776, 6572, 12681)
s1920.13 <- c(12590, 18089, 8223, 9400, 53381, 26900, 14400, 47431, 5565)
s1920.14 <- c(22401, 53226, 13912, 10889, 21096, 33800, 6645, 10020, 6730)
s1920.15 <- c(17883, 14250, 7632, 10150, 30000, 18103, 6007, 44513, 8309)
s1920.16 <- c(54022, 11439, 33300, 6580, 13708, 16455, 18741, 5174, 9934)
s1920.17 <- c(18121, 11049, 8391, 6861, 26500, 8145, 47625, 17002, 10200)
s1920.18 <- c(5154, 20424, 33000, 10031, 13587, 53976, 20136, 21103, 13454)
s1920.19 <- c(13102, 8238, 46000, 26500, 15442, 7059, 53426, 8176, 12433)
s1920.20 <- c(17319, 19638, 10686, 6103, 9821, 13265, 22315, 13337, 33600)
s1920.21 <- c(14712, 12387, 47084, 26300, 12844, 13417, 8371, 6265, 53055)
s1920.22 <- c(10235, 17884, 16400, 34700, 5257, 8309, 8083)
s1920.23 <- c(6594, 27300, 13370, 7856, 14113, 53291, 10143, 14107, 13822)
s1920.24 <- c(5343, 8190, 46016, 16640, 16374, 18491, 15306, 15509, 12080)
s1920.25 <- c(13607, 11207, 7115, 13088, 27000, 5134, 35000, 10060, 52707)
s1920.26 <- c(10071, 16117, 8100, 14210, 25950, 20624, 47500, 10412, 19116)

Attendance1920 <- c(s1920.1 , s1920.2 , s1920.3 , s1920.4 , s1920.5 , s1920.6 , s1920.7 , s1920.8 , s1920.9 , s1920.10,
                    s1920.11 , s1920.12 , s1920.13 , s1920.14 , s1920.15 , s1920.16 , s1920.17 , s1920.18 , s1920.19 , s1920.20 ,
                    s1920.21 , s1920.22 , s1920.23 , s1920.24 , s1920.25 , s1920.26)
data19.20$Attendance1920 <- Attendance1920
colnames(data19.20)[24] <- "Attendance"
#Changing date type format for season 2019-2020
data19.20$Date <- as.Date(data19.20$Date, format = "%d/%m/%Y")
#adding dummy for promoted teams
data19.20$PromotedH <- ifelse(data19.20$HomeTeam == "Twente" | data19.20$HomeTeam == "Waalwijk" | data19.20$HomeTeam == "Sparta Rotterdam", "1", "0")
data19.20$PromotedA <- ifelse(data19.20$AwayTeam == "Twente" | data19.20$AwayTeam == "Waalwijk" | data19.20$AwayTeam == "Sparta Rotterdam", "1", "0")
#adding dummy for type of grass
data19.20$ArtGrass <- ifelse(data19.20$HomeTeam == "Den Haag" | data19.20$HomeTeam == "FC Emmen" | data19.20$HomeTeam == "Sparta Rotterdam"
                             | data19.20$HomeTeam == "Heracles" | data19.20$HomeTeam == "Zwolle" | data19.20$HomeTeam == "VVV Venlo", "1", "0")

#Adding attendance per matchday, grass & promoted dummy for season 2020-2021 ----- 
s2021.1 <- c(4000, 2993, 8000, 2400, 2700, 3934, 6049, 1967)
s2021.2 <- c(1435, 3500, 4914, 8000, 2825, 3378, 13000, 3910, 11948)
s2021.3 <- c(8000, 2933, 3000, 6500, 12176, 13000, 4944, 2312, 3083)
s2021.4tm29  <- replicate(235, 0)
s2021.30 <- c(1942, 2000, 4000, 2000, 987, 7500, 939, 6500, 4000)
s2021.31tm34 <- replicate(36, 0)

Attendance2021 <- c(s2021.1, s2021.2, s2021.3, s2021.4tm29, s2021.30, s2021.31tm34)
data20.21$Attendance2021 <- Attendance2021
colnames(data20.21)[24] <- "Attendance"
#Changing date type format for season 2020-2021
data20.21$Date <- as.Date(data20.21$Date, format = "%d/%m/%Y")
#adding dummy for promoted teams
data20.21$PromotedH <- replicate(306, 0)
data20.21$PromotedA <- replicate(306, 0)
#adding dummy for type of grass
data20.21$ArtGrass <- ifelse(data20.21$HomeTeam == "FC Emmen" | data20.21$HomeTeam == "Heracles" | 
                               data20.21$HomeTeam == "Sparta Rotterdam", "1", "0")

#Adding attendance per matchday, grass & promoted dummy for season 2021-2022 ----
s2122.1 <- c(6650, 3860, 8053, 6300, 32275, 7000, 16000, 9000, 9388)
s2122.2 <- c(8333, 13600, 23500, 6725, 14800, 20000, 34384, 11329)
s2122.3 <- c(6470, 6672, 6650, 23447, 9352, 16000, 36816, 8053, 16000)
s2122.4 <- c(20000, 6682, 9000, 13000, 8333, 15000, 6623, 4989)
s2122.5 <- c(7041, 16400, 9463, 36711, 16000, 6650, 24356, 8053, 13808)
s2122.6 <- c(8333, 5975, 6650, 8333, 14963, 32775, 9000, 6676, 20000)
s2122.7 <- c(14397, 53148, 11631, 45495, 19451, 8645, 13612, 18500, 10035)
s2122.8 <- c(16250, 6018, 9251, 13655, 7011, 52621, 10000, 14238, 30500)
s2122.9 <- c(47183, 9701, 25133, 6873, 30500, 17037, 12500, 9038, 27000)
s2122.10 <- c(14057, 21875, 13026, 5304, 26000, 10000, 12783, 53585, 11300)
s2122.11 <- c(32500, 12080, 17187, 15328, 10599, 0, 20469, 4754, 8807)
s2122.12 <- c(30000, 0, 13028, 13098, 20313, 9527, 47500, 15867, 53497)
s2122.13tm20 <- replicate(74, 0)
s2122.21 <- c(8000, 4200, 12000, 4500, 0, 17039, 6900, 4686, 15750)
s2122.22 <- c(4058, 3300, 7200, 9177, 3746, 3500, 8321, 2126, 17859)
s2122.23 <- c(11802, 14412, 13616, 13620, 44779, 26100, 28000, 16886)
s2122.24 <- c(5364, 6788, 17977, 9780, 16241, 13877, 10020, 9859, 19200)
s2122.25 <- c(13082, 9924, 45395, 33247, 26800, 53467, 12000, 8279)
s2122.26 <- c(9822, 10011, 20600, 4203, 8512, 7035, 22269, 14000, 15349)
s2122.27 <- c(17980, 9631, 28000, 12000, 21221, 54709, 33491, 13625, 13064)
s2122.28 <- c(22525, 30000, 17406, 6389, 47500, 14000, 10067, 10210, 10000)
s2122.29 <- c(9821, 21216, 54254, 12390, 22500, 33000, 14970, 7461, 12876)
s2122.30 <- c(10032, 9771, 29100, 12390, 17198, 5236, 10000, 13478, 47500, 20471, 9512)
s2122.31 <- c(20665, 54120, 7845, 10010, 25100, 9814, 33100, 10512, 6348)
s2122.32 <- c(10000, 29500, 14408, 14000, 20400, 12390, 18033, 14710, 47500)
s2122.33 <- c(54335, 10000, 10883, 9802, 34274, 10606, 29100, 20085, 6126)
s2122.34 <- c(17568, 47500, 21286, 23200, 7954, 12390, 18920, 14000, 14000)

Attendance2122 <- c(s2122.1, s2122.2, s2122.3, s2122.4, s2122.5, s2122.6, s2122.7, s2122.8, s2122.9, s2122.10, 
                    s2122.11, s2122.12, s2122.13tm20, s2122.21, s2122.22, s2122.23, s2122.24, s2122.25, s2122.26,
                    s2122.27, s2122.28, s2122.29, s2122.30, s2122.31, s2122.32, s2122.33, s2122.34)
data21.22$Attendance2122 <- Attendance2122
colnames(data21.22)[24] <- "Attendance"
#Changing date type format for season 2021-2022
data21.22$Date <- as.Date(data21.22$Date, format = "%d/%m/%Y")
#adding dummy for promoted teams
data21.22$PromotedH <- ifelse(data21.22$HomeTeam == "Go Ahead Eagles" | data21.22$HomeTeam == "Nijmegen" | data21.22$HomeTeam == "Cambuur", "1", "0")
data21.22$PromotedA <- ifelse(data21.22$AwayTeam == "Go Ahead Eagles" | data21.22$AwayTeam == "Nijmegen" | data21.22$AwayTeam == "Cambuur", "1", "0")
#adding dummy for type of grass
data21.22$ArtGrass <- ifelse(data21.22$HomeTeam == "Cambuur" | data21.22$HomeTeam == "Heracles" | 
                               data21.22$HomeTeam == "Sparta Rotterdam", "1", "0")

#Adding attendance per matchday, grass & promoted dummy for season 2022-2023 and adding ALL datasets ---- 
s2223.1 <- c(18000, 11863, 9671, 30000, 4526, 18648, 12256, 14416, 14438)
s2223.2 <- c(4234, 9643, 7829, 21019, 47500, 6375, 54060, 27000, 9631)
s2223.3 <- c(10899, 8357, 8024, 18575, 10606, 6578)
s2223.4 <- c(12500, 9317, 10598, 47500, 18020, 21471, 4400, 6750, 10000, 28114, 27000, 14945)
s2223.5 <- c(8763, 53667, 30000, 10050, 9711, 4332, 8062, 18066, 18014)
s2223.6 <- c(6450, 12500, 49555, 4034, 15807, 10000, 28432, 16269, 47500)
s2223.7 <- c(17547, 9657, 15702, 4555, 8379, 9623, 21039, 33110, 18772)
s2223.8 <- c(10000, 14847, 53848, 29500, 10078, 4142, 12500, 5647, 8131)
s2223.9 <- c(18835, 6850, 10087, 12100, 9603, 47500, 20873, 24087, 12327)
s2223.10 <- c(8123, 11043, 9713, 9886, 10420, 30646, 29000, 17039, 53941)
s2223.11 <- c(47500, 7508, 12117, 4400, 10000, 21333, 12500, 20048, 6600)
s2223.12 <- c(22150, 10221, 9238, 8225, 31007, 29100, 18255)
s2223.13 <- c(10000, 16493, 10088, 4400, 19904, 30000, 6700, 54969, 5067, 50202, 47500)
s2223.14 <- c(10606, 6650, 8309, 33009, 12500, 21023, 23800, 47500, 9784)
s2223.15 <- c(29500, 6143, 17277, 10077, 33421, 20857, 9828, 12500, 4400)
s2223.16 <- c(20019, 6604, 53649, 10555, 16086, 11534, 9793, 8135, 20589)
s2223.17 <- c(4400, 12200, 9841, 31333, 19029, 47500, 28500, 16652)
s2223.18 <- c(8061, 9720, 9457, 14699, 7689, 47500, 17058, 18918, 54279)
s2223.19 <- c(30133, 5652, 20152, 12500, 16765, 30000, 4400, 6600, 9755, 5481)
s2223.20 <- c(10278, 6850, 8183, 19444, 4400, 10000, 47500, 9733, 20355)
s2223.21 <- c(16187, 12324, 32198, 8061, 10130, 18400, 13211, 53809, 29500)
s2223.22 <- c(5692, 6650, 21674, 47500, 10000, 9848, 22043, 54410, 4400)
s2223.23 <- c(10321, 20140, 20109, 16869, 12500, 12139, 8190, 20453, 32323)
s2223.24 <- c(18634, 16367, 6635, 47500, 29500, 4400, 7419, 53094, 9600)
s2223.25 <- c(8126, 11445, 16526, 10531, 12500, 25500, 30167, 47500)
s2223.26 <- c(6578, 20006, 8274, 6418, 21247, 54917, 4100, 17416, 29500)
s2223.27 <- c(18393, 4400, 9600, 12500, 6147, 9911, 10606, 22050, 10759)
s2223.28 <- c(21659, 19134, 18002, 36003, 22100, 29000, 8237, 54231, 47500)
s2223.29 <- c(4400, 6738, 10420, 12500, 18324, 6678, 9600, 53801, 9825, 9723)
s2223.30 <- c(6760, 23020, 15007, 29500, 9827, 35500, 47500, 16787, 0)
s2223.31 <- c(6924, 10599, 9600, 12500, 53841, 8309, 4400, 9711, 10467)
s2223.32 <- c(30000, 6807, 18912, 18926, 16082, 47500, 16481, 33400, 0)
s2223.33 <- c(54627, 4400, 8309, 9911, 12000, 33900, 9731, 16182, 6833)

Attendance2223 <- c(s2223.1, s2223.2, s2223.3, s2223.4, s2223.5, s2223.6, s2223.7, s2223.8, s2223.9, 
                    s2223.10, s2223.11, s2223.12, s2223.13, s2223.14, s2223.15, s2223.16, s2223.17, s2223.18,
                    s2223.19, s2223.20, s2223.21, s2223.22, s2223.23, s2223.24, s2223.25, s2223.26, s2223.27,
                    s2223.28, s2223.29, s2223.30, s2223.31, s2223.32, s2223.33)

data22.23$Attendance22.23 <- Attendance2223
colnames(data22.23)[24] <- "Attendance"
#Changing date type format for season 2022-2023
data22.23$Date <- as.Date(data22.23$Date, format = "%d/%m/%Y")
#adding dummy for promoted teams
data22.23$PromotedH <- ifelse(data22.23$HomeTeam == "Volendam" | data22.23$HomeTeam == "Excelsior" | data22.23$HomeTeam == "FC Emmen", "1", "0")
data22.23$PromotedA <- ifelse(data22.23$AwayTeam == "Volendam" | data22.23$AwayTeam == "Excelsior" | data22.23$AwayTeam == "FC Emmen", "1", "0")
#adding dummy for type of grass
data22.23$ArtGrass <- ifelse(data22.23$HomeTeam == "Cambuur" | data22.23$HomeTeam == "FC Emmen" 
                             | data22.23$HomeTeam == "Excelsior" | data22.23$HomeTeam == "Volendam", "1", "0")
#add all the data sets together
tijdelijk <- rbind(data22.23, data21.22, data20.21, data19.20, data18.19, data17.18)

#Data Transformations on tijdelijke data set -----
#remove column DIV
tijdelijk <- subset(tijdelijk, select = -Div)

#standardize and change club names 
tijdelijk$HomeTeam[tijdelijk$HomeTeam == "AZ Alkmaar"] <- "AZ"
tijdelijk$AwayTeam[tijdelijk$AwayTeam == "AZ Alkmaar"] <- "AZ"
tijdelijk$HomeTeam[tijdelijk$HomeTeam == "Cambuur"] <- "SC Cambuur"
tijdelijk$AwayTeam[tijdelijk$AwayTeam == "Cambuur"] <- "SC Cambuur"
tijdelijk$HomeTeam[tijdelijk$HomeTeam == "Den Haag"] <- "ADO Den Haag"
tijdelijk$AwayTeam[tijdelijk$AwayTeam == "Den Haag"] <- "ADO Den Haag"
tijdelijk$HomeTeam[tijdelijk$HomeTeam == "For Sittard"] <- "Fortuna Sittard"
tijdelijk$AwayTeam[tijdelijk$AwayTeam == "For Sittard"] <- "Fortuna Sittard"
tijdelijk$HomeTeam[tijdelijk$HomeTeam == "Graafschap"] <- "De Graafschap"
tijdelijk$AwayTeam[tijdelijk$AwayTeam == "Graafschap"] <- "De Graafschap"
tijdelijk$HomeTeam[tijdelijk$HomeTeam == "Groningen"] <- "FC Groningen"
tijdelijk$AwayTeam[tijdelijk$AwayTeam == "Groningen"] <- "FC Groningen"
tijdelijk$HomeTeam[tijdelijk$HomeTeam == "Heerenveen"] <- "sc Heerenveen"
tijdelijk$AwayTeam[tijdelijk$AwayTeam == "Heerenveen"] <- "sc Heerenveen"
tijdelijk$HomeTeam[tijdelijk$HomeTeam == "Heracles"] <- "Heracles Almelo"
tijdelijk$AwayTeam[tijdelijk$AwayTeam == "Heracles"] <- "Heracles Almelo"
tijdelijk$HomeTeam[tijdelijk$HomeTeam == "Nijmegen"] <- "N.E.C."
tijdelijk$AwayTeam[tijdelijk$AwayTeam == "Nijmegen"] <- "N.E.C."
tijdelijk$HomeTeam[tijdelijk$HomeTeam == "PSV Eindhoven"] <- "PSV"
tijdelijk$AwayTeam[tijdelijk$AwayTeam == "PSV Eindhoven"] <- "PSV"
tijdelijk$HomeTeam[tijdelijk$HomeTeam == "Roda"] <- "Roda JC"
tijdelijk$AwayTeam[tijdelijk$AwayTeam == "Roda"] <- "Roda JC"
tijdelijk$HomeTeam[tijdelijk$HomeTeam == "Twente"] <- "FC Twente"
tijdelijk$AwayTeam[tijdelijk$AwayTeam == "Twente"] <- "FC Twente"
tijdelijk$HomeTeam[tijdelijk$HomeTeam == "Utrecht"] <- "FC Utrecht"
tijdelijk$AwayTeam[tijdelijk$AwayTeam == "Utrecht"] <- "FC Utrecht"
tijdelijk$HomeTeam[tijdelijk$HomeTeam == "Volendam"] <- "FC Volendam"
tijdelijk$AwayTeam[tijdelijk$AwayTeam == "Volendam"] <- "FC Volendam"
tijdelijk$HomeTeam[tijdelijk$HomeTeam == "VVV Venlo"] <- "VVV-Venlo"
tijdelijk$AwayTeam[tijdelijk$AwayTeam == "VVV Venlo"] <- "VVV-Venlo"
tijdelijk$HomeTeam[tijdelijk$HomeTeam == "Waalwijk"] <- "RKC Waalwijk"
tijdelijk$AwayTeam[tijdelijk$AwayTeam == "Waalwijk"] <- "RKC Waalwijk"
tijdelijk$HomeTeam[tijdelijk$HomeTeam == "Zwolle"] <- "PEC Zwolle"
tijdelijk$AwayTeam[tijdelijk$AwayTeam == "Zwolle"] <- "PEC Zwolle"

#adding variable to indicate the season and make variable of type factor
tijdelijk <- tijdelijk %>% mutate(Season = case_when(Date < "2018-05-07" ~ "2017-2018",
                                                     (Date > "2018-08-09" & Date < "2019-05-16") ~ "2018-2019",
                                                     (Date > "2019-08-01" & Date < "2020-03-09") ~ "2019-2020",
                                                     (Date > "2020-09-11" & Date < "2021-05-17") ~ "2020-2021",
                                                     (Date > "2021-08-12" & Date < "2022-05-16") ~ "2021-2022",
                                                     Date > "2022-08-04" ~ "2022-2023"))
tijdelijk$Season <- as.factor(tijdelijk$Season)

#Import and make 538Data ready to merge -----
#read data into R and select only Eredivisie matches
alldata538 <- read.csv("spi_matches.csv")
data538 <- subset(alldata538, league == "Dutch Eredivisie")

data538 <- data538[!is.na(data538$score1),]

#omit variables league_id and league 
data538 <- subset(data538, select = -c(league_id, league))
#recode season variable and rename some variables
data538 <- data538 %>% mutate(season = case_when(season == "2017"  ~ "2017-2018",
                                                 season == "2018" ~ "2018-2019",
                                                 season == "2019" ~ "2019-2020",
                                                 season == "2020" ~ "2020-2021",
                                                 season == "2021" ~ "2021-2022",
                                                 season == "2022" ~ "2022-2023"))
colnames(data538)[1] <- "Season"
colnames(data538)[2] <- "Date"
colnames(data538)[3] <- "HomeTeam"
colnames(data538)[4] <- "AwayTeam"

#standardize and change club names 
data538$HomeTeam[data538$HomeTeam == "Emmen"] <- "FC Emmen"
data538$AwayTeam[data538$AwayTeam == "Emmen"] <- "FC Emmen"
data538$HomeTeam[data538$HomeTeam == "Heracles"] <- "Heracles Almelo"
data538$AwayTeam[data538$AwayTeam == "Heracles"] <- "Heracles Almelo"
data538$HomeTeam[data538$HomeTeam == "NEC"] <- "N.E.C."
data538$AwayTeam[data538$AwayTeam == "NEC"] <- "N.E.C."
data538$HomeTeam[data538$HomeTeam == "NAC"] <- "NAC Breda"
data538$AwayTeam[data538$AwayTeam == "NAC"] <- "NAC Breda"
data538$HomeTeam[data538$HomeTeam == "RKC"] <- "RKC Waalwijk"
data538$AwayTeam[data538$AwayTeam == "RKC"] <- "RKC Waalwijk"
data538$HomeTeam[data538$HomeTeam == "Cambuur Leeuwarden"] <- "SC Cambuur"
data538$AwayTeam[data538$AwayTeam == "Cambuur Leeuwarden"] <- "SC Cambuur"
data538$HomeTeam[data538$HomeTeam == "Heerenveen"] <- "sc Heerenveen"
data538$AwayTeam[data538$AwayTeam == "Heerenveen"] <- "sc Heerenveen"
data538$HomeTeam[data538$HomeTeam == "Sparta"] <- "Sparta Rotterdam"
data538$AwayTeam[data538$AwayTeam == "Sparta"] <- "Sparta Rotterdam"
data538$HomeTeam[data538$HomeTeam == "VVV Venlo"] <- "VVV-Venlo"
data538$AwayTeam[data538$AwayTeam == "VVV Venlo"] <- "VVV-Venlo"

#make sure data type is the same
data538$Season <- as.factor(data538$Season)
data538$Date <- as.Date(data538$Date)

#MERGE 538 DATA SET AND EREDIVISIE DATA TO GET FULLSET ----
fullset <- merge(tijdelijk, data538, by = c("Date", "HomeTeam", "AwayTeam", "Season"))

##Data Transformations on FULLSET ----- 
#adding dummy variable for attendance: 1 is yes, 0 is no attendance
fullset$AttDummy <- ifelse(fullset$Attendance > 0, "1", "0")

#adding variables for amount of points and goal difference
fullset <- fullset %>% mutate(Home_points = case_when(FTR == "H" ~ 3,
                                                      FTR == "D" ~ 1,
                                                      FTR == "A" ~ 0))

fullset <- fullset %>% mutate(Away_points = case_when(FTR == "H" ~ 0,
                                                      FTR == "D" ~ 1,
                                                      FTR == "A" ~ 3))

fullset <- fullset %>% mutate(GDHomeTeam = FTHG - FTAG)
fullset <- fullset %>% mutate(GDAwayTeam = FTAG - FTHG)

#Add column for the weekdays
weekdays <- weekdays(fullset$Date)
fullset$Weekday <- weekdays
fullset <- fullset %>% relocate(Weekday, .after = Date)

#factorize character columns and relevel weekday factor
fullset$Time <- as.factor(fullset$Time)
fullset$FTR <- as.factor(fullset$FTR)
fullset$HTR <- as.factor(fullset$HTR)
fullset$Weekday <- as.factor(fullset$Weekday)
fullset$Weekday <- factor(fullset$Weekday, levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"),
                          ordered = TRUE)
#Add STADIUM NAMES and CITIES
#Add Stadiums 
stadion <- replicate(1753, "0")
fullset$Stadium <- stadion

fullset$Stadium[fullset$HomeTeam == "ADO Den Haag"] <- "Kyocera Stadion"
fullset$Stadium[fullset$HomeTeam == "Ajax"] <- "Johan Cruijff ArenA"
fullset$Stadium[fullset$HomeTeam == "AZ" & (fullset$Date > "2017-08-02" & fullset$Date < "2019-08-17")] <- "AFAS Stadion"
fullset$Stadium[fullset$HomeTeam == "AZ" & (fullset$Date > "2019-08-17" & fullset$Date < "2019-12-02")] <- "Cars Jeans Stadion"
fullset$Stadium[fullset$HomeTeam == "AZ" & (fullset$Date > "2019-12-02")] <- "AFAS Stadion"
fullset$Stadium[fullset$HomeTeam == "De Graafschap"] <- "Stadion De Vijverberg"
fullset$Stadium[fullset$HomeTeam == "Excelsior"] <- "Van Donge & De Roo Stadion"
fullset$Stadium[fullset$HomeTeam == "FC Emmen"] <- "De Oude Meerdijk"
fullset$Stadium[fullset$HomeTeam == "FC Groningen"] <- "Euroborg"
fullset$Stadium[fullset$HomeTeam == "FC Twente"] <- "De Grolsch Veste"
fullset$Stadium[fullset$HomeTeam == "FC Utrecht"] <- "Stadion Galgenwaard"
fullset$Stadium[fullset$HomeTeam == "FC Volendam"] <- "Kras Stadion"
fullset$Stadium[fullset$HomeTeam == "Feyenoord"] <- "De Kuip"
fullset$Stadium[fullset$HomeTeam == "Fortuna Sittard"] <- "Fortuna Sittard Stadion"
fullset$Stadium[fullset$HomeTeam == "Go Ahead Eagles"] <- "De Adelaarshorst"
fullset$Stadium[fullset$HomeTeam == "Heracles Almelo"] <- "Erve Asito"
fullset$Stadium[fullset$HomeTeam == "N.E.C."] <- "Goffertstadion"
fullset$Stadium[fullset$HomeTeam == "NAC Breda"] <- "Rat Verlegh Stadion"
fullset$Stadium[fullset$HomeTeam == "PEC Zwolle"] <- "MAC3Park stadion"
fullset$Stadium[fullset$HomeTeam == "PSV"] <- "Philips Stadion"
fullset$Stadium[fullset$HomeTeam == "RKC Waalwijk"] <- "Mandemakers Stadion"
fullset$Stadium[fullset$HomeTeam == "Roda JC"] <- "Parkstad Limburg Stadion"
fullset$Stadium[fullset$HomeTeam == "SC Cambuur"] <- "Cambuur Stadion"
fullset$Stadium[fullset$HomeTeam == "sc Heerenveen"] <- "Abe Lenstra stadion"
fullset$Stadium[fullset$HomeTeam == "Sparta Rotterdam"] <- "Sparta Stadion"
fullset$Stadium[fullset$HomeTeam == "Vitesse"] <- "GelreDome"
fullset$Stadium[fullset$HomeTeam == "VVV-Venlo"] <- "Covebo Stadion - De Koel"
fullset$Stadium[fullset$HomeTeam == "Willem II"] <- "Koning Willem II Stadion"

#Add Cities 
steden <- replicate(1753, "0")
fullset$City <- steden

fullset$City[fullset$HomeTeam == "ADO Den Haag"] <- "Den Haag"
fullset$City[fullset$HomeTeam == "Ajax"] <- "Amsterdam"
fullset$City[fullset$HomeTeam == "AZ" & fullset$Date < "2019-08-18"] <- "Alkmaar"
fullset$City[fullset$HomeTeam == "AZ" & (fullset$Date > "2019-08-17" & fullset$Date < "2019-12-02")] <- "Den Haag"
fullset$City[fullset$HomeTeam == "AZ" & (fullset$Date > "2019-12-02")] <- "Alkmaar"
fullset$City[fullset$HomeTeam == "De Graafschap"] <- "Doetinchem"
fullset$City[fullset$HomeTeam == "Excelsior" | fullset$HomeTeam == "Feyenoord" | fullset$HomeTeam == "Sparta Rotterdam"] <- "Rotterdam"
fullset$City[fullset$HomeTeam == "FC Emmen"] <- "Emmen"
fullset$City[fullset$HomeTeam == "FC Groningen"] <- "Groningen"
fullset$City[fullset$HomeTeam == "FC Twente"] <- "Enschede"
fullset$City[fullset$HomeTeam == "FC Utrecht"] <- "Utrecht"
fullset$City[fullset$HomeTeam == "FC Volendam"] <- "Volendam"
fullset$City[fullset$HomeTeam == "Fortuna Sittard"] <- "Sittard"
fullset$City[fullset$HomeTeam == "Go Ahead Eagles"] <- "Deventer"
fullset$City[fullset$HomeTeam == "Heracles Almelo"] <- "Almelo"
fullset$City[fullset$HomeTeam == "N.E.C."] <- "Nijmegen"
fullset$City[fullset$HomeTeam == "NAC Breda"] <- "Breda"
fullset$City[fullset$HomeTeam == "PEC Zwolle"] <- "Zwolle"
fullset$City[fullset$HomeTeam == "PSV"] <- "Eindhoven"
fullset$City[fullset$HomeTeam == "RKC Waalwijk"] <- "Waalwijk"
fullset$City[fullset$HomeTeam == "Roda JC"] <- "Kerkrade"
fullset$City[fullset$HomeTeam == "SC Cambuur"] <- "Leeuwarden"
fullset$City[fullset$HomeTeam == "sc Heerenveen"] <- "Heerenveen"
fullset$City[fullset$HomeTeam == "Vitesse"] <- "Arnhem"
fullset$City[fullset$HomeTeam == "VVV-Venlo"] <- "Venlo"
fullset$City[fullset$HomeTeam == "Willem II"] <- "Tilburg"

#Add CAPACITY and OCCUPANCY RATE
#Add Capacity
capaciteit <- replicate(1753, 0)
fullset$StadiumCapacity <- capaciteit

fullset$StadiumCapacity[fullset$HomeTeam == "ADO Den Haag"] <- 15000
fullset$StadiumCapacity[fullset$HomeTeam == "Ajax"] <- 55600
fullset$StadiumCapacity[fullset$HomeTeam == "AZ" & fullset$Date < "2019-08-18"] <- 19478
fullset$StadiumCapacity[fullset$HomeTeam == "AZ" & (fullset$Date > "2019-08-17" & fullset$Date < "2019-12-02")] <- 15000
fullset$StadiumCapacity[fullset$HomeTeam == "AZ" & (fullset$Date > "2019-12-02")] <- 19478
fullset$StadiumCapacity[fullset$HomeTeam == "De Graafschap"] <- 12600
fullset$StadiumCapacity[fullset$HomeTeam == "Excelsior"] <- 4400
fullset$StadiumCapacity[fullset$HomeTeam == "FC Emmen"] <- 8309
fullset$StadiumCapacity[fullset$HomeTeam == "FC Groningen"] <- 22555
fullset$StadiumCapacity[fullset$HomeTeam == "FC Twente"] <- 30205
fullset$StadiumCapacity[fullset$HomeTeam == "FC Utrecht"] <- 23750
fullset$StadiumCapacity[fullset$HomeTeam == "FC Volendam"] <- 7384
fullset$StadiumCapacity[fullset$HomeTeam == "Feyenoord"] <- 47500
fullset$StadiumCapacity[fullset$HomeTeam == "Fortuna Sittard"] <- 12500
fullset$StadiumCapacity[fullset$HomeTeam == "Go Ahead Eagles"] <- 9909
fullset$StadiumCapacity[fullset$HomeTeam == "Heracles Almelo"] <- 12080
fullset$StadiumCapacity[fullset$HomeTeam == "N.E.C."] <- 12500
fullset$StadiumCapacity[fullset$HomeTeam == "NAC Breda"] <- 19000
fullset$StadiumCapacity[fullset$HomeTeam == "PEC Zwolle"] <- 14000
fullset$StadiumCapacity[fullset$HomeTeam == "PSV"] <- 35000
fullset$StadiumCapacity[fullset$HomeTeam == "RKC Waalwijk"] <- 7508
fullset$StadiumCapacity[fullset$HomeTeam == "Roda JC"] <- 19979
fullset$StadiumCapacity[fullset$HomeTeam == "SC Cambuur"] <- 10250
fullset$StadiumCapacity[fullset$HomeTeam == "sc Heerenveen"] <- 27224
fullset$StadiumCapacity[fullset$HomeTeam == "Sparta Rotterdam"] <- 11026
fullset$StadiumCapacity[fullset$HomeTeam == "Vitesse"] <- 21248
fullset$StadiumCapacity[fullset$HomeTeam == "VVV-Venlo"] <- 8000
fullset$StadiumCapacity[fullset$HomeTeam == "Willem II"] <- 14700

#add occupancy rate 
bezettingsgraad <- round(((fullset$Attendance/fullset$StadiumCapacity)*100), digits = 2)
fullset$OccupancyRate <- bezettingsgraad

#Add full time result in 1 variable 
sResult <- paste(fullset$FTHG, fullset$FTAG, sep = "-")
fullset$FT <- sResult

#IMPUTE IMPORTANCE WITH MEAN VALUES
fullset$importance1[is.na(fullset$importance1)] <- mean(fullset$importance1, na.rm=TRUE)
fullset$importance2[is.na(fullset$importance2)] <- mean(fullset$importance2, na.rm=TRUE)

#Add Dominance
fullset <- fullset %>% mutate(DominanceH = ((HS+HST+HC)/3))
fullset <- fullset %>% mutate(DominanceA = ((AS+AST+AC)/(3)))

### END Data Transformations 

#Delete rows from 19-20 and 22-23 of matches who have no home AND away game and give every match a game_id ----
fullset <- fullset[-c(616, 619, 620, 622, 623, 625, 633:635, 639, 640, 644, 646:648, 651, 653, 657, 660, 661, 664, 668, 672, 673, 675, 676, 680,
                      682, 684, 685, 687, 689, 695, 696, 702, 705, 707:710, 712, 715, 719, 720, 722, 724:728, 730, 732, 734:738, 740, 742:745, 748, 749,
                      751, 753:758, 760, 761, 765, 1465, 1475, 1505, 1513, 1514, 1540, 1577, 1592, 1601), ]

#Add variable indicating game_id
game_id <- seq(1, 1670, by = 1)
as.vector(game_id)
fullset$game_id <- game_id

#Duplicate entire data frame to manipulate and add columns ---- 
data_away <- fullset

#Adding variables specific to home/away team
fullset["Team"] <- "Team"
fullset["Venue"] <- 0
fullset["Covid"] <- 0
fullset["Points"] <- 0
fullset["Goals"] <- 0
fullset["Rating"] <- 0
fullset["Rating_opp"] <- 0
fullset["Rating_diff"] <- 0
fullset["Importance"] <- 0
fullset["Importance_opp"] <- 0
fullset["Importance_diff"] <- 0
fullset["Corners"] <- 0
fullset["Shots"] <- 0
fullset["Shots_target"] <- 0
fullset["Fouls"] <- 0
fullset["Yellow"] <- 0
fullset["Red"] <- 0
fullset["Dominance"] <- 0

data_away["Team"] <- "Team"
data_away["Venue"] <- 0
data_away["Covid"] <- 0
data_away["Points"] <- 0
data_away["Goals"] <- 0
data_away["Rating"] <- 0
data_away["Rating_opp"] <- 0
data_away["Rating_diff"] <- 0
data_away["Importance"] <- 0
data_away["Importance_opp"] <- 
data_away["Importance_diff"] <- 0
data_away["Corners"] <- 0
data_away["Shots"] <- 0
data_away["Shots_target"] <- 0
data_away["Fouls"] <- 0
data_away["Yellow"] <- 0
data_away["Red"] <- 0
data_away["Dominance"] <- 0

#Sort columns using Index ----
fullset <- fullset[colnames(fullset)[c(5, 1, 2, 6, 59:76, 58, 3, 4, 7:24, 56, 57, 29:45, 47, 48, 25:28, 46, 49:55)]]
data_away <- data_away[colnames(data_away)[c(5, 1, 2, 6, 59:76, 58, 3, 4, 7:24, 56, 57, 29:45, 47, 48, 25:28, 46, 49:55)]]

#Make value for new variables specific to home/away team ----
#For fullset
fullset["Team"] <- fullset["HomeTeam"]
fullset["Points"] <- fullset["Home_points"]
fullset["Goals"] <- fullset["FTHG"]
fullset["Rating"] <- fullset["spi1"]
fullset["Rating_opp"] <- fullset["spi2"]
fullset["Importance"] <- fullset["importance1"]
fullset["Importance_opp"] <- fullset["importance2"]
fullset["Corners"] <- fullset["HC"]
fullset["Shots"] <- fullset["HS"]
fullset["Shots_target"] <- fullset["HST"]
fullset["Fouls"] <- fullset["HF"]
fullset["Yellow"] <- fullset["HY"]
fullset["Red"] <- fullset["HR"]
fullset["Dominance"] <- fullset["DominanceH"]
#Calculate rating difference & importance difference, plus assign venue
fullset <- fullset %>% mutate(Rating_diff = Rating - Rating_opp)
fullset <- fullset %>% mutate(Importance_diff = Importance - Importance_opp)
fullset$Venue <- ifelse(fullset$Team == fullset$HomeTeam, 0, 1)
#Assign value to COVID periods
fullset <- fullset %>% mutate(Covid = case_when(Date < "2020-03-20" ~ 0, 
                                                (Date > "2020-03-20" & Date < "2022-02-18" & Attendance > 0) ~ 1,
                                                (Date > "2020-03-20" & Date < "2022-02-18" & Attendance == 0) ~ 2,
                                                Date > "2020-03-18" ~ 3))

#For away data set
data_away["Team"] <- data_away["AwayTeam"]
data_away["Points"] <- data_away["Away_points"]
data_away["Goals"] <- data_away["FTAG"]
data_away["Rating"] <- data_away["spi2"]
data_away["Rating_opp"] <- data_away["spi1"]
data_away["Importance"] <- data_away["importance2"]
data_away["Importance_opp"] <- data_away["importance1"]
data_away["Corners"] <- data_away["AC"]
data_away["Shots"] <- data_away["AS"]
data_away["Shots_target"] <- data_away["AST"]
data_away["Fouls"] <- data_away["AF"]
data_away["Yellow"] <- data_away["AY"]
data_away["Red"] <- data_away["AR"]
data_away["Dominance"] <- data_away["DominanceA"]
#Calculate rating difference & importance difference, plus assign venue
data_away <- data_away %>% mutate(Rating_diff = Rating - Rating_opp)
data_away <- data_away %>% mutate(Importance_diff = Importance - Importance_opp)
data_away$Venue <- ifelse(data_away$Team == data_away$HomeTeam, 0, 1)

#Assign value to COVID Periods
data_away <- data_away %>% mutate(Covid = case_when(Date < "2020-03-20" ~ 0, 
                                                    (Date > "2020-03-20" & Date < "2022-02-18" & Attendance > 0) ~ 1,
                                                    (Date > "2020-03-20" & Date < "2022-02-18" & Attendance == 0) ~ 2,
                                                    Date > "2020-03-18" ~ 3))

#COMBINE TO ADD FINAL DATA FRAME -----
finaldata <- rbind(fullset, data_away)
finaldata <- finaldata[order(finaldata$game_id),]

#Make League table for 2017-18 tm 2021-22 and manually for 22-23 -----
#league tables via english soccer data
ltable17.18 <- leaguetable(dataset=engsoccerdata::holland[which(engsoccerdata::holland$Season==2017),], home="home", away="visitor",score_home="hgoal", score_away="vgoal", date="Date",
                           points = c(3,1,0), rank_by = c("GD","GD_DC","GF_DC","GD","GF"), DC_display = FALSE)

ltable18.19 <- leaguetable(dataset=engsoccerdata::holland[which(engsoccerdata::holland$Season==2018),], home="home", away="visitor",score_home="hgoal", score_away="vgoal", date="Date",
                           points = c(3,1,0), rank_by = c("GD","GD_DC","GF_DC","GD","GF"), DC_display = FALSE)

ltable19.20 <- leaguetable(dataset=engsoccerdata::holland[which(engsoccerdata::holland$Season==2019),], home="home", away="visitor",score_home="hgoal", score_away="vgoal", date="Date",
                           points = c(3,1,0), rank_by = c("GD","GD_DC","GF_DC","GD","GF"), DC_display = FALSE)

ltable20.21 <- leaguetable(dataset=engsoccerdata::holland[which(engsoccerdata::holland$Season==2020),], home="home", away="visitor",score_home="hgoal", score_away="vgoal", date="Date",
                           points = c(3,1,0), rank_by = c("GD","GD_DC","GF_DC","GD","GF"), DC_display = FALSE)

ltable21.22 <- leaguetable(dataset=engsoccerdata::holland[which(engsoccerdata::holland$Season==2021),], home="home", away="visitor",score_home="hgoal", score_away="vgoal", date="Date",
                           points = c(3,1,0), rank_by = c("GD","GD_DC","GF_DC","GD","GF"), DC_display = FALSE)

#standardize and change club names
ltable17.18$Team[ltable17.18$Team == "PSV Eindhoven"] <- "PSV"
ltable17.18$Team[ltable17.18$Team == "AFC Ajax"] <- "Ajax"
ltable17.18$Team[ltable17.18$Team == "AZ Alkmaar"] <- "AZ"
ltable17.18$Team[ltable17.18$Team == "Heracles"] <- "Heracles Almelo"
ltable17.18$Team[ltable17.18$Team == "SBV Excelsior"] <- "Excelsior"
ltable17.18$Team[ltable17.18$Team == "Roda JC Kerkrade"] <- "Roda JC"

ltable18.19$Team[ltable18.19$Team == "PSV Eindhoven"] <- "PSV"
ltable18.19$Team[ltable18.19$Team == "AFC Ajax"] <- "Ajax"
ltable18.19$Team[ltable18.19$Team == "AZ Alkmaar"] <- "AZ"
ltable18.19$Team[ltable18.19$Team == "Heracles"] <- "Heracles Almelo"
ltable18.19$Team[ltable18.19$Team == "SBV Excelsior"] <- "Excelsior"

ltable19.20$Team[ltable19.20$Team == "PSV Eindhoven"] <- "PSV"
ltable19.20$Team[ltable19.20$Team == "AFC Ajax"] <- "Ajax"
ltable19.20$Team[ltable19.20$Team == "AZ Alkmaar"] <- "AZ"
ltable19.20$Team[ltable19.20$Team == "Heracles"] <- "Heracles Almelo"

ltable20.21$Team[ltable20.21$Team == "PSV Eindhoven"] <- "PSV"
ltable20.21$Team[ltable20.21$Team == "AFC Ajax"] <- "Ajax"
ltable20.21$Team[ltable20.21$Team == "AZ Alkmaar"] <- "AZ"
ltable20.21$Team[ltable20.21$Team == "Heracles"] <- "Heracles Almelo"

ltable21.22$Team[ltable21.22$Team == "PSV Eindhoven"] <- "PSV"
ltable21.22$Team[ltable21.22$Team == "AFC Ajax"] <- "Ajax"
ltable21.22$Team[ltable21.22$Team == "AZ Alkmaar"] <- "AZ"
ltable21.22$Team[ltable21.22$Team == "Heracles"] <- "Heracles Almelo"
ltable21.22$Team[ltable21.22$Team == "NEC Nijmegen"] <- "N.E.C."

#manually make leauguetable for 2022-2023 season
pos <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18)
team <- c("Feyenoord", "PSV", "Ajax", "AZ", "FC Twente", "Sparta Rotterdam", "FC Utrecht", "sc Heerenveen", "RKC Waalwijk", "Go Ahead Eagles", "N.E.C.", 
          "Vitesse", "Fortuna Sittard", "FC Volendam", "Excelsior", "FC Emmen", "FC Groningen", "SC Cambuur")
P <- replicate(18, 33)
W <- c(25, 22, 20, 20, 17, 16, 14, 11, 11, 10, 8, 9, 10, 9, 9, 6, 4, 4)
D <- c(7, 6, 9, 7, 10, 8, 9, 10, 8, 10, 14, 10, 5, 6, 5, 10, 6, 4)
L <- c(1, 5, 4, 6, 6, 9, 10, 12, 14, 13, 11, 14, 18, 18, 19, 17, 23, 25)
Pts <- c(82, 72, 69, 67, 61, 56, 51, 43, 41, 40, 38, 37, 35, 33, 32, 28, 18, 16)
GF <- c(81, 87, 85, 67, 63, 55, 52, 42, 50, 46, 41, 44, 38, 39, 30, 31, 31, 22)
GA <- c(29, 39, 35, 33, 26, 37, 48, 50, 60, 54, 44, 50, 61, 69, 68, 62, 70, 69)
GD <-  c(52, 48, 50, 34, 37, 18, 4, -8, -10, -8, -3, -6, -23, -30, -38, -31, -39, -47)

ltable22.23 <- cbind(pos, team, P, W, D, L, Pts, GF, GA, GD)
ltable22.23 <- as_tibble(ltable22.23)

#split Fullset & Final data set set into seasons ----
#each observations as original
season17.18 <- subset(fullset, fullset$Date < "2018-05-07")
season18.19 <- subset(fullset, (fullset$Date > "2018-08-09" & fullset$Date < "2019-05-16"))
season19.20 <- subset(fullset, (fullset$Date > "2019-08-01" & fullset$Date < "2020-03-09"))
season20.21 <- subset(fullset, (fullset$Date > "2020-09-11" & fullset$Date < "2021-05-17"))
season21.22 <- subset(fullset, (fullset$Date > "2021-08-12" & fullset$Date < "2022-05-16"))
season22.23 <- subset(fullset, fullset$Date > "2022-08-04")

#each season with 2 obs per game
season17.18double <- subset(finaldata, finaldata$Date < "2018-05-07")
season18.19double <- subset(finaldata, (finaldata$Date > "2018-08-09" & finaldata$Date < "2019-05-16"))
season19.20double <- subset(finaldata, (finaldata$Date > "2019-08-01" & finaldata$Date < "2020-03-09"))
season20.21double <- subset(finaldata, (finaldata$Date > "2020-09-11" & finaldata$Date < "2021-05-17"))
season21.22double <- subset(finaldata, (finaldata$Date > "2021-08-12" & finaldata$Date < "2022-05-16"))
season22.23double <- subset(finaldata, finaldata$Date > "2022-08-04")

### START CODING ----

#Data preparation from McCarrick et al. 
#make factors out of variables 
finaldata$Venue = as.factor(finaldata$Venue)
finaldata$Covid = as.factor(finaldata$Covid)
finaldata$ArtGrass = as.factor(finaldata$ArtGrass)
finaldata$PromotedH = as.factor(finaldata$PromotedH)
finaldata$PromotedA = as.factor(finaldata$PromotedA)

#Label new factors
finaldata$Venue <- factor(finaldata$Venue, levels = c(0, 1), labels = c("Home", "Away")) 
finaldata$Covid <- factor(finaldata$Covid, levels = c(0, 1, 2, 3), labels = c("Before", "DuringRestrAtt", "DuringWOAtt", "After"))
finaldata$ArtGrass <- factor(finaldata$ArtGrass, levels = c(0, 1), labels = c("Normal Grass", "Artificial Grass"))
finaldata$PromotedH <- factor(finaldata$PromotedH, levels = c(0, 1), labels = c("No change", "Promoted"))
finaldata$PromotedA <- factor(finaldata$PromotedA, levels = c(0, 1), labels = c("No change", "Promoted"))

finaldata$Points = as.numeric(finaldata$Points)
finaldata$Goals = as.numeric(finaldata$Goals)

#Z-value for Rating and Importance Differences
finaldata$Rating_z = as.numeric(scale(finaldata$Rating))
finaldata$Rating_diff_z = as.numeric(scale(finaldata$Rating_diff))
finaldata$Rating_opp_z = as.numeric(scale(finaldata$Rating_opp))
finaldata$Importance_z = as.numeric(scale(finaldata$Importance))
finaldata$Importance_diff_z = as.numeric(scale(finaldata$Importance_diff))
finaldata$Importance_opp_z = as.numeric(scale(finaldata$Importance_opp))
finaldata$Dominance <- scale(finaldata$Dominance)
finaldata$OccupancyRate <- scale(finaldata$OccupancyRate)

#MODELING PART ------
#Check normality for Goals, Points, Corners, Shots, Shots OT, Dominance, cards and fouls -----
#check normality via Density plots
ggdensity(finaldata$Points)
ggdensity(finaldata$Goals)
ggdensity(finaldata$Corners)
ggdensity(finaldata$Shots_target)
ggdensity(finaldata$Shots)
ggdensity(finaldata$Dominance)
ggdensity(finaldata$Yellow)
ggdensity(finaldata$Red)
ggdensity(finaldata$Fouls)

#Check normality via QQ plot
ggqqplot(finaldata$Points)
ggqqplot(finaldata$Goals)
ggqqplot(finaldata$Corners)
ggqqplot(finaldata$Shots_target)
ggqqplot(finaldata$Shots)
ggqqplot(finaldata$Dominance)
ggqqplot(finaldata$Yellow)
ggqqplot(finaldata$Red)
ggqqplot(finaldata$Fouls)

#assess normality via shapiro wilk test
shapiro.test(finaldata$Goals)
shapiro.test(finaldata$Points)
shapiro.test(finaldata$Corners)
shapiro.test(finaldata$Shots)
shapiro.test(finaldata$Shots_target)
shapiro.test(finaldata$Dominance)
shapiro.test(finaldata$Yellow)
shapiro.test(finaldata$Red)
shapiro.test(finaldata$Fouls)

#Check correlation between shots, shots on target and corners ----
#correlation between Shots en Shots on Target: 0.74
cor(finaldata$Shots, finaldata$Shots_target, method = "spearman")
#correlation between Shots en Corners: 0.59
cor(finaldata$Shots, finaldata$Corners,  method = "spearman")
#correlation between Shots on Target en Corners: 0, 42
cor(finaldata$Shots_target, finaldata$Corners,  method = "spearman") 

## MAKE PLOTS for Response Variables -----
#Attacking variables -----
#plot Points
plotPoints <- finaldata %>%
  group_by(Covid, Venue) %>%
  summarise(n= n(), 
            mean = mean(Points),
            sd = sd(Points),
            se = sd/sqrt(n))

plotPointstest <- finaldata %>%
  group_by(Covid, Venue, Season) %>%
  summarise(n= n(), 
            mean = mean(Points),
            sd = sd(Points),
            se = sd/sqrt(n))

ggplot(plotPoints, aes(x = Covid, 
                       y = mean, 
                       group = Venue, 
                       color = Venue)) +
  geom_point(size = 3) +
  geom_line(linewidth = 1) +
  geom_errorbar(aes(ymin= mean-se, 
                    ymax= mean+se),
                width = 0.1) +
  labs(y = "Points (per game)", x = "COVID Period", title = "Points per game for each COVID Period")

#plot goals
plotGoals <- finaldata %>%
  group_by(Covid, Venue) %>%
  summarise(n= n(), 
            mean = mean(Goals),
            sd = sd(Goals),
            se = sd/sqrt(n))

plotGoalstest <- finaldata %>%
  group_by(Covid, Venue, Season) %>%
  summarise(n= n(), 
            mean = mean(Goals),
            sd = sd(Goals),
            se = sd/sqrt(n))

ggplot(plotGoals, aes(x = Covid, 
                      y = mean, 
                      group = Venue, 
                      color = Venue)) +
  geom_point(size =3) +
  geom_line(size = 1) +
  geom_errorbar(aes(ymin= mean-se, 
                    ymax= mean+se),
                width = 0.1) + 
  labs(title = "Goals per game for each COVID Period", y = "Goals (per game)", x = "COVID Period")

#plot Corners
plotCorners <- finaldata %>%
  group_by(Covid, Venue) %>%
  summarise(n= n(), 
            mean = mean(Corners),
            sd = sd(Corners),
            se = sd/sqrt(n))

plotCornerstest <- finaldata %>%
  group_by(Covid, Venue, Season) %>%
  summarise(n= n(), 
            mean = mean(Corners),
            sd = sd(Corners),
            se = sd/sqrt(n))

ggplot(plotCorners, aes(x = Covid, 
                        y = mean, 
                        group = Venue, 
                        color = Venue)) +
  geom_point(size =3) +
  geom_line(size = 1) +
  geom_errorbar(aes(ymin= mean-se, 
                    ymax= mean+se),
                width = 0.1) + 
  labs(title = "Corners per game for each COVID Period", y = "Corners (per game)", x = "COVID Period")

#plot Shots
plotShots <- finaldata %>%
  group_by(Covid, Venue) %>%
  summarise(n= n(), 
            mean = mean(Shots),
            sd = sd(Shots),
            se = sd/sqrt(n))

plotShotstest <- finaldata %>%
  group_by(Covid, Venue, Season) %>%
  summarise(n= n(), 
            mean = mean(Shots),
            sd = sd(Shots),
            se = sd/sqrt(n))

ggplot(plotShots, aes(x = Covid, 
                      y = mean, 
                      group = Venue, 
                      color = Venue)) +
  geom_point(size =3) +
  geom_line(size = 1) +
  geom_errorbar(aes(ymin= mean-se, 
                    ymax= mean+se),
                width = 0.1) +
  labs(title= "Shots per game for each COVID Period", x = "COVID Period", y = "Shots (per game)")

#plot Shots on Target
plotShotsOT <- finaldata %>%
  group_by(Covid, Venue) %>%
  summarise(n= n(), 
            mean = mean(Shots_target),
            sd = sd(Shots_target),
            se = sd/sqrt(n))

plotShotsOTtest <- finaldata %>%
  group_by(Covid, Venue, Season) %>%
  summarise(n= n(), 
            mean = mean(Shots_target),
            sd = sd(Shots_target),
            se = sd/sqrt(n))

ggplot(plotShotsOT, aes(x = Covid, 
                        y = mean, 
                        group = Venue, 
                        color = Venue)) +
  geom_point(size =3) +
  geom_line(size = 1) +
  geom_errorbar(aes(ymin= mean-se, 
                    ymax= mean+se),
                width = 0.1) +
  labs(title= "Shots on target per game for each COVID Period", x = "COVID Period", y = "Shots on target (per game)")

#Plot Dominance 
plotDominance <- finaldata %>%
group_by(Covid, Venue) %>%
  summarise(n= n(), 
            mean = mean(Dominance),
            sd = sd(Dominance),
            se = sd/sqrt(n))

plotDominancetest <- finaldata %>%
  group_by(Covid, Venue, Season) %>%
  summarise(n= n(), 
            mean = mean(Dominance),
            sd = sd(Dominance),
            se = sd/sqrt(n))

ggplot(plotDominance, aes(x = Covid, 
                        y = mean, 
                        group = Venue, 
                        color = Venue)) +
  geom_point(size =3) +
  geom_line(size = 1) +
  geom_errorbar(aes(ymin= mean-se, 
                    ymax= mean+se),
                width = 0.1) +
  labs(title= "Dominance in each COVID Period", x = "COVID Period", y = "Dominance")


#Referee Bias variables -----
#Plot Fouls
plotFouls <- finaldata %>%
  group_by(Covid, Venue) %>%
  summarise(n= n(), 
            mean = mean(Fouls),
            sd = sd(Fouls),
            se = sd/sqrt(n))

plotFoulstest <- finaldata %>%
  group_by(Covid, Venue, Season) %>%
  summarise(n= n(), 
            mean = mean(Fouls),
            sd = sd(Fouls),
            se = sd/sqrt(n))

ggplot(plotFouls, aes(x = Covid, 
                      y = mean, 
                      group = Venue, 
                      color = Venue)) +
  geom_point(size =3) +
  geom_line(size = 1) +
  geom_errorbar(aes(ymin= mean-se, 
                    ymax= mean+se),
                width = 0.1) +
  labs(title = "Fouls per game for each COVID Period", x = "COVID Period", y = "Fouls (per game)")


#Plot Yellows
plotYellows <- finaldata %>%
  group_by(Covid, Venue) %>%
  summarise(n= n(), 
            mean = mean(Yellow),
            sd = sd(Yellow),
            se = sd/sqrt(n))

plotYellowstest <- finaldata %>%
  group_by(Covid, Venue, Season) %>%
  summarise(n= n(), 
            mean = mean(Yellow),
            sd = sd(Yellow),
            se = sd/sqrt(n))


ggplot(plotYellows, aes(x = Covid, 
                        y = mean, 
                        group = Venue, 
                        color = Venue)) +
  geom_point(size =3) +
  geom_line(size = 1) +
  geom_errorbar(aes(ymin= mean-se, 
                    ymax= mean-se),
                width = 0.1) + 
  labs(title = "Yellow cards per game for each COVID Period", x = "COVID Period", y = "Yellow cards (per game)")

#Plot Reds
plotReds <- finaldata %>%
  group_by(Covid, Venue) %>%
  summarise(n= n(), 
            mean = mean(Red),
            sd = sd(Red),
            se = sd/sqrt(n))

plotRedstest <- finaldata %>%
  group_by(Covid, Venue, Season) %>%
  summarise(n= n(), 
            mean = mean(Red),
            sd = sd(Red),
            se = sd/sqrt(n))

ggplot(plotReds, aes(x = Covid, 
                     y = mean, 
                     group = Venue, 
                     color = Venue)) +
  geom_point(size =3) +
  geom_line(size = 1) +
  geom_errorbar(aes(ymin= mean-se, 
                    ymax= mean+se),
                width = 0.1) +
  labs(title = "Red cards per game for each COVID Period", x = "COVID Period", y = "Red cards (per game)")




#MAKE MODELS ----
#Attacking variables ----
#POINTS (poisson) ----
#add both rating and importance differences
final_points <- glmer(Points ~ Venue * Covid + Rating_diff_z * Venue + Rating_diff_z * Importance_diff_z + (1 | Team), data=finaldata, 
                      family = poisson(link="log"))

final_points_test <- glmer(Points ~ Venue * Covid + Rating_diff_z * Venue + Rating_diff_z * Importance_diff_z + (1 | Season), data=finaldata, 
                      family = poisson(link="log"))

summary(final_points_test)

#account for also season 
final_points_season <- glmer(Points ~ Venue * Covid + Rating_diff_z * Venue + Rating_diff_z * Importance_diff_z + (1 | Team) + (1 | Season), data=finaldata, 
                            family = poisson(link="log"))

#account for grass by interaction with venue --> not significant
final_points_grass <- glmer(Points ~ Venue * Covid + Rating_diff_z * Venue + Rating_diff_z * Importance_diff_z + (1 | Team) + Venue * ArtGrass, data=finaldata, 
                           family = poisson(link="log"))
 
#add also grass + add it to the model by itself --> not significant
final_points_grass2 <- glmer(Points ~ Venue * Covid + Rating_diff_z * Venue + Rating_diff_z * Importance_diff_z + (1 | Team) + ArtGrass, data=finaldata, 
                            family = poisson(link="log"))

#when adding Occupancyrate * Venue, this is significant, however, (interaction with venue &) covid w/o att niet meer dus we houden hem eruit
final_points_occ <- glmer(Points ~ Venue * Covid + Rating_diff_z * Venue + Rating_diff_z * Importance_diff_z + (1 | Team) + OccupancyRate * Venue , data=finaldata, 
                             family = poisson(link="log"))


final_points_season_rating <- glmer(Points ~ Venue * Covid + Rating_diff_z * Venue + Rating_diff_z * Importance_diff_z + Rating_diff_z * Covid + (1 | Team) + (1 | Season), data=finaldata, 
                             family = poisson(link="log"))
#Summary models 
summary(final_points)
summary(final_points_season)
summary(final_points_grass)
summary(final_points_grass2)
summary(final_points_season_rating)


#Plot standardized coefficients of models (Rate Ratios)
plot_model(final_points, type = "std", show.values = TRUE, value.offset = 0.3)
plot_model(final_points_season, type = "std", show.values = TRUE, value.offset = 0.3)
plot_model(final_points_grass, type = "std", show.values = TRUE, value.offset = 0.3)
plot_model(final_points_grass2, type = "std", show.values = TRUE, value.offset = 0.3)
plot_model(final_points_occ, type = "std", show.values = TRUE, value.offset = 0.3)

#ICC
icc(final_points)
icc(final_points_season)

#GOALS -----
# Add both rating and importance differences
final_goals <- glmer(Goals ~ Venue * Covid + Rating_diff_z + 
                       Importance_diff_z + (1 | Team), data = finaldata, family = poisson(link = "log"))
#Account for season
final_goals_season <- glmer(Goals ~ Venue * Covid + Rating_diff_z + 
                              Importance_diff_z + (1 | Team) + (1 | Season), data = finaldata, 
                            family = poisson(link = "log"))

#account for grass -> niet significant
final_goals_grass <- glmer(Goals ~ Venue * Covid + Rating_diff_z * Venue + Rating_diff_z * Importance_diff_z + (1 | Team) + Venue * ArtGrass, data=finaldata, 
                           family = poisson(link="log"))
#add also grass -> niet significant
final_goals_grass2 <- glmer(Goals ~ Venue * Covid + Rating_diff_z * Venue + Rating_diff_z * Importance_diff_z + (1 | Team) + ArtGrass, data=finaldata, 
                            family = poisson(link="log"))
#add occupancy rate -> niet significant
final_goals_occ <- glmer(Goals ~ Venue * Covid + Rating_diff_z * Venue + Rating_diff_z * Importance_diff_z + (1 | Team) + OccupancyRate * Venue, data=finaldata, 
                            family = poisson(link="log"))
#Summary models
summary(final_goals)
summary(final_goals_season)
summary(final_goals_grass)
summary(final_goals_grass2)
summary(final_goals_occ)

#Plot standardized coefficients of models (Rate Ratios)
plot_model(final_goals, type = "std", show.values = TRUE, value.offset = 0.3)
plot_model(final_goals_season, type = "std", show.values = TRUE, value.offset = 0.3)
plot_model(final_goals_grass, type = "std", show.values = TRUE, value.offset = 0.3)
plot_model(final_goals_grass2, type = "std", show.values = TRUE, value.offset = 0.3)
plot_model(final_goals_occ, type = "std", show.values = TRUE, value.offset = 0.3)

#ICC
icc(final_points)
icc(final_points_nor)

#DOMINANCE ----
#add both rating and importance differences
final_dominance <- lmer(Dominance ~ Venue * Covid + Rating_diff_z * 
                          Importance_diff_z + Rating_diff_z * Venue + Importance_diff_z + 
                          (1 | Team), data = finaldata)
#account for season
final_dominance_league <- lmer(Dominance ~ Venue * Covid + Rating_diff_z * 
                                 Importance_diff_z + Rating_diff_z * Venue + Importance_diff_z + 
                                 (1 | Team) + (1 | Season), data = finaldata)
#add grass * Venue --> niet sig
final_dominance_grass <- lmer(Dominance ~ Venue * Covid + Rating_diff_z * 
                            Importance_diff_z + Rating_diff_z * Venue + Importance_diff_z + ArtGrass * Venue,
                          data = finaldata)
#add grass in itself --> niet sig
final_dominance_grass2 <- lmer(Dominance ~ Venue * Covid + Rating_diff_z * 
                              Importance_diff_z + Rating_diff_z * Venue + Importance_diff_z + ArtGrass,
                            data = finaldata)

#no random effects
final_dominance_nor <- lm(Dominance ~ Venue * Covid + Rating_diff_z * 
                            Importance_diff_z + Rating_diff_z * Venue + Importance_diff_z, 
                          data = finaldata)

#summary models dominance
summary(final_dominance)
summary(final_dominance_league)
summary(final_dominance_grass2)
summary(final_dominance_nor)

#plot standardized coefficients
plot_model(final_dominance, type = "std", show.values = TRUE, 
           value.offset = 0.3)
lm.beta(final_dominance_nor)

### Make tables of points/goals/dominance models  -----
remotes::install_github("gorkang/html2latex")
library(html2latex)

sjPlot::tab_model(
  final_points, final_goals, final_dominance,
  show.r2 = T,
  show.icc = T,
  show.ci = F,
  show.se = T,
  show.re.var = T,
  p.style = "numeric",
  emph.p = TRUE,
  file = "Points-goals-dominancemodel.html",
  digits.p = 2
)

html2pdf(filename = "Points-goals-dominancemodel.html", page_width = 13, build_pdf = T, silent = F)

tab_model(final_points, final_goals, final_dominance,
          show.ci=F,
          show.se=T,
          show.obs = F,
          p.style= "numeric",
          digits = 2)

#Referee - variables ------
#Fouls model without dominance---- 
final_fouls_zonder_dom <- lmer(Fouls ~ Venue * Covid + Rating_diff_z * Importance_diff_z + Rating_diff_z * Venue + Importance_diff_z +
                                (1 | Team ), data = finaldata)

final_fouls_met_dom <- lmer(Fouls ~ Venue * Covid + Dominance + Rating_diff_z * 
                              Importance_diff_z + Rating_diff_z * Venue + Importance_diff_z + 
                              (1 | Team), data = finaldata)

#add both rating and importance differences
final_fouls <- lmer(Fouls ~ Venue * Covid + Dominance + Rating_diff_z * 
                      Importance_diff_z + Rating_diff_z * Venue + Importance_diff_z + 
                      (1 | Team), data = finaldata)

#account for random effects of season
final_fouls_season <- lmer(Fouls ~ Venue * Covid + Dominance + Rating_diff_z * 
                      Importance_diff_z + Rating_diff_z * Venue + Importance_diff_z + 
                      (1 | Team) + (1 | Season), data = finaldata)

#add grass * Venue
final_fouls_grass <- lmer(Fouls ~ Venue * Covid + Dominance + Rating_diff_z * 
                      Importance_diff_z + Rating_diff_z * Venue + Importance_diff_z + 
                      (1 | Team) + Venue * ArtGrass, data = finaldata)

#Add grass in itself
final_fouls_grass2 <- lmer(Fouls ~ Venue * Covid + Dominance + Rating_diff_z * 
                            Importance_diff_z + Rating_diff_z * Venue + Importance_diff_z + 
                            (1 | Team) + ArtGrass, data = finaldata)

#Summary Fouls models (w/o dominance)
summary(final_fouls)
summary(final_fouls_season)
summary(final_fouls_grass)
summary(final_fouls_grass2)
summary(final_fouls_zonder_dom)
summary(final_fouls_met_dom)

#see difference between fouls met en without dom
tab_model(final_fouls_zonder_dom, final_fouls_met_dom,
          show.ci=F,
          show.se=T,
          show.obs = F,
          p.style= "numeric")

lm.beta(final_fouls_zonder_dom)

#plot standardized coefficients (rate ratios)
plot_model(final_fouls, type = "std", show.values = TRUE, value.offset = 0.3)
plot_model(final_fouls_season, type = "std", show.values = TRUE, value.offset = 0.3)
plot_model(final_fouls_grass, type = "std", show.values = TRUE, value.offset = 0.3)
plot_model(final_fouls_grass2, type = "std", show.values = TRUE, value.offset = 0.3)
plot_model(final_fouls_zonder_dom, type = "std", show.values = TRUE, value.offset = 0.3)
plot_model(final_fouls_met_dom, type = "std", show.values = TRUE, value.offset = 0.3)

#performance using icc
performance::icc(final_fouls)
performance::icc(final_fouls_season)
performance::icc(final_fouls_grass)
performance::icc(final_fouls_grass2)



#Yellows ---- 
#final yellow zonder dom 
final_yellow_zonder_dom <- glmer(Yellow ~ Venue * Covid + Rating_diff_z * 
                        Venue + (1 | Team), data = finaldata, family = poisson(link = "log"))

#model yellow met dominance 
final_yellow_met_dom <- glmer(Yellow ~ Venue * Covid + Dominance + Rating_diff_z * 
                        Venue + (1 | Team), data = finaldata, family = poisson(link = "log"))

#compare models
tab_model(final_yellow_zonder_dom, final_yellow_met_dom,
          show.ci=F,
          show.se=T,
          show.obs = F,
          p.style= "numeric")

# Add covid x venue x rating interaction
final_yellow <- glmer(Yellow ~ Venue * Covid + Dominance + Rating_diff_z * 
                        Venue + (1 | Team), data = finaldata, family = poisson(link = "log"))

#account for random effects season 
final_yellow_season <- glmer(Yellow ~ Venue * Covid + Dominance + 
                               Rating_diff_z * Venue + (1 | Team) + (1 | Season), data = finaldata, 
                             family = poisson(link = "log"))

#Summary yellow models
summary(final_yellow)
summary(final_yellow_season)

#plot standardized coefficients for yellow
plot_model(final_yellow, type = "std", show.values = TRUE, value.offset = 0.3)
plot_model(final_yellow_season, type = "std", show.values = TRUE, value.offset = 0.3)

#assess performance yellows
performance::icc(final_yellow)
performance::icc(final_yellow_season)

#Reds ----- 
#red cards zonder dominance
final_red_zonder_dom <- glmer(Red ~ Venue * Covid + Rating_diff_z + 
                     (1 | Team), data = finaldata, family = poisson(link = "log"))

#red cards met dominance 
final_red_met_dom <- glmer(Red ~ Venue * Covid + Dominance + Rating_diff_z + 
                     (1 | Team), data = finaldata, family = poisson(link = "log"))

#compare both models with and without dominance
tab_model(final_red_zonder_dom, final_red_met_dom,
          show.ci=F,
          show.se=T,
          show.obs = F,
          p.style= "numeric")


# Add covid x venue x rating interaction
final_red <- glmer(Red ~ Venue * Covid + Dominance + Rating_diff_z + 
                     (1 | Team), data = finaldata, family = poisson(link = "log"))

#account for random effects season
final_red_season <- glmer(Red ~ Venue * Covid  + Dominance + Rating_diff_z + 
                            (1 | Team) + (1 | Season), data = finaldata, family = poisson(link = "log"))

#summary red models
summary(final_red)
summary(final_red_season)

#plot standardized coefficients (rate ratios)
plot_model(final_red, type = "std", show.values = TRUE, value.offset = 0.3)
plot_model(final_red_season, type = "std", show.values = TRUE, value.offset = 0.3)

### Make table for fouls/yellows/reds models  -----
remotes::install_github("gorkang/html2latex")
library(html2latex)

sjPlot::tab_model(
  final_fouls, final_yellow, final_red,
  show.r2 = T,
  show.icc = T,
  show.ci = F,
  show.se = T,
  show.re.var = T,
  p.style = "numeric",
  emph.p = TRUE,
  file = "Refereeperformancemodel"
)

tab_model(final_fouls, final_yellow, final_red,
          show.ci=F,
          show.se=T,
          show.obs = T,
          p.style= "numeric",
          digits = 2)

html2pdf(filename = "refereeperf", page_width = 13, build_pdf = T, silent = F)

lm.beta(final_fouls)











