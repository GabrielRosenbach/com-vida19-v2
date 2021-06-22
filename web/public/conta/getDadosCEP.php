<?php

    require_once '../../conecta.php';

    $cep = $_GET['cep'];

    $sql = "SELECT * FROM cep_endereco AS ce 
        INNER JOIN cidade AS ci ON ce.codcid = ci.codcid 
        INNER JOIN estado AS es ON es.codest = ci.codest 
        WHERE ce.numcep = " . $cep;
    $query = $PDO->prepare($sql);
    $query->execute();

    $dados = $query->fetchObject();

    if (isset($dados)) {
        $ret = json_decode(file_get_contents('https://viacep.com.br/ws/' .$cep. '/json'));
        $query = $PDO->prepare($sql);
    $query->execute();

    }

    echo $dados;

?>