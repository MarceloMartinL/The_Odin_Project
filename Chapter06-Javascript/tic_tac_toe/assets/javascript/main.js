let gameBoard = {
	gameTable: ["", "", "", "", "", "", "", "", ""]
}

const Player = (name, mark) => {
	let wins = 0;
	return {name, mark, wins}
};