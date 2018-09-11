import { mainContent } from './main-content';
import { menuContent } from './menu-content';
import { contactContent } from './contact-content';

const header = document.querySelector('.main-header');
const content = document.querySelector('.content')
const tabMain = document.querySelector('#tab-main');
const tabMenu = document.querySelector('#tab-menu');
const tabContact = document.querySelector('#tab-contact');


function setBanner() {
	let image = document.createElement('img');
	image.setAttribute('src', './images/foodbanner.jpg')
	header.appendChild(image)
}

function clean() {
	while(content.firstElementChild) {
		content.removeChild(content.firstElementChild);
	}
}

tabMain.addEventListener('click', function () {
	clean();
	mainContent(); 
});

tabMenu.addEventListener('click', function () {
	clean();
	menuContent(); 
});

tabContact.addEventListener('click', function () {
	clean();
	contactContent(); 
});

setBanner();
mainContent();

