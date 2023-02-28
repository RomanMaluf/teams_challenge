import {Controller} from "@hotwired/stimulus"
import "jquery"
import "jquery_ujs"

export default class extends Controller {
  initialize() {


    $('.delete_member').on('click', function(){
      $(this).closest('tr').fadeOut("slow");
      $(this).prev("input[type=hidden]").val("1")
    });
  }

  static classes = [ "delete_member" ]

  connect() {
   } 
}
