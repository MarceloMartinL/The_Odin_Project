const createTask = (title, description, dueDate, priority) => {
	return {title, description, dueDate, priority}
}

const createProject = (title) => {
	let tasks = []
	return {title}
}

export {createTask, createProject}