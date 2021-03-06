<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <title>Home</title>
        <meta charset="utf-8">
        <link rel="stylesheet" href="home.css">
        <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
    </head>
    <?php
        /*aqui ira verificar se o usuario esta logado para que nao consigam burlar o sistema digitando direto na url a página home*/
            session_start();
            if((!isset ($_SESSION['login']) == true) and (!isset($_SESSION['password']) == true)){
                unset($_SESSION['login']);
                unset($_SESSION['password']);
               header('Location: ../Cadastro_Login/Cadastro_Login.html');
            }
            $logado = $_SESSION['login'];
            
            include ("../Cadastro_Login/conecta.php");
            $codigo = $_SESSION['cod_usu'];

                        /*no menu lateral tera uma pequena apresentacao das informacoes do user*/
                $sql_perfil = mysqli_query($conexao,"select * from info_perfil_home_vw where cod_usu = '".$codigo."'");
                if(mysqli_num_rows($sql_perfil)>0){
                    while($perfil = mysqli_fetch_assoc($sql_perfil)){
                        $data_nas = $perfil['data_nasc_pac'];
                        $peso = $perfil['peso_pac'];
                        $altura = $perfil['alt_pac'];
                        $gen_pac = $perfil['gen_pac'];
                    }
                
            
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
                }
           
        ?>
    <body>

        
        <section id="container_principal">
            <header id="container_menu">


               <div class="container_logo">
                   <div class="logo">Comvida19</div>
                   <div class="botao_menu" ><img src="images/botao_menu.png" width="20px" id="btn_menu" ></div>
               </div>
               
               <div class="container_perfil_lista">
                   <?php 
                      if(mysqli_num_rows($sql_perfil)>0){
                          echo "
                            <div class='container_perfil'>
                                <div class='foto_perfil'>";
                               
                                        if($gen_pac == 'M'){
                                            echo '<img src="../Perfil/avatar_masc.png" alt="" width="140px">';
                                        }else echo '<img src="../Perfil/avatar_fem.png" alt="" width="140px">';
                                    
                          echo "
                                </div>
                                <div class='informacao_perfil'>
                                    <div class='perfil_nome'>
                                        <span class='informacao'> ". $_SESSION['login']." </span>
                                    </div>
                                    <div class='perfil_informacao'>
                                        <span class='informacao'>Idade: ". $idade." </span>
                                        <span class='informacao'>Peso: ". $peso."</span>
                                    </div>
                                    <div class='perfil_informacao'>
                                        <span class='informacao'>Genero: ". $gen_pac ."</span>
                                        <span class='informacao'>Altura: ".  $altura ."</span>
                                    </div>

                                </div>
                            </div>
                            ";
                        }
                    ?>
                    <div class="menu">
                        <ul>
                            <li>
                                <a href="../Perfil/perfil.php">
                                    <i class='bx bxs-user' ></i>
                                    <span class="links_nome">Acessar meu perfil</span>
                                </a>
                                <span class="tooltip">Meu perfil</span>
                            </li>
                            <li>
                                <a href="formulario.php">
                                <i class='bx bx-edit' ></i>
                                    <span class="links_nome">cadastro de endereço</span>
                                </a>
                                <span class="tooltip">Cadastro de informações endereço</span>
                            </li>
                            <li>
                                <a href="#">
                                <i class='bx bx-message-edit'></i>
                                    <span class="links_nome">Cadastro sintomas</span>
                                </a>
                                <span class="tooltip">Acessar cadastro sintomas</span>
                            </li>
                            <li>
                                <a href="#">
                                    <i class='bx bx-message-alt-detail' ></i>
                                    <span class="links_nome">Perguntas Médico</span>
                                </a>
                                <span class="tooltip">Acessar minhas perguntas</span>
                            </li>
                        </ul>
                    </div>
               
                </div>
               

                <div class="container_sair">
                    <div class="sair">Aperte para sair</div>
                    
                    <img src="images/log-out.png" alt="" width="25px">
                </div>

            </header>





            <section id="secao_principal">
                <article id="painel"><!--CONTERÁ ESTATISTICAS CASOS NOVOS RECUPERADOS GERAL  E POR REGIOES--> 
                <section id="estatistica"><!--ESTATISTICAS CASOS RECUPERADOS CONFIRMADOS  GERAL-->
                        <div class="cards">
                        <?php
                                $sql_sus = mysqli_query($conexao,"call casos_geral('Suspeito')");
                                $sql_con_row = mysqli_fetch_assoc($sql_sus);
                                    $sql_suspeito = $sql_con_row['total'];
                                     mysqli_free_result($sql_sus);
                                     mysqli_close($conexao);
                            ?>
                            <h2>Casos suspeitos</h2>
                            
                            <div style="align-self:center"><?= ($sql_suspeito); ?></div>
                        </div>
                        <div class="cards">
                            <?php
                             include ("../Cadastro_Login/conecta.php"); 
                                $sql_con = mysqli_query($conexao,"call casos_geral('Confirmado')");
                                $sql_con_row = mysqli_fetch_assoc($sql_con);
                                    $sql_confirmado = $sql_con_row['total'];
                                     mysqli_free_result($sql_con);
                                     mysqli_close($conexao);
                            ?>
                            
                            <h2>Casos confirmados</h2>
                            <div  style="align-self:center"><?= ($sql_confirmado); ?></div>
                        </div>  
                        <div class="cards">
                            
                            <h2>Casos recuperados</h2>
                            <?php
                                    include ("../Cadastro_Login/conecta.php");      
                                    $sql_rec =  mysqli_query($conexao,"call casos_geral('Recuperado')"); 
                                     $row = mysqli_fetch_assoc($sql_rec);                            
                                         $sql_recuperado = $row['total']; 
                                         mysqli_free_result($sql_rec);
                                         mysqli_close($conexao);
                            ?>
                            <div style="align-self:center"><?= ($sql_recuperado); ?></div>
                        </div>
                        <div class="cards">
                            <h2>Casos Ativos</h2>
                            <div  style="align-self:center"><?= (($sql_confirmado)-($sql_recuperado));?></div>
                        </div>
                    </section>
            
                    <section id="estatistica_regiao"><!--ESTATISTICAS POR REGIOES-->
                        <div class="header_estatistica_regiao">
                            <h2>Veja os casos por regiões</h2>
                        </div>
                        <section id="mapa_regiao">
                            <div class="mapa">
                                <img src="images/southamerica.png" alt="southamerica" class="img_mapa">
                            </div>
                            <div class="container_regioes">
                              
                                <div class="header_regioes">
                                    <div class="column1 column">Total de casos</div><div class="column2 column">Casos ativos</div><div class="column3 column">Casos recuperados</div>
                                </div>
                                <div class="regioes">
                                    <!--Brasil-->
                                    <div class="regiao">
                                        <div class="nome_regiao">
                                            Brasil
                                        </div>

                                        <div class="casos_regiao">
                                            <div class="column1 column"><?= $sql_confirmado?></div>
                                            <div class="column2 column"><?= $sql_confirmado - $sql_recuperado?></div>
                                            <div class="column3 column"><?= $sql_recuperado?></div>
                                        </div>
                                    </div>
                                    <!--Norte-->
                                    <div class="regiao">
                                        <div class="seta_regiao">
                                            <div class="seta_norte">
                                                <img src="images/seta_estado.png" alt="" width="20px" class="img_seta">
                                            </div>
                                            <div class="nome_regiao">
                                                Norte
                                            </div>
                                        </div>
                                        <?php
                                        include ("../Cadastro_Login/conecta.php");  
                                             $sql_con_norte = mysqli_query($conexao,"call casos_regiao('Confirmado','Norte')");
                                             $sql_con_row = mysqli_fetch_assoc($sql_con_norte);
                                                 $sql_confirmado_norte = $sql_con_row['total'];
                                                 mysqli_free_result($sql_con_norte);
                                                 mysqli_close($conexao);
                                                 include ("../Cadastro_Login/conecta.php");  
                                                 $sql_rec_norte = mysqli_query($conexao,"call casos_regiao('Recuperado','Norte')");
                                                 $sql_con_row = mysqli_fetch_assoc($sql_rec_norte);
                                                     $sql_recuperado_norte = $sql_con_row['total'];
                                                     mysqli_free_result($sql_rec_norte);
                                                     mysqli_close($conexao);                                         
                                        ?>
                                        <div class="casos_regiao">
                                            <div class="column1 column"><?= $sql_confirmado_norte?></div>
                                            <div class="column2 column"><?= $sql_confirmado_norte - $sql_recuperado_norte ?></div>
                                            <div class="column3 column"><?= $sql_recuperado_norte?></div>
                                        </div>

                                        <div class="estado_norte estados">
                                            <div class="estado">
                                                <div class="nome_estado">
                                                    Santa Catarina
                                                </div>
                                                <div class="casos_estado">
                                                    <div class="column1 column">32145</div>
                                                    <div class="column2 column">32145</div>
                                                    <div class="column3 column">32145</div>
                                                </div>
                                            </div>

                                            <div class="estado">
                                                <div class="nome_estado">
                                                    Paraná
                                                </div>
                                                <div class="casos_estado">
                                                    <div class="column1 column">32145</div>
                                                    <div class="column2 column">32145</div>
                                                    <div class="column3 column">32145</div>
                                                </div>
                                            </div>
                                            <div class="estado">
                                                <div class="nome_estado">
                                                    Rio Grande so Sul
                                                </div>
                                                <div class="casos_estado">
                                                    <div class="column1 column">32145</div>
                                                    <div class="column2 column">32145</div>
                                                    <div class="column3 column">32145</div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <!--Nordeste-->
                                    <div class="regiao">
                                        <div class="seta_regiao">
                                            <div class="seta_nordeste">
                                                <img src="images/seta_estado.png" alt="" width="20px" class="img_seta">
                                            </div>
                                            <div class="nome_regiao">
                                                Nordeste
                                            </div>
                                        </div>
                                        <?php
                                        include ("../Cadastro_Login/conecta.php");  
                                             $sql_con_nordeste = mysqli_query($conexao,"call casos_regiao('Confirmado','Nordeste')");
                                             $sql_con_row = mysqli_fetch_assoc($sql_con_nordeste);
                                                 $sql_confirmado = $sql_con_row['total'];
                                                 mysqli_free_result($sql_con_nordeste);
                                                 mysqli_close($conexao);
                                                 include ("../Cadastro_Login/conecta.php");  
                                                 $sql_rec = mysqli_query($conexao,"call casos_regiao('Recuperado','Nordeste')");
                                                 $sql_con_row = mysqli_fetch_assoc($sql_rec);
                                                     $sql_recuperado = $sql_con_row['total'];
                                                     mysqli_free_result($sql_rec);
                                                     mysqli_close($conexao);                                         
                                        ?>
                                        <div class="casos_regiao">
                                            <div class="column1 column"><?= $sql_confirmado?></div>
                                            <div class="column2 column"><?= $sql_confirmado - $sql_recuperado ?></div>
                                            <div class="column3 column"><?= $sql_recuperado?></div>
                                        </div>

                                        <div class="estado_nordeste estados">
                                            <div class="estado">
                                                <div class="nome_estado">
                                                    Santa Catarina
                                                </div>
                                                <div class="casos_estado">
                                                    <div class="column1 column">32145</div>
                                                    <div class="column2 column">32145</div>
                                                    <div class="column3 column">32145</div>
                                                </div>
                                            </div>

                                            <div class="estado">
                                                <div class="nome_estado">
                                                    Paraná
                                                </div>
                                                <div class="casos_estado">
                                                    <div class="column1 column">32145</div>
                                                    <div class="column2 column">32145</div>
                                                    <div class="column3 column">32145</div>
                                                </div>
                                            </div>
                                            <div class="estado">
                                                <div class="nome_estado">
                                                    Rio Grande so Sul
                                                </div>
                                                <div class="casos_estado">
                                                    <div class="column1 column">32145</div>
                                                    <div class="column2 column">32145</div>
                                                    <div class="column3 column">32145</div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <!--Centro-Oeste-->
                                    <div class="regiao">
                                        <div class="seta_regiao">
                                            <div class="seta_centro">
                                                <img src="images/seta_estado.png" alt="" width="20px" class="img_seta">
                                            </div>
                                            <div class="nome_regiao">
                                                Centro-Oeste
                                            </div>
                                        </div>
                                        <?php
                                        include ("../Cadastro_Login/conecta.php");  
                                             $sql_con = mysqli_query($conexao,"call casos_regiao('Confirmado','Centro-Oeste')");
                                             $sql_con_row = mysqli_fetch_assoc($sql_con);
                                                 $sql_confirmado = $sql_con_row['total'];
                                                 mysqli_free_result($sql_con);
                                                 mysqli_close($conexao);
                                                 include ("../Cadastro_Login/conecta.php");  
                                                 $sql_con = mysqli_query($conexao,"call casos_regiao('Recuperado','Centro-Oeste')");
                                                 $sql_con_row = mysqli_fetch_assoc($sql_con);
                                                     $sql_recuperado = $sql_con_row['total'];
                                                     mysqli_free_result($sql_con);
                                                     mysqli_close($conexao);                                         
                                        ?>
                                        <div class="casos_regiao">
                                            <div class="column1 column"><?= $sql_confirmado?></div>
                                            <div class="column2 column"><?= $sql_confirmado - $sql_recuperado ?></div>
                                            <div class="column3 column"><?= $sql_recuperado?></div>
                                        </div>

                                        <div class="estado_centro estados">
                                            <div class="estado">
                                                <div class="nome_estado">
                                                    Santa Catarina
                                                </div>
                                                <div class="casos_estado">
                                                    <div class="column1 column">32145</div>
                                                    <div class="column2 column">32145</div>
                                                    <div class="column3 column">32145</div>
                                                </div>
                                            </div>

                                            <div class="estado">
                                                <div class="nome_estado">
                                                    Paraná
                                                </div>
                                                <div class="casos_estado">
                                                    <div class="column1 column">32145</div>
                                                    <div class="column2 column">32145</div>
                                                    <div class="column3 column">32145</div>
                                                </div>
                                            </div>
                                            <div class="estado">
                                                <div class="nome_estado">
                                                    Rio Grande so Sul
                                                </div>
                                                <div class="casos_estado">
                                                    <div class="column1 column">32145</div>
                                                    <div class="column2 column">32145</div>
                                                    <div class="column3 column">32145</div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <!--Sudeste-->
                                    <div class="regiao">
                                        <div class="seta_regiao">
                                            <div class="seta_sudeste">
                                                <img src="images/seta_estado.png" alt="" width="20px" class="img_seta">
                                            </div>
                                            <div class="nome_regiao">
                                                Sudeste
                                            </div>
                                        </div>
                                        <?php
                                        include ("../Cadastro_Login/conecta.php");  
                                             $sql_con = mysqli_query($conexao,"call casos_regiao('Confirmado','Sudeste')");
                                             $sql_con_row = mysqli_fetch_assoc($sql_con);
                                                 $sql_confirmado_sudeste = $sql_con_row['total'];
                                                 mysqli_free_result($sql_con);
                                                 mysqli_close($conexao);
                                                 include ("../Cadastro_Login/conecta.php");  
                                                 $sql_con = mysqli_query($conexao,"call casos_regiao('Recuperado','Sudeste')");
                                                 $sql_con_row = mysqli_fetch_assoc($sql_con);
                                                     $sql_recuperado_sudeste = $sql_con_row['total'];
                                                     mysqli_free_result($sql_con);
                                                     mysqli_close($conexao);                                         
                                        ?>
                                        <div class="casos_regiao">
                                            <div class="column1 column"><?= $sql_confirmado_sudeste?></div>
                                            <div class="column2 column"><?= $sql_confirmado_sudeste - $sql_recuperado_sudeste ?></div>
                                            <div class="column3 column"><?= $sql_recuperado_sudeste?></div>
                                        </div>

                                        <div class="estado_sudeste estados">
                                            <div class="estado">
                                                <div class="nome_estado">
                                                    Santa Catarina
                                                </div>
                                                <div class="casos_estado">
                                                    <div class="column1 column">32145</div>
                                                    <div class="column2 column">32145</div>
                                                    <div class="column3 column">32145</div>
                                                </div>
                                            </div>

                                            <div class="estado">
                                                <div class="nome_estado">
                                                    Paraná
                                                </div>
                                                <div class="casos_estado">
                                                    <div class="column1 column">32145</div>
                                                    <div class="column2 column">32145</div>
                                                    <div class="column3 column">32145</div>
                                                </div>
                                            </div>
                                            <div class="estado">
                                                <div class="nome_estado">
                                                    Rio Grande so Sul
                                                </div>
                                                <div class="casos_estado">
                                                    <div class="column1 column">32145</div>
                                                    <div class="column2 column">32145</div>
                                                    <div class="column3 column">32145</div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <!--Sul-->
                                    <div class="regiao">
                                        <div class="seta_regiao">
                                            <div class="seta_sul">
                                                <img src="images/seta_estado.png" alt="" width="20px" class="img_seta">
                                            </div>
                                            <div class="nome_regiao">
                                                Sul
                                            </div>
                                        </div>
                                        <?php
                                        include ("../Cadastro_Login/conecta.php");  
                                             $sql_con_sul = mysqli_query($conexao,"call casos_regiao('Confirmado','Sul')");
                                             $sql_con_row = mysqli_fetch_assoc($sql_con_sul);
                                                 $sql_confirmado_sul = $sql_con_row['total'];
                                                 mysqli_free_result($sql_con_sul);
                                                 mysqli_close($conexao);

                                                 include ("../Cadastro_Login/conecta.php");  
                                                 $sql_rec_sul = mysqli_query($conexao,"call casos_regiao('Recuperado','Sul')");
                                                 $sql_con_row = mysqli_fetch_assoc($sql_rec_sul);
                                                     $sql_recuperado_sul = $sql_con_row['total'];
                                                     mysqli_free_result($sql_rec_sul);
                                                     mysqli_close($conexao);   
                                                     include ("../Cadastro_Login/conecta.php");                                        
                                        ?>
                                        <div class="casos_regiao">
                                            <div class="column1 column"><?= $sql_confirmado_sul?></div>
                                            <div class="column2 column"><?= $sql_confirmado_sul - $sql_recuperado_sul ?></div>
                                            <div class="column3 column"><?= $sql_recuperado_sul?></div>
                                        </div>

                                        <div class="estado_sul estados">
                                            <div class="estado">
                                                <div class="nome_estado">
                                                    Santa Catarina
                                                </div>
                                                <?php
                                        include ("../Cadastro_Login/conecta.php");  
                                             $sql_con_sc = mysqli_query($conexao,"call casos_estado('Santa Catarina','Confirmado')");
                                             $sql_con_row = mysqli_fetch_assoc($sql_con_sc);
                                                 $sql_confirmado_sc = $sql_con_row['total'];
                                                 mysqli_free_result($sql_con_sc);
                                                 mysqli_close($conexao);

                                                 include ("../Cadastro_Login/conecta.php");  
                                                 $sql_rec_sc = mysqli_query($conexao,"call casos_estado('Santa Catarina','Recuperado')");
                                                 $sql_con_row = mysqli_fetch_assoc($sql_rec_sc);
                                                     $sql_recuperado_sc = $sql_con_row['total'];
                                                     mysqli_free_result($sql_rec_sc);
                                                     mysqli_close($conexao);   
                                                     include ("../Cadastro_Login/conecta.php");                                        
                                        ?>
                                                <div class="casos_estado">
                                                    <div class="column1 column"><?= $sql_confirmado_sc?></div>
                                                    <div class="column2 column"><?= $sql_confirmado_sc - $sql_recuperado_sc ?></div>
                                                    <div class="column3 column"><?= $sql_recuperado_sc?></div>
                                                </div>
                                            </div>

                                            <div class="estado">
                                                <div class="nome_estado">
                                                Rio Grande do Sul
                                                </div>
                                                <?php
                                        include ("../Cadastro_Login/conecta.php");  
                                             $sql_con_rs = mysqli_query($conexao,"call casos_estado('Rio Grande do Sul','Confirmado')");
                                             $sql_con_row = mysqli_fetch_assoc($sql_con_rs);
                                                 $sql_confirmado_rs = $sql_con_row['total'];
                                                 mysqli_free_result($sql_con_rs);
                                                 mysqli_close($conexao);

                                                 include ("../Cadastro_Login/conecta.php");  
                                                 $sql_con_rs = mysqli_query($conexao,"call casos_estado('Rio Grande do Sul','Recuperado')");
                                                 $sql_con_row = mysqli_fetch_assoc($sql_con_rs);
                                                     $sql_recuperado_rs = $sql_con_row['total'];
                                                     mysqli_free_result($sql_con_rs);
                                                     mysqli_close($conexao);   
                                                     include ("../Cadastro_Login/conecta.php");                                        
                                        ?>
                                                <div class="casos_estado">
                                                    <div class="column1 column"><?= $sql_confirmado_rs?></div>
                                                    <div class="column2 column"><?= $sql_confirmado_rs - $sql_recuperado_rs ?></div>
                                                    <div class="column3 column"><?= $sql_recuperado_rs?></div>
                                                </div>
                                            </div>
                                            <div class="estado">
                                                <div class="nome_estado">
                                                      Paraná
                                                </div>
                                                <?php
                                        include ("../Cadastro_Login/conecta.php");  
                                             $sql_con = mysqli_query($conexao,"call casos_estado('Paraná','Confirmado')");
                                             $sql_con_row = mysqli_fetch_assoc($sql_con);
                                                 $sql_confirmado_pr = $sql_con_row['total'];
                                                 mysqli_free_result($sql_con);
                                                 mysqli_close($conexao);

                                                 include ("../Cadastro_Login/conecta.php");  
                                                 $sql_con = mysqli_query($conexao,"call casos_estado('Paraná','Recuperado')");
                                                 $sql_con_row = mysqli_fetch_assoc($sql_con);
                                                     $sql_recuperado_pr = $sql_con_row['total'];
                                                     mysqli_free_result($sql_con);
                                                     mysqli_close($conexao);   
                                                     include ("../Cadastro_Login/conecta.php");                                        
                                        ?>
                                                <div class="casos_estado">
                                                    <div class="column1 column"><?= $sql_confirmado_pr?></div>
                                                    <div class="column2 column"><?= $sql_confirmado_pr - $sql_recuperado_pr ?></div>
                                                    <div class="column3 column"><?= $sql_recuperado_pr?></div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                               
                                </div>
                            </div>
                        </section>
                    </section>
                
                    <section><!--com ajuda de api sera colocado casos do coronavirus-->
                        
                    </section>
                
                
                </article><!--FIM DO ARTICLE PAINEL-->
    
                <section id="secao_perguntas"><!--secao das perguntas que os usuario poderao fazer aos médicos-->
                    <div class="medicos">
                        <img src="images/medicos.jpg" alt="medicos" width="350px">
                    </div>
                    <div class="pergunta">
                        <h2>Deixe uma pergunta a nossa equipe médica!</h2>
                        <form action="">
                            <textarea name="pergunta" rows="10" cols="40">Deixe aqui sua pergunta...
                            </textarea>
                        </form>
                    </div>
                </section>
            </section><!--Fim da secao principal-->
           
          <div class="faq" style="position:fixed;bottom:5px;right:30px">
              <img src="images/faq.png" alt="faq" class="faq_img" width="80px">
          </div>
        </section><!--Fim do container principal-->
            
<!--script para o menu barra lateral-->
        <script> 
            let btn_menu = document.querySelector("#btn_menu");
            let drop_menu = document.querySelector("#container_menu");


            btn_menu.onclick = function(){
                drop_menu.classList.toggle("active");
            }
            
        </script>

        <!--script para seta dos estados-->
        <script>
            let seta_sul = document.querySelector(".seta_sul");
            let sul = document.querySelector(".estado_sul");

            let seta_nordeste = document.querySelector(".seta_nordeste");
            let nordeste = document.querySelector(".estado_nordeste");

            let seta_centro = document.querySelector(".seta_centro");
            let centro = document.querySelector(".estado_centro");

            let seta_norte = document.querySelector(".seta_norte");
            let norte = document.querySelector(".estado_norte");

            let seta_sudeste = document.querySelector(".seta_sudeste");
            let sudeste = document.querySelector(".estado_sudeste");

            seta_sul.onclick = function(){
                sul.classList.toggle("active");
            }
            seta_nordeste.onclick = function(){
                nordeste.classList.toggle("active");
            }
            seta_norte.onclick = function(){
                norte.classList.toggle("active");
            }
            seta_sudeste.onclick = function(){
                sudeste.classList.toggle("active");
            }
            seta_centro.onclick = function(){
                centro.classList.toggle("active");
            }
        </script>
    </body>
</html>