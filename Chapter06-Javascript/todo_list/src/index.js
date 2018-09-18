import * as todoLogic from './todo_logic'

const createProjectBtn = document.querySelector('#create-project-btn');

createProjectBtn.addEventListener('click', function() {
	let projectTitle = document.querySelector('#project-title').value;

	alert(projectTitle)
})