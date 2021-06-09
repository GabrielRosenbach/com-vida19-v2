<?php

include_once("conecta.php");

$login = $_POST['login'];
$email = $_POST['email'];
$password = $_POST['password'];

$sql = "INSERT INTO  usuario(email_usu, password_usu, login_usu, cod_tipo_usu) VALUES('$email', '$password','$login',1)";

echo "nome:".$login;
echo "email: $email";
echo "password: $password";
$salvar = mysqli_query($connection, $sql);

if(mysqli_insert_id($connection)){
    header("Location: Cadastro_Login.html");
}

mysqli_close($connection);


?>