<?php 
    unset($_COOKIE['usuario']);
    setcookie('usuario', null, -1, '/');
	header('Location: ../index.php');
?>