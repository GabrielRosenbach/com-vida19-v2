<?php 

    $cookieTicketAcesso = 'ticketAcesso';

    if (isset($_GET['sair'])) {
        removeCookie($cookieTicketAcesso);
        header("Refresh: 0; url=../index.php");
    }
    
    function removeCookie($cookie) {
        unset($_COOKIE[$cookie]);
        setcookie($cookie, null, -1, '/');
    }

    
    function addCookie($cookie, $valor) {
       setcookie($cookie, $valor, 0, '/');
    }

    function getCookie($cookie) {
        return isset($_COOKIE[$cookie]) ? $_COOKIE[$cookie] : null;
    }
?>