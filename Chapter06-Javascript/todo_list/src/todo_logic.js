const userProjects = [{title: 'Default Project', tasks: [{ title: 'Watch StarWars: Han Solo Movie', priority: 'Normal', dueDate: '10-8-2018', description: 'I love starwars movies so i really need to watch this one!'}]}];

const createProject = (title) => {
  const tasks = [];
  return {title, tasks};
};

const createTask = (title, priority, dueDate, description) => {
  return { title, priority, dueDate, description };
};

function addTask(project, task) {
  project.tasks.push(task);
}

function deleteTask(project, taskIndex) {
  project.tasks.splice(taskIndex, 1);
}

export { createTask, createProject, userProjects, addTask, deleteTask }