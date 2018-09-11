function menuContent() {
	let content = document.querySelector('.content');
	let header = document.createElement('h1');
	let text = document.createElement('p');

	header.textContent = 'The Special Menu';
	text.textContent = "A big hamburger of course! \n with some nuggets, french fries and a cold beer!";

	content.appendChild(header)
	content.appendChild(text)
}

export { menuContent }