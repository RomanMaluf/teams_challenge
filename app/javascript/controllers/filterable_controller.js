import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  initialize() {
    $(function () {
      $(".js-show-index-filters").click(function () {
        $(".filter-well").slideToggle();
        $(this).parents(".filter-wrap").toggleClass("collapsed");
        $("span.icon", $(this)).toggleClass("icon-chevron-down");
      });
      // Clickable ransack filters
      $(".js-add-filter").click(function () {
        var ransackField = $(this).data("ransack-field");
        var ransackValue = $(this).data("ransack-value");
    
        $("#" + ransackField).val(ransackValue);
        $("#table-filter form").submit();
      });
    
      $(document).on("click", ".js-delete-filter", function () {
        var ransackField = $(this).parents(".js-filter").data("ransack-field");
    
        $("#" + ransackField).val("");
        $("#table-filter form").submit();
      });
    
      function ransackField(value) {
        switch (value) {
          case "Date Range":
            return "Start";
          case "":
            return "Stop";
          default:
            return value.trim();
        }
      }
      // TODO: remove this js temp behaviour and fix this decent
      // Temp quick search
      // When there was a search term, copy it
      $(".js-quick-search").val($(".js-quick-search-target").val());
      // Catch the quick search form submit and submit the real form
      $("#quick-search").submit(function () {
        $(".js-quick-search-target").val($(".js-quick-search").val());
        $("#table-filter form").submit();
        return false;
      });
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
    
          label = ransackField(label.text()) + ": " + ransackValue;
    
          filter =
            '<span class="js-filter badge bg-secondary" data-ransack-field="' +
            ransackFieldId +
            '">' +
            label +
            '&nbsp; <span class="fa-solid fa-delete-left js-delete-filter"></span></span>';
          $(".js-filters").append(filter).show();
        }
      });
    });
  }
  connect() { } 
}
