package model

type User struct {
	UserID    string `json:"id"`
	UserName  string `json:"name"`
	UserScore int    `json:"score"`
	DayOne    string `json:"dayone"`
}
// User Body
{
"id": "33edassa65615ad",
"name": "hannes",
"score": 25,
"dayone": ""
}

type UserUpdate struct {
	UserID      string `json:"userid"`
	ChallengeID int    `json:"challengeid"`
	Points      int    `json:"points"`
}
// UserUpdate Body
//{
//"userid": "33edassa65615ad",
//"challengeid": 1,
//"points": 25
//}

//SQL Statements:

//DROP TABLE IF EXISTS UserChallenge
//DROP TABLE IF EXISTS Users
//DROP TABLE IF EXISTS Challenges

//CREATE TABLE Users(
//UserID VARCHAR(100) NOT NULL,
//UserName VARCHAR(100) NOT NULL,
//UserScore INT,
//DayOne VARCHAR(100) NOT NULL,
//PRIMARY KEY (UserID));
//
//CREATE TABLE Challenges (
//ChallengeID INT NOT NULL AUTO_INCREMENT,
//ChallengeTitle VARCHAR(100) NOT NULL,
//ChallengeDescription VARCHAR(1000) NOT NULL,
//ChallengeCategory VARCHAR(100) NOT NULL,
//ChallengePoints INT NOT NULL,
//PRIMARY KEY (ChallengeID));
//
//CREATE TABLE UserChallenge (
//UC_Id INT NOT NULL AUTO_INCREMENT,
//UC_User VARCHAR(100) NOT NULL,
//UC_Challenge INT NOT NULL,
//PRIMARY KEY(UC_Id),
//FOREIGN KEY (UC_User) REFERENCES Users (UserID),
//FOREIGN KEY (UC_Challenge) REFERENCES Challenges (ChallengeID)
//);
