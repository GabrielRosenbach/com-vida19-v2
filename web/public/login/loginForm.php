<?php 
  require '../../conecta.php';

  include '../../utils/cookies/usuario/getUsuario.php';

  $countSql = "SELECT * FROM usuario WHERE id = " . $codigoUsuario;
  $qryCount = $PDO->prepare($countSql);
  $qryCount->execute();

  $cliente = $qryCount->fetchObject();
?>
<h2 class="mb-3">Efetuar Login</h2>

<form class="row g-3" action="addCliente.php" enctype="multipart/form-data" method="post">
  <div class="col-6">
    <label for="login" class="form-label">Login:</label>
    <input class="form-control" type="text" id="login" placeholder="Identificador para logar na sua conta...">
  </div>

  <div class="col-6">
    <label for="senha" class="form-label">Senha:</label>
    <input class="form-control" type="password" id="senha" placeholder="Senha para logar na sua conta...">
  </div>

  <div class="col-12 mt-4" style="text-align: center;">
    <button type="submit" class="btn btn-outline-success col-3 me-1">Entrar</button>
    <a href="index.php" class="btn btn-outline-secondary col-3 ms-1">Cancelar</a>
  </div>
</form>