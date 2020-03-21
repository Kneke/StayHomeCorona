package model

type User struct {
	UserID    int    `json:"id"`
	UserName  string `json:"name"`
	UserScore int    `json:"score"`
}

//DROP TABLE IF EXISTS Challenges

//CREATE TABLE Users(
//UserID INT NOT NULL AUTO_INCREMENT,
//UserName VARCHAR(100) NOT NULL,
//UserScore INT,
//PRIMARY KEY (UserID));

//CREATE TABLE Challenges (
//ChallengeID INT NOT NULL AUTO_INCREMENT,
//ChallengeTitle VARCHAR(100) NOT NULL,
//ChallengeDescription VARCHAR(100) NOT NULL,
//ChallengeCategory VARCHAR(100) NOT NULL,
//ChallengePoints INT NOT NULL,
//PRIMARY KEY (ChallengeID));

//CREATE TABLE UserChallenge (
//UC_Id INT NOT NULL AUTO_INCREMENT,
//UC_User INT NOT NULL,
//UC_Challenge INT NOT NULL,
//PRIMARY KEY(UC_Id),
//FOREIGN KEY (UC_User) REFERENCES Users (UserID),
//FOREIGN KEY (UC_Challenge) REFERENCES Challenges (ChallengeID)
//);
