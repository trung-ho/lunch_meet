$(function () {
  if($(".invite-member").length > 0){
    $( ".invite-member" ).on( "click", function() {
      var user_id = this.dataset.userId;
      $("#group_member_user_id").val(user_id);
      $("#new_group_member").submit();
    });
  }
});
