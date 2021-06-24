<?php 
    if (!isset($PDO)) {
        require __DIR__ . '\..\..\..\..\conecta.php';
    }

    $select = $PDO->prepare('select * from estados_uf_minusculo_vw');
    $select->execute();
    $result = $select->fetchAll();

    require 'covid.api.php';

    
    $pais = getDadosPais();

    $estado = getDadosEstado($result[0]['unifedest']);
?>
<div class="d-flex" style="justify-content: space-between;">

    
    <div style="flex-grow: 1">
        <div>
            <h5 class="d-block mb-4">Corona Virus no Brasil:</h5>
            <ul class="list-group">
                <li class="list-group-item">
                    <span style="line-height: 2.1">Quantidade de Casos Confirmados: <?= $pais->{'confirmed'}?> casos.</span>
                </li>
                <li class="list-group-item">
                    <span style="line-height: 2.1">Quantidade de Casos Recuperados: <?= $pais->{'recovered'}?> casos.</span>
                </li>
                <li class="list-group-item">
                    <span style="line-height: 2.1">Quantidade de Mortes: <?= $pais->{'deaths'}?> mortes.</span>
                </li>
                <li class="list-group-item">
                    <span style="line-height: 2.1">Data Atualizada do Dados: <?= date_format(date_create($pais->{'updated_at'}), 'd/m/Y')?></span>
                </li>
            </ul>
        </div>
    </div>

    <div class="mx-4"></div>

    <div style="flex-grow: 1">
        <h5 class="d-block mb-3">Corona Virus nos Estados Brasileiros:</h5>
        <div class="d-flex mb-3" style="align-items: center;">
            <label class="ms-2">Estado:</label>
            <select class="form-select form-select-sm" id="comboEstados" aria-label=".form-select-sm example">
                <option value="<?=$result[0]['unifedest']?>" checked><?=$result[0]['desest']?></option>
                <?php for ($i = 1; $i < count($result); $i++) { ?>
                    <option value="<?=$result[$i]['unifedest']?>"><?=$result[$i]['desest']?></option>
                <?php } ?>
            </select>
        </div>

        <div>
            <ul class="list-group">
            <li class="list-group-item">
                    <span>Quantidade de Casos Confirmados: <span id="confirmados"><?= $estado->{'cases'}?></span> casos.</span>
                </li>
                <li class="list-group-item">
                    <span>Quantidade de Casos Suspeitos: <span id="suspeitos"><?= $estado->{'suspects'}?></span> casos.</span>
                </li>
                <li class="list-group-item">
                    <span>Quantidade de Casos Negativados: <span id="negativados"><?= $estado->{'refuses'}?></span> casos.</span>
                </li>
                <li class="list-group-item">
                    <span>Data Atualizada do Dados: <span id="dataAtualizada"><?= date_format(date_create($estado->{'datetime'}), 'd/m/Y')?></span></span>
                </li>
            </ul>
        </div>
    </div>
    
</div>
