<?php 
  require '../../conecta.php';

  require '../../utils/cookieHelper.php';

  $ticketAcesso = getCookie($cookieTicketAcesso);

  if (isset($ticketAcesso)) {
    $countSql = 'SELECT u.codusu, u.codgen, u.nomusu, u.datnasusu, u.logusu, ce.numcep, ci.nomcid, es.desest FROM usuario as u 
          inner join cep_endereco as ce on ce.codcepend = u.codcepend 
          inner join cidade as ci on ci.codcid = ce.codcid
          inner join estado as es on es.codest = ci.codest
          WHERE u.aceusu = :acesso';
    $qryCount = $PDO->prepare($countSql);
    $qryCount->bindParam(':acesso', $ticketAcesso, PDO::PARAM_STR);
    
    if($qryCount->execute()) {
      $cliente = $qryCount->fetchObject();
    }
  }
  
?>
<div id="conta">
  <div>
    <?= isset($ticketAcesso) ? '<h2>Editar Conta</h2>' : '<h2>Nova Conta</h2>' ?>

    <input type="hidden" value="<?= isset($cliente) ? $cliente->codusu : '' ?>" name="codigoUsuario">

    <form class="row g-3" action="./public/conta/contaFormSave.php" enctype="multipart/form-data" method="post">
      <h5 class="mt-4">Dados Pessoais</h5>
      <div class="col-3">
        <label for="nome" class="form-label">Nome:</label>
        <input type="text" class="form-control" id="nome" name="nome" value="<?= isset($cliente) ? $cliente->nomusu : '' ?>" placeholder="Nome completo do usuário...">
      </div>
      <div class="col-2">
        <label for="dataNascimento" class="form-label">Data de Nascimento:</label>
        <input type="date" class="form-control" name="dataNascimento" value="<?= isset($cliente) ? $cliente->datnasusu : '' ?>" id="dataNascimento">
      </div>
      <div class="col-2">
        <label>Gênero:</label>
        <div style="margin-top: 8px">
          <input type="radio" class="btn-check btn btn-sm" name="genero" value="1" id="masculino" autocomplete="off" style="margin-right: 10px;" <?= isset($cliente) && $cliente->codgen == 1 ? 'checked' : '' ?>>
          <label class="btn btn-secondary" for="masculino">Masculino</label>

          <input type="radio" class="btn-check btn btn-sm" name="genero" value="2" id="feminino" autocomplete="off" <?= isset($cliente) && $cliente->codgen == 2 ? 'checked' : '' ?>>
          <label class="btn btn-secondary" for="feminino">Feminino</label>
        </div>
      </div>

      <div class="col-5">
        <label for="avatar" class="form-label">Importar Avatar:</label>
        <input class="form-control" type="file" id="avatar" name="avatar" accept="image/png, image/gif, image/jpeg">
      </div>

      <div class="col-6">
        <label for="login" class="form-label">Login:</label>
        <input class="form-control" type="text" id="login" name="login" value="<?= isset($cliente) ? $cliente->logusu : '' ?>" placeholder="Identificador para logar na sua conta...">
      </div>

      <div class="col-6">
        <label for="senha" class="form-label">Senha:</label>
        <input class="form-control" type="password" id="senha" name="senha" placeholder="<?= isset($ticketAcesso) ? 'Alterar senha' : 'Senha' ?> para logar na sua conta...">
      </div>

      <hr class="mt-5">

      <h5>Endereço</h5>
      
      <div class="col-2">
        <label for="cep" class="form-label">CEP</label>
        <input type="text" class="form-control input-cep" name="cep" value="<?= isset($cliente) ? $cliente->numcep : '' ?>" id="cep" placeholder="CEP da cidade...">
      </div>

      <div class="col-5">
        <label for="cidade" class="form-label">Cidade:</label>
        <input type="text" class="form-control input-cidade" id="cidade" value="<?= isset($cliente) ? $cliente->nomcid : '' ?>" placeholder="Cidade onde mora..." readonly>
      </div>
      <div class="col-5">
        <label for="estado" class="form-label">Estado:</label>
        <input type="text" class="form-control input-estado" id="estado" value="<?= isset($cliente) ? $cliente->desest : '' ?>" placeholder="Estado onde mora..." readonly>
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

      inputCidade = $(".input-cidade");
      inputEstado = $(".input-estado");
      if (cep.length == 8) {
        $.ajax({
          method: "get",
          url: "./public/conta/cep.api.php?cep=" + cep,
          success: function(data){
            json = JSON.parse(data);
            inputCidade.val(json.nomcid);
            inputEstado.val(json.desest);
          }
        });
      } else {
        inputCidade.val('');
        inputEstado.val('');
      }


    });
  });
</script>