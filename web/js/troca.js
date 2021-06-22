
function abrirPag(pagina){
	$("main").load(pagina);
}

$("document").ready(function($) {
	var nav = $('#menufixo');
	
	$(window).scroll(function () {
		if ($(this).scrollTop() > 140) {
			nav.addClass("navbar-fixed");
		} else {
			nav.removeClass("navbar-fixed");
		}
	});
});

//Abrir popup dinamicamente
$(".show-modal").click(function(e) {
	//Para o evento padrão
	e.preventDefault();
	//Busca o valor do href do elemento e gera a função
	$.get($(this).attr("href") , function(result) {
		//Cria uma div e coloca dentro dela o html do arquivo
		let div = document.createElement("div");
		div.innerHTML = result;

		//Busca o modal, remove o que tiver dentro e adiciona um novo conteudo.
		let modal = document.getElementById('myModal');
		modal.removeChild(modal.firstChild);
		modal.appendChild(div);
	});
})