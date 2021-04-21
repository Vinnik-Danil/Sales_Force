import { LightningElement } from 'lwc';

export default class Numerator extends LightningElement {
    counter = 0;
    handleIncrement() {
      this.counter++;
    }
    handleDecrement() {
      this.counter--;
    }
    handleAdd() {
        this.dispatchEvent(new CustomEvent('add'));
    }
    handleSubtract() {
        this.dispatchEvent(new CustomEvent('subtract'));
    }
    handleMultiply(event) {
        const factor = event.target.dataset.factor;
        this.dispatchEvent(new CustomEvent('multiply', {
          detail: factor
        }));
      }
}