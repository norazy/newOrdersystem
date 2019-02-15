// 通知テーブルのデータがある時に呼び出されるアラート
$(document).on('turbolinks:load', function() {
    var p = $("div").hasClass('flashes');
    if (p) {
      alert('通知があります！');
    }
})

// ページのトグルの部分
$(document).on('turbolinks:load', function() {
	$("#kitchen_nav_button").click(function(){
		$("#kitchen_nav_button2").slideToggle();
	});
});

// テーブルの状態を示す部分
$(document).on('turbolinks:load', function() {
    $(".table_indiv").each(function(i){
    
    var color = $(".table_indiv span").eq(i).html();
    // console.log(color)
      if (color == 1) {
          $(".table_indiv").eq(i).addClass("blue2");
      } else if (color == 2){
          $(".table_indiv").eq(i).addClass("green");
      } else {
          $(".table_indiv").eq(i).addClass("gray");
      }        
    });
});


// 調理待の状態を示す部分
$(document).on('turbolinks:load', function() {
    $(".cooked").each(function(i){
    
    var color = $(".cooked span").eq(i).html();

      if (color == 2) {
          $(".cooked").eq(i).addClass("orange2");
      }        
    });
});



// $(document).on('turbolinks:load', function() {
//   $(".destroy_btn").click(function(){
//     console.log(1)
//     // var number = $(".plus_btn").index(this);
//     // var letter = $(".preorder_menu_number2 p").eq(number).html();
//     // // 文字列を数値にする↓
//     // letter = parseInt(letter);

//     // if (letter < 4 ) {
//     //     var letter2 = letter + 1
//     //     $(".preorder_menu_number2 p").eq(number).html(letter2);
//     //     $(".orderlist_number_value").eq(number).val(letter2);

//     // }
//   });
// })