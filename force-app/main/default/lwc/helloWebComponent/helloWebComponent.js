import { LightningElement } from 'lwc';

export default class HelloWebComponent extends LightningElement {
  capitalizedGreeting = 'World';
  handleGreetingChange(event) {
    this.capitalizedGreeting = event.target.value;
  }
  currentDate = new Date().toDateString();
  
  get capitalizedGreeting() {
	return `Hello ${this.capitalizedGreeting.toUpperCase()}!`;
}
}