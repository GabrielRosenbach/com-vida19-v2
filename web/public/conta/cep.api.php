<?php

    if (isset($_GET['cep'])) {
       echo getCidadeEstado($_GET['cep']);
    }

    function getCidadeEstado($cep) {
        require_once '../../conecta.php';

        $sql = "select * from buscar_cidade_estado(:cep)";
        $query = $PDO->prepare($sql);
        $query->bindParam(":cep", $cep, PDO::PARAM_INT);

        $query->execute();
        
        $dados = $query->fetchObject();
        
        if (!$dados) {
            $ret = json_decode(file_get_contents('https://viacep.com.br/ws/' .$cep. '/json'));
        
            $saveDados = "select * from salvar_cidade_cep_endereco(:uf, :nomecidade, :cep)"; 
            $queryDados = $PDO->prepare($saveDados);
            $queryDados->bindParam(":uf", $ret->{'uf'}, PDO::PARAM_STR, 2);
            $queryDados->bindParam(":nomecidade", $ret->{'localidade'}, PDO::PARAM_STR, 30);
            $queryDados->bindParam(":cep", $cep, PDO::PARAM_INT);
            
            $queryDados->execute();

            $dados = $queryDados->fetchObject();
        }

        echo json_encode($dados);
    }
?>