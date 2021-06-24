<?php

require_once '../../conecta.php';

$login = isset($_POST['login']) ? $_POST['login'] : null;
$senha = isset($_POST['senha']) ? md5($_POST['senha']) : null;

if (empty($login) || empty($senha)) {
	echo "Preencha todos os campos.";
	exit;
}

$sql = "select aceusu from usuario where logusu = :login and senusu = :senha";
$query = $PDO->prepare($sql);
$query->bindParam(":login", $login, PDO::PARAM_STR);
$query->bindParam(":senha", $senha, PDO::PARAM_STR);

if ($query->execute()) {
	$retorno = $query->fetchObject();
	require '../../utils/cookieHelper.php';
	addCookie($cookieTicketAcesso, $retorno->aceusu);
	header('Location: ../../index.php');
} else {
	echo "Erro ao cadastrar Cliente";
	print_r($query->errorInfo());
}

?>