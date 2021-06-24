<?php 
    if (!isset($PDO)) {
        require __DIR__ . '\..\..\..\..\conecta.php';
    }

    if (!isset($ticketAcesso)) {
        require __DIR__ . '\..\..\..\..\utils\cookieHelper.php';

        $ticketAcesso = getCookie($cookieTicketAcesso);
    }

    $select = $PDO->prepare('select * from buscar_prontuarios_vw');
    $select->execute();

    $count = $PDO->prepare('select count(1) as total from buscar_prontuarios_vw');
    $count->execute();
?>
<div class="d-flex" style="flex-direction: column; align-items: center;"> 
    <h5 class="mb-3">Prontuários Cadastrados</h5>
    <table class="table table-bordered">
        <tr>
            <th>Nome do Usuário</th>
            <th>Idade do Usuário</th>
            <th>Gênero do Usuário</th>
            <th>Cidade Onde Mora</th>
            <th>Estado Onde Mora</th>
            <th>Data de Cadastro</th>
            <th>Resposta do Sistema</th>
        </tr>
        
        <?php 
            if ($count->fetchObject()->total > 0) {
                while ($prontuario = $select->fetch(PDO::FETCH_ASSOC)) {
                $date = DateTime::createFromFormat('Y-m-d', $prontuario['datcadpro']); 
        ?>
            <tr>
                <td><?= $prontuario['nomusu']?></td>
                <td><?= $prontuario['idausu']?></td>
                <td><?= $prontuario['desgen']?></td>
                <td><?= $prontuario['nomcid']?></td>
                <td><?= $prontuario['unifedest']?></td>
                <td><?= $date->format('d/m/Y')?></td>
                <td><?= $prontuario['desstapro']?></td>
            </tr>
        <?php }} else { ?>
            <tr>
                <td colspan="7" style="text-align: center;">Sem Dados</td>
            </tr>
        <?php } ?>
    </table>
    
</div>
