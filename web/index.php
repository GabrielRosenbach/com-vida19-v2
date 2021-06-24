<?php 
  require 'conecta.php';

  require 'utils/cookieHelper.php';

  $ticketAcesso = getCookie($cookieTicketAcesso);
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>COM VIDA 19</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-grid.min.css">
    <link rel="stylesheet" href="css/bootstrap-grid.rtl.min.css">
    <link rel="stylesheet" href="css/bootstrap-reboot.min.css">
    <link rel="stylesheet" href="css/bootstrap-reboot.rtl.min.css">
    <link rel="stylesheet" href="css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="css/bootstrap-utilities.min.css">
    <link rel="stylesheet" href="css/bootstrap-utilities.rtl.min.css">
    <link rel="stylesheet" href="css/bootstrap.rtl.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<?php
  require 'navbar.php';
?>
<main class="container mb-5" style="min-height: 500px;">
<?php
  require 'public/home/home.php';
?>
</main>
<hr>
<footer class="container" style="min-height: 40px;">
  Programação web @ 2021
</footer>

<div id="myModal" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
</div>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script>
  window.jQuery || document.write('<script src="js/jquery-1.11.2.min.js"><\/script>')
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.10/jquery.mask.min.js"></script>
<script src="https://kit.fontawesome.com/990feebce6.js" crossorigin="anonymous"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>
<script src="js/troca.js"></script>

</body>

</html>