<?php

require '../../conecta.php';

$codigoUsuario = isset($_POST['codigoUsuario']) ? $_POST['codigoUsuario'] : null;
$nome = isset($_POST['nome']) ? $_POST['nome'] : null;
$dataNascimento = isset($_POST['dataNascimento']) ? $_POST['dataNascimento'] : null;
$genero = isset($_POST['genero']) ? $_POST['genero'] : null;
$login = isset($_POST['login']) ? $_POST['login'] : null;
$senha = isset($_POST['senha']) ? md5($_POST['senha']) : null;
$cep = isset($_POST['cep']) ? str_replace('-', '', $_POST['cep']) : null;

if (empty($nome) || empty($dataNascimento) || empty($genero) || empty($login) || empty($senha) || empty($cep)) {
	echo "Preencha todos os campos.";
	exit;
}

if (empty($codigoUsuario) && empty($senha)) {
	echo "Senha não pode ser vazia.";
	exit;
}


$fp = null;
if (isset($_FILES['avatar']) && $_FILES['avatar']['size'] > 0) {
	$tmpName  = $_FILES['avatar']['tmp_name'];
	$fp = fopen($tmpName, 'rb');
}

$sql = "select * from salvar_conta (:codigoUsuario, :nome, :dataNascimento, :genero, :avatar, :login, :senha, :cep)";
$query = $PDO->prepare($sql);
$query->bindParam(":codigoUsuario", $codigoUsuario, PDO::PARAM_INT);
$query->bindParam(":nome", $nome, PDO::PARAM_STR);
$query->bindParam(":dataNascimento", $dataNascimento, PDO::PARAM_STR);
$query->bindParam(":genero", $genero, PDO::PARAM_INT);
$query->bindParam(":avatar", $fp, PDO::PARAM_LOB);
$query->bindParam(":login", $login, PDO::PARAM_STR);
$query->bindParam(":senha", $senha, PDO::PARAM_STR);
$query->bindParam(":cep", $cep, PDO::PARAM_INT);

if ($query->execute()) {
	$retorno = $query->fetchObject();
	require '../../utils/cookieHelper.php';
	addCookie($cookieTicketAcesso, $retorno->salvar_conta);
	header('Location: ../../index.php');
} else {
	echo "Erro ao cadastrar Cliente";
	print_r($query->errorInfo());
}

?>