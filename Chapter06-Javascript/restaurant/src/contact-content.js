function contactContent() {
	let content = document.querySelector('.content');
	let header = document.createElement('h1');
	let adress = document.createElement('p');
	let phone = document.createElement('p');

	header.textContent = 'Contact';
	adress.textContent = "San City 3342, NY";
	phone.textContent = '9-8888888';

	content.appendChild(header)
	content.appendChild(adress)
	content.appendChild(phone)
}

export { contactContent }