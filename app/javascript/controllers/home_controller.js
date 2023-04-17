import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.textContent = "Hello World!"
  }

  clicked(e) {
    console.log('hello world to me')
  }
}
