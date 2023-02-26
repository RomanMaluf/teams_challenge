import {Controller} from "@hotwired/stimulus"
import "jquery"
import "jquery_ujs"
import "select2"

export default class extends Controller {
  initialize() {
  /**
    ADD FIELDS ON HAS MANY RELATIONSHIPS
  **/
    var uniqueId = 1
    $(this.element).on('click',function() {
      var target = $(this).data('target')
      var newTableRow = $(target + ' tr:visible:last').clone()
      var newId = new Date().getTime() + (uniqueId++)
    
      newTableRow.find('input').each(function() {
        var el = $(this)
        el.val('')
        el.prop('id', el.prop('id').replace(/\d+/, newId))
        el.prop('name', el.prop('name').replace(/\d+/, newId))
      })
    
      // Fix select2 bad UI
      newTableRow.find("span").remove();
      newTableRow.find('select').each(function() {
        var el = $(this)
        el.val('')
        el.select2('destroy')
        el.select2();
      });
    
      $(target).append(newTableRow)
    })
  }
  connect() {
   } 
}
