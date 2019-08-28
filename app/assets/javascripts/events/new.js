$(function () {
  if($("#event-new-page").length > 0)
    $('#start_at_datetime_picker').datetimepicker({
      sideBySide: true,
      format: 'YYYY-MM-DD HH:mm'
    });
});
