<?php

require_once '../../conecta.php';
require '../../utils/cookieHelper.php';

$ticketAcesso = getCookie($cookieTicketAcesso);

$array = [];
$cont = 0;
$totalIntensidade = 0;
foreach (( $PDO->query("select * from codigos_sintomas_vw")) as $row) {
	$chaveSintoma = 'sintoma-'.$row['codsin'];
	$sintoma = isset($_POST[$chaveSintoma]) ? $_POST[$chaveSintoma] : null;
    
	if (isset($sintoma)) {
		$chaveIntensidade = 'intensidade-'.$row['codsin'];
		
		$intensidade = isset($_POST[$chaveIntensidade]) ? $_POST[$chaveIntensidade] : null;

		$array[$cont++] = [$sintoma, $intensidade];

		$totalIntensidade += $intensidade;
	}
}

if (count($array) == 0) {
	echo "Escolha algum sintoma.";
	exit;
}

$statusProntuario = null;

if ($totalIntensidade < 5) {
	$statusProntuario = 1;	
} else if ($totalIntensidade < 8) {
	$statusProntuario = 2;
} else {
	$statusProntuario = 3;
}

$queryProntuario = $PDO->prepare("select * from salvar_prontuario(:ticket, :status)");
$queryProntuario->bindParam(':ticket', $ticketAcesso);
$queryProntuario->bindParam(':status', $statusProntuario);

$queryProntuario->execute();
$prontuario = $queryProntuario->fetchObject();

$sql = "insert into prontuario_sintoma(codpro, codsin, codint) values ";

for ($i = 0; $i < count($array); $i++) {
	if ($i > 0) {
		$sql = $sql . ', ';
	}
	$sql = $sql . '(' .$prontuario->salvar_prontuario. ', ' .$array[$i][0]. ', ' .$array[$i][1]. ')';
}


$query = $PDO->prepare($sql);

if ($query->execute()) {
	header('Location: ../../index.php');
} else {
	echo "Erro ao cadastrar Cliente";
	print_r($query->errorInfo());
}

?>