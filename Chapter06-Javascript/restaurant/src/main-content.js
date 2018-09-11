function mainContent() {
	let content = document.querySelector('.content');
	let header = document.createElement('h1');
	let text = document.createElement('p');

	header.textContent = 'Welcome to Delicious Kingdom';
	text.textContent = "This is the best restaurant with the best food of the world!";

	content.appendChild(header)
	content.appendChild(text)
}

export { mainContent }