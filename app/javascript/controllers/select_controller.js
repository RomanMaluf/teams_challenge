import {Controller} from "@hotwired/stimulus"
import "select2";


export default class extends Controller {
  initialize() {
    $(this.element).select2({
        allowClear: true,
        theme: "bootstrap-5"
    });
  }
  connect() { } 
}