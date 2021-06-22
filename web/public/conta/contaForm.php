<?php 
  require '../../conecta.php';

  include '../../utils/cookies/usuario/getUsuario.php';

  $countSql = "SELECT * FROM usuario WHERE id = " . $codigoUsuario;
  $qryCount = $PDO->prepare($countSql);
  $qryCount->execute();

  $cliente = $qryCount->fetchObject();
?>
<div id="conta">
  <div>
    <?= ($usuarioLogado) ? '<h2>Editar Conta</h2>' : '<h2>Nova Conta</h2>' ?>

    <form class="row g-3" action="addCliente.php" enctype="multipart/form-data" method="post">
      <h5 class="mt-4">Dados Pessoais</h5>
      <div class="col-3">
        <label for="nome" class="form-label">Nome:</label>
        <input type="text" class="form-control" id="nome" placeholder="Nome completo do usuário...">
      </div>
      <div class="col-2">
        <label for="dataNascimento" class="form-label">Data de Nascimento:</label>
        <input type="date" class="form-control" id="dataNascimento">
      </div>
      <div class="col-2">
        <label>Gênero:</label>
        <div style="margin-top: 8px">
          <input type="radio" class="btn-check btn btn-sm" name="genero" id="masculino" autocomplete="off" checked  style="margin-right: 10px;">
          <label class="btn btn-secondary" for="masculino">Masculino</label>

          <input type="radio" class="btn-check btn btn-sm" name="genero" id="feminino" autocomplete="off">
          <label class="btn btn-secondary" for="feminino">Feminino</label>
        </div>
      </div>

      <div class="col-5">
        <label for="avatar" class="form-label">Importar Avatar:</label>
        <input class="form-control" type="file" id="avatar" accept="image/png, image/gif, image/jpeg">
      </div>

      <div class="col-6">
        <label for="login" class="form-label">Login:</label>
        <input class="form-control" type="text" id="login" placeholder="Identificador para logar na sua conta...">
      </div>

      <div class="col-6">
        <label for="senha" class="form-label">Senha:</label>
        <input class="form-control" type="password" id="senha" placeholder="Senha para logar na sua conta...">
      </div>

      <hr class="mt-5">

      <h5>Endereço</h5>
      
      <div class="col-2">
        <label for="cep" class="form-label">CEP</label>
        <input type="text" class="form-control input-cep" id="cep" placeholder="CEP da cidade...">
      </div>

      <div class="col-5">
        <label for="cidade" class="form-label">Cidade:</label>
        <input type="text" class="form-control" id="cidade" placeholder="Cidade onde mora..." readonly>
      </div>
      <div class="col-5">
        <label for="estado" class="form-label">Estado:</label>
        <input type="text" class="form-control" id="estado" placeholder="Estado onde mora..." readonly>
      </div>

      <div class="col-12 mt-5" style="direction: rtl;">
        <a href="index.php" class="btn btn-outline-secondary col-3">Cancelar</a>
        <button type="submit" class="btn btn-outline-success me-3 col-3">Salvar</button>
      </div>
    </form>
  </div>
</div>

<script>
  $(document).ready(function(e) {
    $(".input-cep").mask('00000-000', {reverse: true});

    $( ".input-cep" ).keyup(function(e) {
      
      cep = e.target.value;
      cep = cep.replace('-', '');
      if (cep.length == 8) {
        $.ajax({
          method: "get",
          url: "./public/conta/getDadosCep.php?cep=" + cep,
          success: function(data){
            debugger
          }
        });
      }


    });
  });
</script>