$(function () {
  if($("#new_voting #voting_restaurant_id").length > 0){
    $( ".vote-for-restaurant" ).on( "click", function() {
      console.log ('>');
      var restaurant_id = this.dataset.restaurantId
      $("#voting_restaurant_id").val(restaurant_id);
      $("#new_voting").submit();
    });
  }
});
