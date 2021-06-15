<?php
    include("conecta.php");

    $sql = mysqli_query($conexao, "select * from usuario where email_usu='".$_POST['email']."'and senha_usu='".$_POST['password']. "'");

    $rows = mysqli_num_rows($sql);

if($rows){
    while($dados=mysqli_fetch_assoc($sql)){
        session_start();                            //ira iniciar a sessao
        $_SESSION['login'] = $dados['login_usu'];      //passara esses parametros login 
        $_SESSION['password'] = $dados['senha_usu'];    // e senha
        header("Location: ../Home/home.php");   //será direcionado para a página home
    }
}else {
 /*   header("Location: Cadastro_Login.html");*/
}
?>