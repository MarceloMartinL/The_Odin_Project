let myLibrary = [];
let tableParent = document.querySelector('.library tbody');
const submitBtn = document.querySelector('#submit-btn');
const addBtn = document.querySelector('#add-btn');

addBtn.addEventListener('click', function() {
	let bookForm = document.querySelector('.new-book');
	bookForm.classList.toggle('show');
})



submitBtn.addEventListener('click', libraryFlow);

// General flow to adding a new book
function libraryFlow() {
	addBookToLibrary();
	cleanTable();
	render();
	setDeleteButtons();
}

// Adds a new book to the library array
function addBookToLibrary() {
	let bookTitle = document.querySelector('#book-title').value;
	let bookAuthor = document.querySelector('#book-author').value;
	let bookPages = document.querySelector('#book-pages').value;
	let bookRead = document.querySelector('#book-read').value;
	let newBook = new createBook(bookTitle, bookAuthor, bookPages, bookRead);
	myLibrary.push(newBook)
}

// Creates a book object
function createBook(title, author, pagesNum, read) {
	this.title = title
	this.author = author
	this.pages = pagesNum
	this.read = read		
}

// Populates the library with default books
function populateLibrary() {
	myLibrary.push(new createBook('El nombre del viento', 'Patrick Rothfuss', 851, 'no'));
	myLibrary.push(new createBook('El alquimista', 'Paulo Cohelo', 301, 'yes'));
	myLibrary.push(new createBook('Padre rico padre pobre', 'Robert Kiyosaki', 440, 'yes'));
	myLibrary.push(new createBook('Retratos de innovadores', 'Paula Escobar', 203, 'yes'));
}

// Renders the books from myLibrary as a table row
function render() {
	myLibrary.forEach(function(book) {
		let tableRow = document.createElement('tr');
		let columnTitle = document.createElement('td');
		let columnAuthor = document.createElement('td');
		let columnPages = document.createElement('td');
		let columnRead = document.createElement('td');
		let columnDelete = document.createElement('td');
		let deleteBtn = document.createElement('button');

		deleteBtn.classList.add('delete-btn');
		columnRead.classList.add('read-status');
		
		columnTitle.textContent = book.title;
		columnAuthor.textContent = book.author;
		columnPages.textContent = book.pages;
		columnRead.textContent = book.read;
		deleteBtn.textContent = 'Delete';

		if(columnRead.textContent == 'yes') {
			columnRead.classList.add('read-yes');
		} else {
			columnRead.classList.add('read-no');
		}

		tableRow.setAttribute('index', `${myLibrary.indexOf(book)}`);
		tableRow.appendChild(columnTitle);
		tableRow.appendChild(columnAuthor);
		tableRow.appendChild(columnPages);
		tableRow.appendChild(columnRead);
		columnDelete.appendChild(deleteBtn);
		tableRow.appendChild(columnDelete);
		tableParent.appendChild(tableRow);
	})
}

// Removes all childs from the table element
function cleanTable() {
	while(tableParent.firstElementChild) {
		tableParent.removeChild(tableParent.firstElementChild);
	}
}

// Adds an eventListener to delete buttons
function setDeleteButtons() {
	deleteBtn = document.querySelectorAll('.delete-btn');

	deleteBtn.forEach(button => button.addEventListener('click', function() {
		let buttonRow = button.parentElement.parentElement;
		let bookIndex = buttonRow.getAttribute('index');
		
		myLibrary.splice(bookIndex, 1);
		buttonRow.outerHTML = "";
		
	}));
}

// Toggle the read state of the books
function setReadToggle() {
	let readStatus = document.querySelectorAll('.read-status');
	readStatus.forEach(status => status.addEventListener('click', function() {
		if(status.textContent == 'yes') {
			status.textContent = 'no';
			status.classList.remove('read-yes');
			status.classList.add('read-no');
		} else {
			status.textContent = 'yes';
			status.classList.remove('read-no');
			status.classList.add('read-yes');
		}
	}));
}

// Calls the functions to set buttons propertys
function setButtons() {
	setDeleteButtons();
	setReadToggle();
}

populateLibrary();
render();
setButtons();



