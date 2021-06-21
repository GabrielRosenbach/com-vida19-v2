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
            
        ?>
    <body>
        
        <section id="container_principal">
            <header id="container_menu">


               <div class="container_logo">
                   <div class="logo">Comvida19</div>
                   <div class="botao_menu" ><img src="images/botao_menu.png" width="20px" id="btn_menu" ></div>
               </div>
               
               <div class="container_perfil_lista">
                    <div class="container_perfil">
                        <div class="foto_perfil">
                        <img src="../Perfil/avatar_fem.png" alt="" width="155px">
                        </div>
                        <div class="informacao_perfil">
                            <div class="perfil_nome">
                                <span class="informacao"><?= $_SESSION['login']; ?></span>
                            </div>
                            <div class="perfil_informacao">
                                <span class="informacao">Idade: </span>
                                <span class="informacao">Peso: </span>
                            </div>
                            <div class="perfil_informacao">
                                <span class="informacao">Genero: </span>
                                <span class="informacao">Altura: </span>
                            </div>

                        </div>
                    </div>

                    <div class="menu">
                        <ul>
                            <li>
                                <a href="../Perfil/perfil.html">
                                    <i class='bx bxs-user' ></i>
                                    <span class="links_nome">Acessar meu perfil</span>
                                </a>
                                <span class="tooltip">Meu perfil</span>
                            </li>
                            <li>
                                <a href="#">
                                    <i class='bx bx-message-alt-detail' ></i>
                                    <span class="links_nome">Acessar meu perfil</span>
                                </a>
                                <span class="tooltip">Acessar meu perfil</span>
                            </li>
                            <li>
                                <a href="#">
                                    <i class='bx bxs-user' ></i>
                                    <span class="links_nome">Acessar meu perfil</span>
                                </a>
                                <span class="tooltip">Acessar meu perfil</span>
                            </li>
                            <li>
                                <a href="#">
                                    <i class='bx bxs-user' ></i>
                                    <span class="links_nome">Acessar meu perfil</span>
                                </a>
                                <span class="tooltip">Acessar meu perfil</span>
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
                              $sql_sus =  mysqli_num_rows(mysqli_query($conexao,"select * from paciente p inner join status s on p.cod_status = s.cod_status where s.des_status = 'Suspeito'"));   
                            ?>
                            <h2>Casos suspeitos</h2>
                            <div><?=  ($sql_sus); ?></div>
                        </div>
                        <div class="cards">
                            <?php
                              $sql_con = mysqli_num_rows(mysqli_query($conexao,"select * from paciente p inner join status s on p.cod_status = s.cod_status where s.des_status = 'Confirmado'"));
                            ?>
                            <h2>Casos confirmados</h2>
                            <div><?= ($sql_con); ?></div>
                        </div>  
                        <div class="cards">
                            <?php
                              $sql_rec =  mysqli_num_rows(mysqli_query($conexao,"select * from paciente p inner join status s on p.cod_status = s.cod_status where s.des_status = 'Recuperado'"));   
                            ?>
                            <h2>Casos recuperados</h2>
                            <div><?= ($sql_rec);?></div>
                        </div>
                        <div class="cards">
                            <h2>Casos Ativos</h2>
                            <div><?= (($sql_con)-($sql_rec));?></div>
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
                                            <div class="column1 column">32145</div>
                                            <div class="column2 column">32145</div>
                                            <div class="column3 column">32145</div>
                                        </div>
                                    </div>
                                    <!--Norte-->
                                    <div class="regiao">
                                        <div class="seta_regiao">
                                            <div class="seta_norte">
                                                <img src="images/seta_estado.png" alt="" width="20px">
                                            </div>
                                            <div class="nome_regiao">
                                                Norte
                                            </div>
                                        </div>
                                        <div class="casos_regiao">
                                            <div class="column1 column">32145</div>
                                            <div class="column2 column">32145</div>
                                            <div class="column3 column">32145</div>
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
                                                <img src="images/seta_estado.png" alt="" width="20px">
                                            </div>
                                            <div class="nome_regiao">
                                                Nordeste
                                            </div>
                                        </div>
                                        <div class="casos_regiao">
                                            <div class="column1 column">32145</div>
                                            <div class="column2 column">32145</div>
                                            <div class="column3 column">32145</div>
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
                                                <img src="images/seta_estado.png" alt="" width="20px">
                                            </div>
                                            <div class="nome_regiao">
                                                Centro-Oeste
                                            </div>
                                        </div>
                                        <div class="casos_regiao">
                                            <div class="column1 column">32145</div>
                                            <div class="column2 column">32145</div>
                                            <div class="column3 column">32145</div>
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
                                                <img src="images/seta_estado.png" alt="" width="20px">
                                            </div>
                                            <div class="nome_regiao">
                                                Sudeste
                                            </div>
                                        </div>
                                        <div class="casos_regiao">
                                            <div class="column1 column">32145</div>
                                            <div class="column2 column">32145</div>
                                            <div class="column3 column">32145</div>
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
                                                <img src="images/seta_estado.png" alt="" width="20px">
                                            </div>
                                            <div class="nome_regiao">
                                                Sul
                                            </div>
                                        </div>
                                        <div class="casos_regiao">
                                            <div class="column1 column">32145</div>
                                            <div class="column2 column">32145</div>
                                            <div class="column3 column">32145</div>
                                        </div>

                                        <div class="estado_sul estados">
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
           <aside id="container_lateral">
               asdasdsd
           </aside>
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