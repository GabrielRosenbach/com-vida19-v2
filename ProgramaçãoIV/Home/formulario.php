<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <title>Formulário</title>
        <meta charset="utf-8">
        <link rel="stylesheet" href="formulario.css">
        <!--para conectar apis dos locais( regiao,estado e cidade)-->
        <script src="conecta_local.js" type="text/javascript"></script>
    </head>
<?php
    session_start();
    include ("../Cadastro_Login/conecta.php");
    $codigo = $_SESSION['cod_usu'];

?>
    <body>
        <div class="container">
            <div class="title">
                Coloque seu dados abaixo
            </div>
            <?php
                $tem_cadastro = 0;
                    $sql = mysqli_query($conexao,"select * from tem_cadastro_vw where  cod_usu ='".$codigo."'" );
                    if(mysqli_num_rows($sql)>0){
                        echo '<div style="font-size:20px;font-weight:bold;">Você já tem um cadastro dessas informações se desejas mudar algo preencha TODO o Formulário e clique em enviar!</div>';
                        $tem_cadastro = 1;
                    }

            ?>
            <form action="#" method="POST">
                <div class="user-details">
                    <div class="input-box">
                        <span class="details">Nome Completo:</span>
                        <input type="text" name="nome" id="nome" placeholder="Digite aqui seu nome..." required >   
                    </div>
                    <div class="input-box">
                        <span class="details">Altura:</span>
                        <input type="text" name="altura" id="altura" placeholder="Digite aqui sua altura..." required >   
                    </div>
                    <div class="input-box">
                        <span class="details">Peso:</span>
                        <input type="text" name="peso" id="peso" placeholder="Digite aqui seu peso..." required >   
                    </div>
                    <div class="input-box">
                        <span class="details">Data Nascimento:</span>
                        <input type="date" name="data" id="data" placeholder="Digite aqui sua data de nascimento..." required >   
                    </div>
                    <div class="genero">
                        <span class="details">Gênero:</span>
                       <div class="generos"><label for="masculino"><input type="radio" name="genero" id="masculino" value="M" required >Masculino</label>
                        <label for="feminino"><input type="radio" name="genero" id="feminino" value="F" required >Feminino</label></div> 
                    </div>
                    <div class="input-box">
                        <span class="details">Rua:</span>
                        <input type="text" name="rua" id="rua" placeholder="Digite aqui nome da rua..." required >   
                    </div>
                    <div class="input-box">
                        <span class="details">Número:</span>
                        <input type="number" name="numero" id="numero" placeholder="Digite aqui número..." required >   
                    </div>
                    <div class="input-box">
                        <span class="details">Bairro:</span>
                        <input type="text" name="bairro" id="bairro" placeholder="Digite aqui nome do bairro..." required >   
                    </div>
                    <div class="input-box">
                        <span class="details">Complemento:</span>
                        <input type="text" name="complemento" id="complemento" placeholder="Digite aqui o complemento do endereço..." required >   
                    </div>
                    <div class="input-box">
                        <span class="details">Telefone:</span>
                        <input type="tel" name="telefone" id="telefone" placeholder="Digite aqui seu nome..." required >   
                    </div>

                    <!--parte do regiao estado e cidade-->
                   
                    <div class="input-box">
                        <span class="details">Região:</span>
                        <select name="regiao" id="regiao" onchange="javascript:mostraEstado(this);" required >
                            <option value=""></option>
                        </select>
                    </div>
                    <div class="input-box">
                        <span class="details">Estado:</span>
                        <select name="estado" id="estado" onchange="javascript:mostraCidade(this);" required >
                            <option value=""></option>
                        </select>
                    </div>
                    <div class="input-box">
                        <span class="details">Cidade:</span>
                        <select name="cidade" id="cidade" required >
                            <option value=""></option>
                        </select>
                    </div>
                </div><!--fim user details-->
                <button type="submit">Enviar</button>
            </form>
        </div>


        <?php
                if(count($_POST) > 0){
                    $nome = $_POST['nome']; 
                    $rua = $_POST['rua'];
                    $bairro = $_POST['bairro'];
                    $numero = $_POST['numero'];
                    $complemento = $_POST['complemento'];
                    $estado = $_POST['estado']; 
                    $regiao = $_POST['regiao']; 
                    $cidade = $_POST['cidade']; 
                    $genero = $_POST['genero']; 
                    $altura = $_POST['altura']; 
                    $peso = $_POST['peso']; 
                    $data_nas = $_POST['data'];
                    $telefone = $_POST['telefone'];
                    
                    if($tem_cadastro == 1){
                        $sql_update_endereco = mysqli_query($conexao,"update pega_pac_end_vw set rua_end ='".$rua."',cod_cid = '".$cidade."',num_end='".$numero."',comp_end='".$complemento."',bai_end = '".$bairro."' where cod_usu = '".$codigo."'");
                         
                        $sql_update_paciente = mysqli_query($conexao,"update update_paciente_vw set nome_pac ='".$nome."', gen_pac = '".$genero."',alt_pac ='".$altura."',peso_pac='".$peso."',data_nasc_pac = '".$data_nas."' where cod_usu = '".$codigo."'");

                    }else{
                        $sql_insert_paciente = mysqli_query($conexao,"insert into paciente(nome_pac,alt_pac,peso_pac,data_nasc_pac,gen_pac,cod_usu) values('$nome','$altura','$peso','$data_nas','$genero',$codigo)");
                        $las_id = mysqli_insert_id($conexao);
                        
                        $sql_insert_endereco = mysqli_query($conexao,"insert into endereco(rua_end,num_end,comp_end,bai_end,cod_cid,cod_pac) values('$rua','$numero','$complemento','$bairro','$cidade','$las_id')");
                    }


                }
        ?>    






        <!--script para regiao-->
  <script type="text/javascript"> 
 
    myObj = (JSON.parse(fazGet("https://servicodados.ibge.gov.br/api/v1/localidades/regioes")));

    console.log(myObj.length)

   for(var i =0;i < myObj.length;i++){
        document.querySelector("#regiao").innerHTML += "<option value="+myObj[i].id+">"+myObj[i].nome+"</option>";
        console.log(myObj[i].nome)
    }
    
   </script>
   <!--script para estado-->
   <script type="text/javascript">
       function mostraEstado(elemento){
           meuObj = (JSON.parse(fazGet("https://servicodados.ibge.gov.br/api/v1/localidades/regioes/"+ elemento.value+"/estados")));

           console.log(meuObj.length)
           for(j=0;j<meuObj.length;j++){
               document.querySelector("#estado").innerHTML += "<option value="+meuObj[j].id+">"+meuObj[j].nome+"</option>";
           }

       }
   </script>
    <!--script para cidade-->
   <script>
       function mostraCidade(elemento){
           mioObj = (JSON.parse(fazGet("https://servicodados.ibge.gov.br/api/v1/localidades/estados/"+ elemento.value+"/municipios")));
           for(k=0;k<mioObj.length;k++){
               document.querySelector("#cidade").innerHTML += "<option value="+mioObj[k].id+">"+mioObj[k].nome+"</option>";
           }
       }
   </script>
    </body>
</html>

