
// Player creation factory
const player = (name, mark) => {
	let wins = 0;
	const getName = () => name;
	const getMark = () => mark;
	const getWins = () => wins;
	return {getName, getMark, getWins}
};

const player1 = player('Player 1', 'X');
const player2 = player('Player 2', 'O');

// Game logic
const gameFlow = (() => {
	let activePlayer = player1;
	const winPatterns = [[0, 1, 2],[3, 4, 5],[6, 7, 8], // horizontal
											[0, 3, 6],[1, 4, 7],[2, 5, 8],  // vertical
											[2, 4, 6],[0, 4, 8]];           // diagonal

	const getActivePlayer = () => activePlayer;									

	const gameWon = () => {
		return winPatterns.some( pattern => {
			
			if(gameBoard.table[pattern[0]] !== "" && (gameBoard.table[pattern[0]] === gameBoard.table[pattern[1]] && gameBoard.table[pattern[1]] === gameBoard.table[pattern[2]] )) {
				console.log('lalalala');
				return true
			}
		})
	};

	const gameDraw = () => {
		return gameBoard.table.every(square => square !== "")
	};

	const _checkGameOver = () => {
		if(gameWon()) {
			gameBoard.gameOver(`${activePlayer.getName().toUpperCase()} WON THE GAME!`)
		} else if(gameDraw()) {
			gameBoard.gameOver('IT\'S A DRAW!')
		}
	};

	const _changePlayer = () => { 
		activePlayer = activePlayer === player1 ? player2 : player1;
		gameBoard.setActivePlayer();
	};

	const play = (square) => { 
		if(square.textContent == "") {
			square.textContent = activePlayer.getMark();
			gameBoard.updateBoard(square);
			_checkGameOver();
			_changePlayer();
		}
	}; 

	return {play, getActivePlayer}
})();

// Board representation
const gameBoard = (() => {
	const table = ["", "", "", "", "", "", "", "", ""];
	const allSquares = document.querySelectorAll('td');
	const resetButton = document.querySelectorAll('.reset-btn');
	const overlayResetButton = document.querySelector('#overlay-reset-btn');
	const gameOverlay = document.querySelector('.game-overlay');


	const setActivePlayer = () => {
		playerHeader = document.querySelector('#active-player');
		playerHeader.textContent = `Playing: ${gameFlow.getActivePlayer().getName()}`;
	};

	const _setListeners = () => {
		allSquares.forEach( square => { 
			square.addEventListener('click', gameFlow.play.bind(null, square))
		})

		resetButton.forEach(button => button.addEventListener('click', resetBoard));
		overlayResetButton.addEventListener('click', function() {
			gameOverlay.classList.toggle('show')
		})
	};

	const _render = () => {
		for(let i = 0; i < 9; i++) {
			let tableSquare = document.querySelector(`[index="${i}"]`);
			tableSquare.textContent = gameBoard.table[i];
		}	
	};

	const resetBoard = () => {
		table.forEach( (value, index) => table[index] = "")
		_render();
	};

	const updateBoard = (square) => {
		let squareIndex = square.getAttribute('index');
		table[squareIndex] = gameFlow.getActivePlayer().getMark();
	};

	const gameOver = (text) => {
		gameOverHeader = document.querySelector('#game-over');
		gameOverlay.classList.add('show')
		gameOverHeader.textContent = text;
	};

	const setBoard = () => {
		_setListeners();
		setActivePlayer();
		_render();
	};

	return {table, setBoard, gameOver, updateBoard, setActivePlayer}
})();



gameBoard.setBoard();