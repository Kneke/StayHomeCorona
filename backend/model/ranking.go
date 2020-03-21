package model

type Ranking struct {
	UserRankList []UserRank
}

type UserRank struct {
	Name string
	Score int
}