// トップページのトグルの部分
$(document).on('turbolinks:load', function() {
	$("#nav_button").click(function(){
		$("#nav_button2").slideToggle();
	});
});

// メニューカテゴリー２の中身の切り替え部分
window.addEventListener('turbolinks:load', function() {
  $(".menu_category2 li").on("click", function() {
    $("li.selected").removeClass("selected");
    $(this).addClass("selected");
    $(".menu_indiv").children().hide();
    $("."+this.id).show();
  }); 
});

// モーダルの呼び出し
$(document).on('turbolinks:load', function() {
  $(".menu_indiv_block").click(function(event){
    var id = $(this).attr('menuid')
    var url = '/order/modal_test/' + id
    
    $.ajax({
        url: url,
        success: function(modal){
          $("body").append(modal);
          // $("#modal").html(modal);
        }
    });
  });
})  


// モーダルを消す。ボタンの動き
$(function() {
    $("#modal_close").click(function(){
      $(this).remove();
      $("#modal_bg").remove();
      $("#modal_menu_indiv").remove();
    });
})
// ↑これに「$(document).on('turbolinks:load', function() {」をつけると
// 逆にボタンが動かなくなる
