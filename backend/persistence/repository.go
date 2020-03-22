package persistence

import (
	"database/sql"
	"fmt"
	"main/common"
	"main/model"
	"time"

	// We need the mysql databse driver
	_ "github.com/go-sql-driver/mysql"
)

func connectToMySQL() (*sql.DB, error) {
	dataSourceName := common.LoadEnv("DB_CONNECTION_STRING")

	// Insert secret connection string
	return sql.Open("mysql", dataSourceName)
}

// CreateChallenge inserts a new challenge into the database
func CreateChallenge(challenge model.Challenge) (string, error) {
	db, err := connectToMySQL()
	defer db.Close()
	if err != nil {
		panic(err)
	}

	stmtIns, err := db.Prepare("INSERT INTO Challenges (ChallengeID, ChallengeTitle, ChallengeDescription, ChallengeCategory, ChallengePoints) VALUES(?, ?,?,?,?)")
	if err != nil {
		return "Failure", err
	}
	_, err = stmtIns.Exec(challenge.ChallengeID, challenge.ChallengeTitle, challenge.ChallengeDescription, challenge.ChallengeCategory, challenge.ChallengePoints)
	if err != nil {
		return "Failure", err
	}
	return "Success", nil
}

// GetChallenges loads all challenges from the database and returns them
func GetChallenges() []model.Challenge {
	db, err := connectToMySQL()
	if err != nil {
		panic(err)
	}

	rows, err := db.Query("SELECT * FROM Challenges")
	if err != nil {
		panic(err)
	}
	defer rows.Close()

	var response []model.Challenge
	for rows.Next() {
		var id, points int
		var title, description, category string
		err = rows.Scan(&id, &title, &description, &category, &points)

		response = append(response, model.Challenge{ChallengeID: id, ChallengeTitle: title, ChallengeDescription: description, ChallengeCategory: category, ChallengePoints: points})
	}
	return response
}

func CreateUser(user model.User) (string, error) {
	db, err := connectToMySQL()
	defer db.Close()
	if err != nil {
		panic(err)
	}

	stmtIns, err := db.Prepare("INSERT INTO Users (UserID, UserName, UserScore, DayOne) VALUES(?, ?, ?, ?)")
	if err != nil {
		return "Failure", err
	}

	t := time.Now()
	fmt.Println(t.String())
	fmt.Println(t.Format("2006-01-02 15:04:05"))

	_, err = stmtIns.Exec(user.UserID, user.UserName, user.UserScore, t)
	if err != nil {
		return "Failure", err
	}
	return "Success", nil
}

func UpdateUser(userupdate model.UserUpdate) (string, error) {
	db, err := connectToMySQL()
	defer db.Close()
	if err != nil {
		panic(err)
	}

	//Update Score in User
	stmtIns, err := db.Prepare("UPDATE Users SET UserScore=UserScore+? WHERE UserID=?")
	if err != nil {
		return "Failure", err
	}
	_, err = stmtIns.Exec(userupdate.Points, userupdate.UserID)
	if err != nil {
		return "Failure", err
	}

	//Insert done challenge in User-Challenge Table
	stmtIns2, err := db.Prepare("INSERT INTO UserChallenge (UC_User, UC_Challenge) VALUES(?,?)")
	if err != nil {
		return "Failure", err
	}
	_, err = stmtIns2.Exec(userupdate.UserID, userupdate.ChallengeID)
	if err != nil {
		return "Failure", err
	}

	return "Success", nil
}

func GetUser(id string) model.User {
	var user model.User

	db, err := connectToMySQL()
	if err != nil {
		panic(err)
	}
	rows, err := db.Query("SELECT * FROM Users WHERE UserID=?", id)
	if err != nil {
		panic(err)
	}
	defer rows.Close()

	for rows.Next() {
		var (
			userID, UserName, DayOne string
			UserScore                int
		)
		err = rows.Scan(&userID, &UserName, &UserScore, &DayOne)

		user = model.User{
			UserID:    userID,
			UserName:  UserName,
			UserScore: UserScore,
			DayOne:    DayOne,
		}
	}

	return user
}

func GetRanking() model.Ranking {
	var ranking model.Ranking

	db, err := connectToMySQL()
	if err != nil {
		panic(err)
	}
	rows, err := db.Query("SELECT UserName, UserScore FROM Users")
	if err != nil {
		panic(err)
	}
	defer rows.Close()

	for rows.Next() {
		var (
			score int
			name  string
		)
		err = rows.Scan(&name, &score)
		ranking.UserRankList = append(ranking.UserRankList, model.UserRank{
			Name:  name,
			Score: score,
		})
	}
	return ranking
}
