import _ from 'lodash';
import myName from './myName';

function component() {
  let element = document.createElement('div');

  element.innerHTML = myName('Marcelo');

  return element;
}

document.body.appendChild(component());
