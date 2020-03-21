package model
	
// Challenge is grouped in categories
type Challenge struct {
	ID 			int
	Title 		string
	Description string
	Category  Category
	Points 		int
}