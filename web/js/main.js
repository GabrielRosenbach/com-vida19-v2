$(document).ready(function () {

  $(".imgProduto").on("click", function () {
    $("#imagepreview").attr("src", $(this).attr("src")); 
    $("#imagemodal").modal("show"); 
  })

  $("main").ready(function() {
    $("accordion").ready(function() {
      $("#comboEstados").change(function(e) {
        $.ajax({
          method: "get",
          url: "public/home/itemsAccordeon/situacao/covid.api.php?uf=" + e.target.value,
          success: function(data){
            json = JSON.parse(data);
            $("#confirmados")[0].innerHTML = json.cases;
            $("#suspeitos")[0].innerHTML = json.suspects;
            $("#negativados")[0].innerHTML = json.refuses;

            data = new Date(json.datetime);
            mes = data.getMonth() + 1;
            mes = mes < 10 ? '0' + mes : mes;

            dataFormatada = data.getDate() + "/" + mes + "/" + data.getFullYear(); 

            $("#dataAtualizada")[0].innerHTML = dataFormatada;
          }
        });
      });
    });
  });
});





