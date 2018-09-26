import * as todoDisplay from './todo_display';
import * as todoLogic from './todo_logic';

const createProjectBtn = document.querySelector('#create-project-btn');
const createTaskBtn = document.querySelector('#create-task-btn');
const addTaskBtn = document.querySelector('#add-task-btn');


addTaskBtn.addEventListener('click', (e) => {
  if (todoDisplay.activeProject === '') {
    e.stopPropagation();
    return alert('Please select a project');
  }
});

createProjectBtn.addEventListener('click', () => {
  let projectTitle = document.querySelector('#project-title').value;
  let project = todoLogic.createProject(projectTitle);

  todoLogic.userProjects.push(project);
  todoDisplay.renderProjects(todoLogic.userProjects);
  setProjectListEvent();
});

createTaskBtn.addEventListener('click', () => {
  const taskTitle = document.querySelector('#task-title').value;
  const taskPriority = document.querySelector('#task-priority').value;
  const taskDueDate = document.querySelector('#task-due-date').value;
  const taskDescription = document.querySelector('#task-description').value;
  const task = todoLogic.createTask(taskTitle, taskPriority, taskDueDate, taskDescription);

  todoLogic.addTask(todoDisplay.activeProject, task);
  todoDisplay.renderProjectTasks(todoDisplay.activeProject);
  setCompletedBtnEvent();
  setDeleteBtnEvent();
});

function setProjectListEvent() {
  const projectList = document.querySelectorAll('.project-list li');
  projectList.forEach((item) => {
    const projectIndex = item.getAttribute('index');
    const project = todoLogic.userProjects[projectIndex];
    item.addEventListener('click', (e) => {
      let listItem = e.target;
      todoDisplay.setActiveProject(project, listItem);
      todoDisplay.renderProjectTasks(project);
      setDeleteBtnEvent();
    });
  });
}

function setDeleteBtnEvent() {
  const deleteBtnList = document.querySelectorAll('.delete-btn');
  const project = todoDisplay.activeProject;
  deleteBtnList.forEach((button) => {
    const listItem = button.parentElement;
    const taskIndex = listItem.getAttribute('task-index');
    button.addEventListener('click', () => {
      todoLogic.deleteTask(project, taskIndex);
      todoDisplay.renderProjectTasks(project);
      setCompletedBtnEvent();
    });
  });
}

function setCompletedBtnEvent() {
  const completedBtnList = document.querySelectorAll('.completed-btn');
  completedBtnList.forEach((button) => {
    const cardElement = button.parentElement.firstChild.firstChild;
    button.addEventListener('click', () => {
      todoDisplay.toggleCompletedTask(cardElement, button)
    });
  });
}

todoDisplay.renderProjects(todoLogic.userProjects);
todoDisplay.setActiveProject(todoLogic.userProjects[0])
todoDisplay.renderProjectTasks(todoLogic.userProjects[0])
setProjectListEvent();
setCompletedBtnEvent();
setDeleteBtnEvent();