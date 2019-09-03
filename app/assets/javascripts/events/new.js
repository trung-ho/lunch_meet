$(function () {
  if($("#event-new-page").length > 0)
    $('#start_at_datetime_picker').datetimepicker({
      sideBySide: true,
      format: 'YYYY-MM-DD HH:mm'
    });

   document.getElementById('event_radius').oninput = function(){
    document.getElementById('radius-output').value = document.getElementById('event_radius').value;
  }
});
