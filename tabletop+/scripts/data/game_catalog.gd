class_name GameCatalog
extends RefCounted

const GAMES: Array[Dictionary] = [
	{
		"title": "Yahtzee",
		"description": "Track dice rounds, totals, and your best runs in a clean game profile.",
		"symbol": "D6",
		"color": Color(0.188235, 0.270588, 0.521569, 1.0),
	},
	{
		"title": "Uno",
		"description": "A fast party-game profile with room for scorekeeping and house rules.",
		"symbol": "UNO",
		"color": Color(0.74902, 0.168627, 0.203922, 1.0),
	},
	{
		"title": "Monopoly",
		"description": "Keep the session organized with scores, notes, and custom rule sets.",
		"symbol": "$",
		"color": Color(0.133333, 0.541176, 0.32549, 1.0),
	},
	{
		"title": "Catan",
		"description": "A board-game profile built for long sessions and flexible rules.",
		"symbol": "HEX",
		"color": Color(0.662745, 0.470588, 0.219608, 1.0),
	},
	{
		"title": "Scrabble",
		"description": "Track words, scores, and custom challenges between turns.",
		"symbol": "AZ",
		"color": Color(0.380392, 0.270588, 0.603922, 1.0),
	},
	{
		"title": "Party Pack",
		"description": "A flexible profile for rotating party games and quick challenges.",
		"symbol": "+",
		"color": Color(0.219608, 0.643137, 0.780392, 1.0),
	},
]

const MODULES: Dictionary = {
	"rules": {
		"title": "Game Rules",
		"description": "A dedicated screen for official rules, setup notes, and quick references.",
	},
	"scoreboard": {
		"title": "Scoreboard",
		"description": "A future scorekeeping screen for rounds, totals, and player tracking.",
	},
	"remix": {
		"title": "Remix",
		"description": "A house-rules and modifier screen for custom scoring and fresh twists.",
	},
}
