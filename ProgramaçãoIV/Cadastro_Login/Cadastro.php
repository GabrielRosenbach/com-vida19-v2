<?php


include("conecta.php");

$login = ucwords($_POST['login']); //coloca 1 letra da frase em maiuscula
$email = $_POST['email'];
$password = $_POST['password'];
$tipo_user = 1;

$sql = mysqli_query($conexao, "insert into usuario(login_usu,email_usu,senha_usu,cod_tipo_usu) values('$login','$email','$password','$tipo_user')");

/*
    if($sql){
        echo "Usuário cadastrado!";
        header('Location: Cadastro_Login');
    }
    else{
        echo "Não foi possivel cadastrar usuário verifique os campos digitados."
        header('Location: Cadastro_Login');
    }*/
?>