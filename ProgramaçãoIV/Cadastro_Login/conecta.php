<?php

$dsn = 'mysql:host=localhost;dbname=comvida19'; //data source name
$servidor = "localhost";
$usuario = "dev";
$senha = "PAS51#@22RD";

  $conexao =  mysqli_connect($servidor,$usuario,$senha);
  $dbname = mysqli_select_db($conexao,'comvida19') ;
  

?>