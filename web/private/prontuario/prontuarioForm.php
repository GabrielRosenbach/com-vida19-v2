<?php 
  require '../../conecta.php';

  $sqlSintomas = "SELECT * FROM sintoma";
  $qrySintomas = $PDO->prepare($sqlSintomas);
  $qrySintomas->execute();

  $countSql = "SELECT * FROM usuario WHERE id = " . $codigoUsuario;
  $qryCount = $PDO->prepare($countSql);
  $qryCount->execute();

  $cliente = $qryCount->fetchObject();
?>
<div id="conta">
    <div>
        <?= false ? '<h2>Dados do Prontuário</h2>' : '<h2>Novo Prontuário</h2>' ?>

        <form class="row g-3 mt-4" action="addCliente.php" enctype="multipart/form-data" method="post" style="text-align: center !important;">

        <?php while ($sintoma = $qrySintomas->fetch(PDO::FETCH_ASSOC)) { 
            $identificadorSintoma = 'sintoma-'. $sintoma['codsin']; 
            $identificadorIntensidade = 'intensidade-'. $sintoma['codsin'];
            ?>
            <div class="col-5 grupo mx-auto" style="display: flex; flex-direction: row; align-items: center;">
                <div class="form-check form-switch " style="padding-left: 0px !important;">
                    <input class="form-check-input" type="checkbox" id="<?= $identificadorSintoma ?>" value="<?= $sintoma['codsin'] ?>">
                    <label class="form-check-label" style="white-space: nowrap;" for="<?= $identificadorSintoma ?>"><?= $sintoma['dessin'] ?>:</label>
                </div>
                
                <label class="form-check-label d-inline-block" style="margin: 0 10px 0 30px;" for="<?= $identificadorIntensidade ?>">Intensidade:</label>
                <select class="form-select form-select-sm" style="width: 100%;" aria-label=".form-select-sm" id="<?= $identificadorIntensidade ?>">
                    <option value="1" selected>Leve</option>
                    <option value="2">Moderada</option>
                    <option value="3">Elevada</option>
                </select>
            </div>
        <?php } ?>    

            <div class="col-12 mt-5" style="direction: rtl;">
                <a href="index.php" class="btn btn-outline-secondary col-3">Cancelar</a>
                <button type="submit" class="btn btn-outline-success me-3 col-3">Salvar</button>
            </div>
        </form>
    </div>
</div>