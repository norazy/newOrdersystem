// 通知テーブルのデータがある時に呼び出されるアラート
$(document).on('turbolinks:load', function() {
    var p = $("div").hasClass('flashes');
    if (p) {
      alert('通知があります！');
    }
})

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