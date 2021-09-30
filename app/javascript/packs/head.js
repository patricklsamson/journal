$(function () {
  $("#datepicker").datepicker({
    dateFormat: "D, dd M yy",
    firstDay: 1,
    minDate: 0,
  });

  $(".btn-done").on("click", function () {
    $(this).parent().submit();

    if ($(this).is(":checked")) {
      $(this).next().addClass("text-decoration-line-through");
    }
  })

  $(".btn-done:checked").next().addClass("text-decoration-line-through");
});
