<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <title>Perfil</title>
        <meta charset="utf-8">
        <link rel="stylesheet" href="perfil.css">
    </head>
    <?php
        session_start();
        $codigo =  $_SESSION['cod_usu'];
        include ("../Cadastro_Login/conecta.php");
        
        $sql = mysqli_query($conexao,"select * from tela_info_vw where cod_usu = '".$codigo."'");
        if(mysqli_num_rows($sql)>0){
            while($rows = mysqli_fetch_assoc($sql)){
                $nome = $rows['nome_pac'];
                $alt_pac = $rows['alt_pac'];
                $peso_pac = $rows['peso_pac'];
                $data_nas = $rows['data_nasc_pac'];
                $gen_pac = $rows['gen_pac'];
                $rua_end = $rows['rua_end'];
                $num_end = $rows['num_end'];
                $comp_end = $rows['comp_end'];
                $bai_end = $rows['bai_end'];
                $cidade = $rows['nome_cid'];
                $estado = $rows['nome_est'];
            }
        }
        if($gen_pac == 'F'){
            $gen_pac = 'Feminino';
        }else $gen_pac = 'Masculino';
        

        function descobrirIdade($dataNascimento){
            $data       = explode("-",$dataNascimento); // aqui ira separa dia mes ano colocando em um array
            
            $anoNasc    = $data[0];
            $mesNasc    = $data[1];
            $diaNasc    = $data[2];
         
            $anoAtual   = date("Y");
            $mesAtual   = date("m");
            $diaAtual   = date("d");
         
            $idade      = $anoAtual - $anoNasc; // ate aqui ele faz ano do nascimento - ano corrente
         
            if ($mesAtual < $mesNasc){ // ai aqui vem para o mes caso o user ainda nao fez aniversário
                $idade -= 1;
                return $idade;
            } elseif ( ($mesAtual == $mesNasc) && ($diaAtual <= $diaNasc) ){
                $idade -= 1;
                return $idade;
            }else
                return $idade;
        }
         
        $idade =  descobrirIdade($data_nas);

    ?>
    <body>
        <a href="../Home/home.php"><img src="seta_voltar.png" alt="seta_voltar" class="seta_voltar"></a>
        <section id="principal">
            <div class="container_foto">

                <?php  
                    if($gen_pac == 'Masculino'){
                        echo '<img src="avatar_masc.png" alt="">';
                    }else echo '<img src="avatar_fem.png" alt="">';
                ?>
                

                <img src="pencil.jpg" alt="" width="32px" class="troca_avatar">
            </div>
            <div class="container_geral_info">
                <div class="informacao_perfil container">
                    <div class="perfil_nome"><div class="info_perfil">Nome: <?=$nome ?></div></div>
                    
                    <div class="informacoes">
                        <div class="container_info_perfil">
                            <div class="info_perfil">Idade: <?=  $idade?></div>
                            <div class="info_perfil">Altura: <?= $alt_pac?></div>
                        </div>
                        
                        <div class="container_info_perfil">
                            <div class="info_perfil">Peso: <?= $peso_pac ?></div>
                            <div class="info_perfil">Gênero: <?= $gen_pac?></div>
                        </div>
                    </div>
                    
                </div>
                <div class="endereco container">  
                    <div class="container_info_perfil">
                        <div class="info_end">Estado: <?= $estado ?></div>
                        <div class="info_end">Bairro: <?= $bai_end?></div>
                        <div class="info_end">Complemento: <?= $comp_end?></div>
                    </div>
                    <div class="container_info_perfil">
                        <div class="info_end">Cidade: <?= $cidade?></div>
                        <div class="info_end">Rua: <?= $rua_end?></div>
                        <div class="info_end">Número: <?= $num_end?></div>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>