package model

type User struct {
	UserID    int    `json:"id"`
	UserName  string `json:"name"`
	UserScore int    `json:"score"`
}

//CREATE TABLE Users(
//UserID INT NOT NULL AUTO_INCREMENT,
//UserName VARCHAR(100) NOT NULL,
//UserScore INT,
//PRIMARY KEY (UserID));
//
//CREATE TABLE Challenges (
//ChallengeID INT NOT NULL AUTO_INCREMENT,
//ChallengeTitle VARCHAR(100) NOT NULL,
//ChallengeDescription VARCHAR(100) NOT NULL,
//ChallengeCategory VARCHAR(100) NOT NULL,
//ChallengePoints INT NOT NULL,
//PRIMARY KEY (ChallengeID));
//
//CREATE TABLE UserChallenge (
//UC_Id INT NOT NULL AUTO_INCREMENT,
//User INT NOT NULL,
//Challenge VARCHAR(100) NOT NULL,
//PRIMARY KEY(UC_Id)
//FOREIGN KEY (User) REFERENCES person (UserID),
//FOREIGN KEY (Challenge) REFERENCES fruit (ChallengeID)
//);

//--------------------------------------------
//CREATE TABLE person (
//  person_id   INT           NOT NULL AUTO_INCREMENT,
//  person_name VARCHAR(1000) NOT NULL,
//  PRIMARY KEY (person_id)
//);
//
//CREATE TABLE fruit (
//  fruit_id    INT           NOT NULL AUTO_INCREMENT,
//  fruit_name  VARCHAR(1000) NOT NULL,
//  fruit_color VARCHAR(1000) NOT NULL,
//  fruit_price INT           NOT NULL,
//  PRIMARY KEY (fruit_id)
//);
//
//CREATE TABLE person_fruit (
//  pf_id     INT NOT NULL AUTO_INCREMENT,
//  pf_person INT NOT NULL,
//  pf_fruit  INT NOT NULL,
//  PRIMARY KEY (pf_id),
//  FOREIGN KEY (pf_person) REFERENCES person (person_id),
//  FOREIGN KEY (pf_fruit) REFERENCES fruit (fruit_id)
//);
//
//INSERT INTO person (person_name)
//VALUES
//  ('John'),
//  ('Mary'),
//  ('John'); -- again
//
//INSERT INTO fruit (fruit_name, fruit_color, fruit_price)
//VALUES
//  ('apple', 'red', 1),
//  ('orange', 'orange', 2),
//  ('pineapple', 'yellow', 3);
//
//INSERT INTO person_fruit (pf_person, pf_fruit)
//VALUES
//  (1, 1),
//  (1, 2),
//  (2, 2),
//  (2, 3),
//  (3, 1),
//  (3, 2),
//  (3, 3);
