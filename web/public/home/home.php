<?php
  if (isset($PDO)) {
    require __DIR__ . '\..\..\conecta.php';
  }
?>
<div class="accordion" id="accordionExample">
  <?php 
    if (isset($ticketAcesso)) {
      $select = $PDO->prepare('select admusu from usuario where aceusu = :ticket');
      $select->bindParam('ticket', $ticketAcesso);
      $select->execute();
      $result = $select->fetchObject();
      if (!$result->admusu) {
  ?>
    <div class="accordion-item">
      <h2 class="accordion-header" id="headingOne">
        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
          Prontuários Cadastrados
        </button>
      </h2>
      <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
        <div class="accordion-body">
          <?php require __DIR__ .'\..\..\private\home\itemsAccordeon\prontuarios\prontuariosUsuario.php'  ?>  
        </div>
      </div>
    </div>
  <?php } else { ?>
    <div class="accordion-item">
      <h2 class="accordion-header" id="headingTwo">
        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
          Prontuários Cadastrados
        </button>
      </h2>
      <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
          <div class="accordion-body">
          <?php require __DIR__ .'\..\..\private\home\itemsAccordeon\prontuarios\prontuariosAdministrador.php'  ?>  
          </div>
      </div>
    </div>
  <?php }} ?>
  <div class="accordion-item">
    <h2 class="accordion-header" id="headingThree">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
        Dados do Corona Virus no Brasil
      </button>
    </h2>
    <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
      <div class="accordion-body">
        <?php require 'itemsAccordeon/situacao/situacao.php' ?>
      </div>
    </div>
  </div>
</div>