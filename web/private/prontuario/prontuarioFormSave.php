<?php

require_once '../../conecta.php';

$nome = isset($_POST['nome']) ? $_POST['nome'] : null;
$telefone = isset($_POST['telefone']) ? $_POST['telefone'] : null;
$endereco = isset($_POST['endereco']) ? $_POST['endereco'] : null;
$usuario = isset($_POST['usuario']) ? $_POST['usuario'] : null;
$senha = isset($_POST['senha']) ? $_POST['senha'] : null;



if (empty($nome) ||  empty($telefone) || empty($endereco) || empty($usuario) || empty($senha)) {
	echo "Preencha todos os campos.";
	exit;
}
$sql = "INSERT INTO cliente(nome, telefone, endereco, usuario, senha) VALUES (:nome, :telefone, :endereco, :usuario, :senha)";
$qryAdd = $PDO->prepare($sql);
$qryAdd->bindParam(':nome',$nome);
$qryAdd->bindParam(':endereco', $endereco);
$qryAdd->bindParam(':telefone', $telefone);
$qryAdd->bindParam(':usuario', $usuario);
$qryAdd->bindParam(':senha', $senha);

if ($qryAdd->execute()) {
	setcookie("usuario", $PDO->lastInsertId(), 0, '/');
	header('Location: index.php');
} else {
	echo "Erro ao cadastrar Cliente";
	print_r($qryAdd->errorInfo());
}

?>