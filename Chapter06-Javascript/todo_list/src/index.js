import * as todoDisplay from './todo_display'
import * as todoLogic from './todo_logic'

const createProjectBtn = document.querySelector('#create-project-btn');
const createTaskBtn = document.querySelector('#create-task-btn');
const addTaskBtn = document.querySelector('#add-task-btn');


addTaskBtn.addEventListener('click', function(e) {
	if(todoDisplay.activeProject === "") {
		e.stopPropagation();
		return alert("Please select a project");
	}
})

createProjectBtn.addEventListener('click', function() {
	let projectTitle = document.querySelector('#project-title').value;
	let project = todoLogic.createProject(projectTitle);

	todoLogic.userProjects.push(project)
	todoDisplay.renderProjects(todoLogic.userProjects)
	setProjectListEvent();
})

createTaskBtn.addEventListener('click', function() {
	let taskTitle = document.querySelector('#task-title').value;
	let taskPriority = document.querySelector('#task-priority').value;
	let taskDueDate = document.querySelector('#task-due-date').value;
	let taskDescription = document.querySelector('#task-description').value;
	let task = todoLogic.createTask(taskTitle, taskPriority, taskDueDate, taskDescription);

	todoLogic.addTask(todoDisplay.activeProject, task)
	todoDisplay.renderProjectTasks(todoDisplay.activeProject)
	setDeleteBtnEvent();

})

function setProjectListEvent() {
	let projectList = document.querySelectorAll('.project-list li');
	projectList.forEach(item => {
		let projectIndex = item.getAttribute('index');
		let project = todoLogic.userProjects[projectIndex];
		item.addEventListener('click', function(e) {
			let listItem = e.target
			todoDisplay.setActiveProject(project, listItem)
			todoDisplay.renderProjectTasks(project)
			setDeleteBtnEvent();
		})
	})
}

function setDeleteBtnEvent() {
	let deleteBtnList = document.querySelectorAll('.delete-btn');
	let project = todoDisplay.activeProject;
	deleteBtnList.forEach(button => {
		let listItem = button.parentElement;
		let taskIndex = listItem.getAttribute('task-index');
		button.addEventListener('click', function() {
			todoLogic.deleteTask(project, taskIndex);
			todoDisplay.renderProjectTasks(project);
		})
	})
}

function setCompletedBtnEvent() {
	let completedBtnList = document.querySelectorAll('.completed-btn');
	completedBtnList.forEach(button => {
		let cardElement = button.parentElement.firstChild.firstChild;
		button.addEventListener('click', function() {
			console.log("lololo")
			todoDisplay.toggleCompletedTask(cardElement, button)
		})
	})
}


console.log(todoLogic.userProjects[0])
todoDisplay.renderProjects(todoLogic.userProjects);
todoDisplay.setActiveProject(todoLogic.userProjects[0])
todoDisplay.renderProjectTasks(todoLogic.userProjects[0])
setProjectListEvent();
setCompletedBtnEvent();
setDeleteBtnEvent();





