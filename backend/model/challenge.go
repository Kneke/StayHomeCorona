package model

// Challenge is grouped in categories
type Challenge struct {
	ChallengeID          int    `json:"id"`
	ChallengeTitle       string `json:"title"`
	ChallengeDescription string `json:"description"`
	ChallengeCategory    string `json:"category"`
	ChallengePoints      int    `json:"points"`
}
