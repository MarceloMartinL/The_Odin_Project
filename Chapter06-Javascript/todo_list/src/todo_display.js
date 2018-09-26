const projectList = document.querySelector('.project-list');
const taskList = document.querySelector('.task-list');
let activeProject = ""

function renderProjects(arr) {
	clearProjects();
	arr.forEach(project => {
		let listItem = document.createElement('li');
		listItem.textContent = project.title;
		listItem.setAttribute('index', `${arr.indexOf(project)}`)
		projectList.appendChild(listItem)
	})
}

function clearProjects() {
	while(projectList.firstChild) {
		projectList.removeChild(projectList.firstChild)
	}
}

function clearTasks() {
	while(taskList.firstChild) {
		taskList.removeChild(taskList.firstChild)
	}
}

function setActiveProject(project, listItem = null) {
	let projectList = document.querySelectorAll('.project-list li');
	if(activeProject === "") {
		let arrayList = Array.from(projectList);
		listItem = arrayList[0];
		listItem.classList.toggle('active-project')
		activeProject = project
	} else {
		projectList.forEach(item => {
			item.classList.remove('active-project')
		})

		listItem.classList.toggle('active-project')
		activeProject = project;
		console.log(activeProject)
	}
}

function setProjectListEvent(userProjects) {
	let projectList = document.querySelectorAll('.project-list li');
	projectList.forEach(item => {
		let projectIndex = item.getAttribute('index');
		let project = userProjects[projectIndex];
		item.addEventListener('click', setActiveProject.bind(null, project))
	})
}

function toggleCompletedTask(cardElement, button) {
	cardElement.classList.toggle('completed-task')

	let classes = cardElement.getAttribute('class');
	let classesArr = classes.split(" ");
	let checkCompleted = classesArr.some(string => string == "completed-task");

	if(checkCompleted) {
		let checkIcon = button.firstChild;
		let xIcon = document.createElement('i');

		checkIcon.setAttribute('style', 'display: none')
		xIcon.classList.add('fas')
		xIcon.classList.add('fa-times')
		button.classList.add('uncomplete-task-btn')
		button.appendChild(xIcon)
	}	else {
		button.firstChild.setAttribute('style', 'display: block')
		button.lastChild.setAttribute('style', 'display: none')
		button.classList.toggle('uncomplete-task-btn')
	}	
}

function toggleCompleteBtn(cardElement, button) {
	let classes = cardElement.getAttribute('class');
	let classesArr = classes.split(" ");
	let checkCompleted = classesArr.some(string => string == "completed-task");
}

function renderProjectTasks(project) {
	clearTasks();
	project.tasks.forEach(task => {
		let listItem = document.createElement('li');
		let wrapperLink = document.createElement('a');
		let todoCardDiv = document.createElement('div');
		let todoCardHeaderDiv = document.createElement('div');
		let todoCardInfoDiv = document.createElement('div');
		let dueDate = document.createElement('date');
		let priority = document.createElement('p');
		let completedBtn = document.createElement('button');
		let deleteBtn = document.createElement('button');
		let ticketIcon = document.createElement('i');
		let trashIcon = document.createElement('i');
		let collapseDiv = document.createElement('div');
		let descriptionPhrase = document.createElement('p')
		let titleFirstWord = task.title.match(/\w+/);
		let taskIndex = project.tasks.indexOf(task);

		priority.textContent = `Priority: ${task.priority}`;
		dueDate.textContent = `Due Date: ${task.dueDate}`;
		todoCardHeaderDiv.textContent = task.title;
		descriptionPhrase.textContent = task.description;

		todoCardDiv.classList.add('todo-card')
		todoCardHeaderDiv.classList.add('todo-card-header')
		todoCardInfoDiv.classList.add('todo-card-info')
		todoCardInfoDiv.classList.add('d-flex')
		completedBtn.setAttribute('type', 'button')
		deleteBtn.setAttribute('type', 'button')
		completedBtn.classList.add('btn')
		completedBtn.classList.add('btn-success')
		completedBtn.classList.add('completed-btn')
		deleteBtn.classList.add('btn')
		deleteBtn.classList.add('btn-danger')
		deleteBtn.classList.add('delete-btn')
		ticketIcon.classList.add('fas')
		ticketIcon.classList.add('fa-check')
		trashIcon.classList.add('fas')
		trashIcon.classList.add('fa-trash-alt')
		collapseDiv.classList.add('collapse')
		collapseDiv.classList.add('todo-card-description')
		collapseDiv.setAttribute('id', `${titleFirstWord}-${taskIndex}`)
		wrapperLink.setAttribute('data-toggle', 'collapse')
		wrapperLink.setAttribute('href', `#${titleFirstWord}-${taskIndex}`)
		wrapperLink.setAttribute('role', 'button')
		listItem.setAttribute('task-index', taskIndex)

		switch (task.priority) {
			case "Normal":
				priority.classList.add('normal-priority');
				break;
			case "High":
				priority.classList.add('high-priority');
				break;
			case "Low":
				priority.classList.add('low-priority');
				break;
		}

		todoCardInfoDiv.appendChild(dueDate)
		todoCardInfoDiv.appendChild(priority)
		todoCardDiv.appendChild(todoCardHeaderDiv)
		todoCardDiv.appendChild(todoCardInfoDiv)
		wrapperLink.appendChild(todoCardDiv)
		completedBtn.appendChild(ticketIcon)
		deleteBtn.appendChild(trashIcon)
		listItem.appendChild(wrapperLink)
		listItem.appendChild(completedBtn)
		listItem.appendChild(deleteBtn)
		collapseDiv.appendChild(descriptionPhrase)
		listItem.appendChild(collapseDiv)
		taskList.appendChild(listItem)
	})	
}

export {renderProjects, activeProject, setActiveProject, renderProjectTasks, toggleCompletedTask}