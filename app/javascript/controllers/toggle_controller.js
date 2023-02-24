import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  initialize() {
    const toggleButton =  () => {
      if (document.getElementById('body').classList.contains('toggle-sidebar')) {
        document.getElementById('body').classList.remove('toggle-sidebar')
      }else{
        document.getElementById('body').classList.add('toggle-sidebar')
      }
    }
    this.element.addEventListener('click', toggleButton)
  }
  connect() { } 
}
