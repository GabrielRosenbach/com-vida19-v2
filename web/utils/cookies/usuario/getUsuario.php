<?php 
    $usuarioLogado = isset($_COOKIE['usuario']);
    $codigoUsuario = $usuarioLogado ? (int)$_COOKIE['usuario'] : null;
?>