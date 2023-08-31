extends Node
var score: int = 0
var dialoguing: bool = false
var dialogs: Array = [
	{
		"context": [
			{
				"speaker": "Pinky p.",
				"text": "I have to eliminate all enemies in my way, time to roast some greeeeeeeeennnnn PIGOU.."
			},
			{
				"speaker": "Pinky p.",
				"text": "All I have to do is JUMPING on those greeny pigs, yay."
			},
			{
				"speaker": "Pinky p.",
				"text": "Press D to move right and Q or A to move left.  SPACE to Jump."
			}
		]
	},
	
	{
		"context": [
			{
				"speaker": "Pinky p.",
				"text": "What is this....."
			},
			{
				"speaker": "Pinky p.",
				"text": "Greenn Porrtaallll"
			},
			{
				"speaker": "Pinky p.",
				"text": "May be this will teleport me to their BOSS!"
			},
			{
				"speaker": "Pinky p.",
				"text": "I do not know, it is worth a try."
			},
			{
				"speaker": "Pinky p.",
				"text": "Let's GOOOOOOOOOOOO!"
			},
			{
				"speaker": "Pinky p.",
				"text": "end_level_1_teleport_to_boss"
			}
		]
	},
	{
		"context": [
			{
				"speaker": "Pinky pig",
				"text": "WOww!..."
			},
			{
				"speaker": "Pinky pig",
				"text": "So this is the Boss level?"
			},
			{
				"speaker": "Pinky pig",
				"text": "Kinda Good, hehehehe..."
			},
			{
				"speaker": "Pinky pig",
				"text": "A big fiesta is comming, but it is better to sly those Infected PIGS"
			},
			{
				"speaker": "Pinky pig",
				"text": "Wait aminute! So i have to kill the boss to stop green pig spawning!"
			},
			{
				"speaker": "Pinky pig",
				"text": "that is so hard dude, but it is okay. LET's TRYYYY IT OUT"
			}
		]
	},
	{
		"context": [
			{
				"speaker": "Pinky pig",
				"text": "OOUUUUUUUUFFFFFFFFFF"
			},
			{
				"speaker": "Pinky pig",
				"text": "Finally done! I am da BEST."
			},
			{
				"speaker": "Pinky pig",
				"text": "end_boss"
			},
		]
	}
]
