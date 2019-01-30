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

// var box
// モーダルの呼び出し
$(document).on('turbolinks:load', function() {
  $(".menu_indiv_block").click(function(event){
    var id = $(this).attr('menuid')
    var url = '/order/modal_test/' + id
    
    $.ajax({
        url: url,
        success: function(modal){
          modal_bg = $(modal).filter("#modal_bg");
          modal_menu = $(modal).filter("#modal_menu_indiv");
          modal_close = $(modal).filter("#modal_close");
          
          $("body").append(modal_bg);
          $("body").append(modal_menu);
          $("body").append(modal_close);

          // console.log(modal_bg);
          // box = $.parseHTML(modal)
          // $("body").append(modal);

          // モーダルを消す。ボタンの動き
           $("#modal_close").click(function(){
                // console.log(1)
                $("#modal_bg").remove();
                $("#modal_menu_indiv").remove();
            });
          // ↓注文個数のクリック後の色変更
          $(".modal_menu_number label").click(function(){
            $(".modal_menu_number").css("background-color", "#f5f5dc");
            $(this).parent().css("background-color", "#ea5317");
          });
          // ↓オプションの選択部分
          $(".modal_menu_option label").click(function(){
            $(".modal_menu_option").css("background-color", "#000a34");
            $(this).parent().css("background-color", "#ea5317");
          });
        }
    });
  });
  
})  


// モーダルを消す。ボタンの動き
// $(document).on('turbolinks:load', function() {
// $(function() {
// window.addEventListener('turbolinks:load', function() {

//     $("#modal_close").click(function(){
//       console.log(1)
//       // $(this).remove();
//       $("#modal_bg").remove();
//       $("#modal_menu_indiv").remove();
//       // $.parseHTML(box);

//       // $("body").remove(box);
//       // console.log(box);
//       // $(box).remove();
//     });
// })
// ↑これに「$(document).on('turbolinks:load', function() {」をつけると
// 逆にボタンが動かなくなる

// // ↓注文個数のクリック後の色変更
// $(function() {
//   $(".modal_menu_number label").click(function(){
//     $(".modal_menu_number").css("background-color", "#f5f5dc");
//     $(this).parent().css("background-color", "#ea5317");
//   });
// })

// // ↓オプションの選択部分
// $(function() {
//   $(".modal_menu_option label").click(function(){
//     $(".modal_menu_option").css("background-color", "#000a34");
//     $(this).parent().css("background-color", "#ea5317");
//   });
// })
