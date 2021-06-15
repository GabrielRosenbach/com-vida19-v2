<?php

$dsn = 'mysql:host=localhost;dbname=comvida19'; //data source name
$servidor = "localhost";
$usuario = "root";
$senha = "";

  $conexao =  mysqli_connect($servidor,$usuario,$senha);
  $dbname = mysqli_select_db($conexao,'comvida19') ;
  

?>