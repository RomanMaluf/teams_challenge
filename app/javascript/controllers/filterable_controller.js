import {Controller} from "@hotwired/stimulus"

const toggleFiltersTable = ()=>{
  $(".js-show-index-filters").on('click',function () {
    $(".filter-well").slideToggle();
    $(this).parents(".filter-wrap").toggleClass("collapsed");
    $("span.icon", $(this)).toggleClass("icon-chevron-down");
  });
}

const removeFilterFromBadge= function(){
  $(document).on("click", ".js-delete-filter", function () {
    var ransackField = $(this).parents(".js-filter").data("ransack-field");

    $("#" + ransackField).val("");
    $("#table-filter form").submit();
  });
}

const quickSearchFromTable = () => {
  // Temp quick search
  // When there was a search term, copy it
  $(".js-quick-search").val($(".js-quick-search-target").val());
  // Catch the quick search form submit and submit the real form
  $("#quick-search").submit(function () {
    $(".js-quick-search-target").val($(".js-quick-search").val());
    $("#table-filter form").submit();
    return false;
  });

}

const addFilterBadgeFromSearchFrom = ()=>{
  $(".js-filterable").each(function () {
    var $this = $(this);

    if ($this.val()) {
      var ransackValue, filter;
      var ransackFieldId = $this.attr("id");
      var label = $('label[for="' + ransackFieldId + '"]');

      if ($this.is("select")) {
        ransackValue = $this.find("option:selected").text();
      } else {
        ransackValue = $this.val();
      }

      label = label.text() + ": " + ransackValue;

      filter =
        '<span class="js-filter badge bg-secondary" data-ransack-field="' +
        ransackFieldId +
        '">' +
        label +
        '&nbsp; <span class="fa-solid fa-delete-left js-delete-filter"></span></span>';
      $(".js-filters").append(filter).show();
    }
  });
}
export default class extends Controller {
  initialize() {
    // Add all events listeners and functionalities to filters table
    toggleFiltersTable();
    removeFilterFromBadge();
    quickSearchFromTable();
    addFilterBadgeFromSearchFrom();
  }
  connect() { } 


}
