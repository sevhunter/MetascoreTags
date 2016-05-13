
#Create an install folder for packages and install needed packages for code.
.libPaths("Your Library Path")
install.packages("xlsx")
install.packages("reshape2")
install.packages("caret", dependencies = c("Depends","Suggests"))
install.packages("MASS")
install.packages("glmnet")
install.packages("Metrics")

library(caret)
library(mlbench)
library(xlsx)
library(MASS)
library(glmnet)
library(Metrics)
library(reshape2)

#Import Data
MCTags<-read.csv("Your File Location/MCTags.csv",check.names = FALSE)

####################################################
#Categorisation

#Create vectors with the new categories by summing up all the tags that get put together
Horror<-MCTags$Horror+MCTags$Gore+MCTags$Thriller+MCTags$Zombies+MCTags$'Psychological Horror'+MCTags$'Survival Horror'
Coop<-MCTags$'Co-op'+MCTags$'Local Co-Op'+MCTags$'4 Player Local'+MCTags$'Online Co-Op'+MCTags$'Local Multiplayer'+MCTags$'Co-op Campaign'+MCTags$'Split Screen'
Competitive<-MCTags$'e-sports'+MCTags$'Competitive'
Racing<-MCTags$'Racing'+MCTags$'Driving'+MCTags$'Offroad'
War<-MCTags$'Military'+MCTags$'World War II'+MCTags$'War'+MCTags$'Wargame'+MCTags$'Cold War'+MCTags$'World War I'
Fantasy<-MCTags$'Fantasy'+MCTags$'Dark Fantasy'+MCTags$'Dragons'+MCTags$'Magic'+MCTags$'Werewolves'+MCTags$'Vampire'+MCTags$'Demons'
Sports<-MCTags$'Soccer'+MCTags$'Football'+MCTags$'Basketball'+MCTags$'Golf'+MCTags$'Mini Golf'+MCTags$'Sports'+MCTags$'Bowling'+MCTags$'Pool'
Strategy<-MCTags$'Strategy'+MCTags$'Turn-Based Strategy'+MCTags$'Turn-Based'+MCTags$'Grand Strategy'+MCTags$'RTS'+MCTags$'Turn-Based Tactics'+MCTags$'Real Time Tactics'+MCTags$'Turn-Based Combat'+MCTags$'Real-Time with Pause'+MCTags$'Real-Time'
Soundtrack<-MCTags$'Soundtrack'+MCTags$'Music'+MCTags$'Music-Based Procedural Generation'+MCTags$'Great Soundtrack'
Comedy<-MCTags$'Satire'+MCTags$'Dark Humor'+MCTags$'Dark Comedy'+MCTags$'Comedy'+MCTags$'Parody'+MCTags$'Funny'+MCTags$'Memes'
Software<-MCTags$'Software'+MCTags$'RPGMaker'+MCTags$'GameMaker'+MCTags$'Game Development'+MCTags$'Design & Illustration'+MCTags$'Video Production'+MCTags$'Photo Editing'+MCTags$'Audio Production'+MCTags$'Animation & Modeling'+MCTags$'Web Publishing'
Puzzle<-MCTags$'Puzzle'+MCTags$'Puzzle-Platformer'+MCTags$'Match 3'+MCTags$'Sokoban'+MCTags$'Hidden Object'+MCTags$'Word Game'
Scifi<-MCTags$'Sci-fi'+MCTags$'Aliens'+MCTags$'Cyberpunk'+MCTags$'Space'+MCTags$'Space Sim'+MCTags$'Mars'+MCTags$'Steampunk'+MCTags$'Post-apocalyptic'+MCTags$'Mechs'+MCTags$'Futuristic'
RPG<-MCTags$'RPG'+MCTags$'Tactical RPG'+MCTags$'Strategy RPG'+MCTags$'Party-Based RPG'
Story<-MCTags$'Story Rich'+MCTags$'Lore-Rich'
MMO<-MCTags$'Massively Multiplayer'+MCTags$'MMORPG'
Superheroes<-MCTags$'Superhero'+MCTags$'Batman'+MCTags$'Comic Book'
TopDownShooter<-MCTags$'Bullet Hell'+MCTags$'Top-Down Shooter'
ThirdPersonShooter<-MCTags$'Third-Person Shooter'+MCTags$'Third Person'
GamesWorkshop<-MCTags$'Games Workshop'+MCTags$'Warhammer 40K'
TimeTravel<-MCTags$'Time Travel'+MCTags$'Time Manipulation'
Mystery<-MCTags$'Mystery'+MCTags$'Detective'+MCTags$'Crime'
Crowdfunded<-MCTags$'Crowdfunded'+MCTags$'Kickstarter'
Casual<-MCTags$'Casual'+MCTags$'Family Friendly'
Political<-MCTags$'Political'+MCTags$'Politics'
Romance<-MCTags$'Dating Sim'+MCTags$'Romance'+MCTags$'Lovecraftian'
RogueLike<-MCTags$'Rogue-like'+MCTags$'Rogue-lite'
VisualNovel<-MCTags$'Visual Novel'+MCTags$'Interactive Fiction'+MCTags$'Based On A Novel'
Fps<-MCTags$'FPS'+MCTags$'First-Person'
Movie<-MCTags$'Documentary'+MCTags$'Movie'+MCTags$'Feature Film'+MCTags$'Cinematic'
Multiplayer<-MCTags$'Multiplayer'+MCTags$'PvP'
Dystopian<-MCTags$'Dark'+MCTags$'Dystopian'
Spelling<-MCTags$'Typing'+MCTags$'Spelling'
Naval<-MCTags$'Naval'+MCTags$'Sailing'
MartialArts<-MCTags$'Martial Arts'+MCTags$'Ninja'
Cartoony<-MCTags$'Cartoony'+MCTags$'Cartoon'
ActionAdventure<-MCTags$'Action-Adventure'+MCTags$'Parkour'+MCTags$'Lara Croft'

####################################################

#Deletes columns that have been used on the bigger categories
toremove<-c('Horror','Gore','Thriller','Zombies','Psychological Horror','Survival Horror','Co-op','Local Co-Op','4 Player Local','Online Co-Op','Local Multiplayer','Co-op Campaign','Split Screen','e-sports','Competitive','Racing','Driving','Offroad','Military','World War II','War','Wargame','Cold War','World War I','Fantasy','Dark Fantasy','Dragons','Magic','Werewolves','Vampire','Demons','Soccer','Football','Basketball','Golf','Mini Golf','Sports','Bowling','Pool','Strategy','Turn-Based Strategy','Turn-Based','Grand Strategy','RTS','Turn-Based Tactics','Real Time Tactics','Turn-Based Combat','Real-Time with Pause','Real-Time','Soundtrack','Music','Music-Based Procedural Generation','Great Soundtrack','Satire','Dark Humor','Dark Comedy','Comedy','Parody','Funny','Memes','Software','RPGMaker','GameMaker','Game Development','Design & Illustration','Video Production','Photo Editing','Audio Production','Animation & Modeling','Web Publishing','Puzzle','Puzzle-Platformer','Match 3','Sokoban','Hidden Object','Word Game','Sci-fi','Aliens','Cyberpunk','Space','Space Sim','Mars','Steampunk','Post-apocalyptic','Mechs','Futuristic','RPG','Tactical RPG','Strategy RPG','Party-Based RPG','Story Rich','Lore-Rich','Massively Multiplayer','MMORPG','Superhero','Batman','Comic Book','Bullet Hell','Top-Down Shooter','Third-Person Shooter','Third Person','Games Workshop','Warhammer 40K','Time Travel','Time Manipulation','Mystery','Detective','Crime','Crowdfunded','Kickstarter','Casual','Family Friendly','Political','Politics','Dating Sim','Romance','Lovecraftian','Rogue-like','Rogue-lite','Visual Novel','Interactive Fiction','Based On A Novel','FPS','First-Person','Documentary','Movie','Feature Film','Cinematic','Multiplayer','PvP','Dark','Dystopian ','Parody ','Typing','Spelling','Naval','Sailing','Martial Arts','Ninja','Cartoony','Cartoon','Action-Adventure','Parkour','Lara Croft')
MCNew<-MCTags[,!colnames(MCTags)%in%c(toremove)]

#Add the new categories as columns
MCCats<-MCNew
MCCats$Horror<-Horror
MCCats$Coop<-Coop
MCCats$Competitive<-Competitive
MCCats$Racing<-Racing
MCCats$War<-War
MCCats$Fantasy<-Fantasy
MCCats$Sports<-Sports
MCCats$Strategy<-Strategy
MCCats$Soundtrack<-Soundtrack
MCCats$Comedy<-Comedy
MCCats$Software<-Software
MCCats$Puzzle<-Puzzle
MCCats$Scifi<-Scifi
MCCats$RPG<-RPG
MCCats$Story<-Story
MCCats$MMO<-MMO
MCCats$Superheroes<-Superheroes
MCCats$TopDownShooter<-TopDownShooter
MCCats$ThirdPersonShooter<-ThirdPersonShooter
MCCats$GamesWorkshop<-GamesWorkshop
MCCats$TimeTravel<-TimeTravel
MCCats$Mystery<-Mystery
MCCats$Crowdfunded<-Crowdfunded
MCCats$Casual<-Casual
MCCats$Political<-Political
MCCats$Romance<-Romance
MCCats$RogueLike<-RogueLike
MCCats$VisualNovel<-VisualNovel
MCCats$Fps<-Fps
MCCats$Movie<-Movie
MCCats$Multiplayer<-Multiplayer
MCCats$Dystopian<-Dystopian
MCCats$Spelling<-Spelling
MCCats$Naval<-Naval
MCCats$MartialArts<-MartialArts
MCCats$Cartoony<-Cartoony
MCCats$ActionAdventure<-ActionAdventure


MCCatsSave<-MCCats

#Change values higher than 1 to equal 1 for the new categories.
for(i in 1:nrow(MCCats)){
  for(j in 4:ncol(MCCats)){
    if(MCCats[i,j]>1){
      MCCats[i,j]<-1
    }
  }
}
################################################################
#Removing variables with low number of observations.
mctest<-MCTags
delvec<-vector(mode="numeric", length=0)
j<-1

for(i in 4:ncol(mctest)){
  if (sum(mctest[,i])<20) {
    delvec[j]<-colnames(mctest)[i]
    j<-j+1
  }
}

mctest<-mctest[,!(colnames(mctest)%in%c(delvec))]

mccatsn<-MCCats
delvecc<-vector(mode="numeric", length=0)
k<-1

for(i in 4:ncol(mccatsn)){
  if (sum(mccatsn[,i])<20) {
    delvec[k]<-colnames(mccatsn)[i]
    k<-k+1
  }
}

mccatsn<-mccatsn[,!(colnames(mccatsn)%in%c(delvec))]


####################################################
#Create models for the data without categorization
predictors<-names(mctest)[names(mctest) != "mc"]
predictorst<-predictors[3:152]

set.seed(42)

inTrain<-createDataPartition(y=mctest$mc, p=0.75, list=FALSE)

str(inTrain)

training<-mctest[inTrain,]
testing<-mctest[-inTrain,]

#Multiple linear regression
m1<-lm(mc~.-appid-name,data=training)
s1<-step(m1,data=training,direction="backward")
p1<-predict(s1,newdata=testing)
p1<-round(p1,digits=0)
mse(testing$mc,p1)

#LASSO Regression
trainmat<-as.matrix(training[,4:153])
testmat<-as.matrix(testing[,4:153])
m2<-cv.glmnet(y=training[,3],x=trainmat,alpha=1,nfolds=100)
p2<-predict(m2,newy=testing$mc,newx=testmat,s=m2$lambda.min,type="response")
p2<-round(p2,digits=0)
mse(testing$mc,p2)
####################################################################
#Create models for the categorized data
cpredictors<-names(mccatsn)[names(mccatsn) != "mc"]
cpredictorst<-predictors[3:112]

cinTrain<-createDataPartition(y=mccatsn$mc, p=0.75, list=FALSE)

ctraining<-mccatsn[inTrain,]
ctesting<-mccatsn[-inTrain,]

#Multiple Linear Regression
m3<-lm(mc~.-appid-name,data=ctraining)
s3<-step(m3,data=ctraining,direction="backward")
p3<-predict(s3,newdata=ctesting)
p3<-round(p3,digits=0)
mse(testing$mc,p3)

#LASSO Regression
ctrainmat<-as.matrix(ctraining[,4:112])
ctestmat<-as.matrix(ctesting[,4:112])
m4<-cv.glmnet(y=ctraining[,3],x=ctrainmat,alpha=1,nfolds=100)
p4<-predict(m4,newy=ctesting$mc,newx=ctestmat,s=m4$lambda.min,type="response")
p4<-round(p4,digits=0)
mse(testing$mc,p4)

####################################################################
