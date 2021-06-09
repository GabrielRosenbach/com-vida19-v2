var btnLogin = document.querySelector('#btn_entrar');
var btnCadastro = document.querySelector('#btnCadastro')
var body = document.querySelector('body');

btnLogin.addEventListener("click", function(){
    body.className = "btnLogin_js";
})

btnCadastro.addEventListener("click", function(){
    body.className = "btnCadastro_js"
})