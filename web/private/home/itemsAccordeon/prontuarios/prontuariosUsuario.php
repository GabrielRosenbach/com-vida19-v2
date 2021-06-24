<?php 
    if (!isset($PDO)) {
        require __DIR__ . '\..\..\..\..\conecta.php';
    }

    if (!isset($ticketAcesso)) {
        require __DIR__ . '\..\..\..\..\utils\cookieHelper.php';

        $ticketAcesso = getCookie($cookieTicketAcesso);
    }

    $select = $PDO->prepare('select * from buscar_prontuarios_usuario(:ticket)');
    $select->bindParam(':ticket', $ticketAcesso);
    $select->execute();
?>
<div class="d-flex" style="flex-direction: column; align-items: center;"> 
    <h5 class="mb-3">Prontuários Cadastrados</h5>
    <table class="table table-bordered">
        <tr>
            <th>Data de Cadastro</th>
            <th>Resposta do Sistema</th>
        </tr>
        <?php 
            if ($select->fetchObject()) {
                while ($prontuario = $select->fetch(PDO::FETCH_ASSOC)) {
                $date = DateTime::createFromFormat('Y-m-d', $prontuario['datcadpro']); 
        ?>
            <tr>
                <td><?= $date->format('d/m/Y')?></td>
                <td><?= $prontuario['desstapro']?></td>
            </tr>
        <?php }} else { ?>
            <tr>
                <td colspan="2" style="text-align: center;">Sem Dados</td>
            </tr>
        <?php } ?>
    </table>
    
</div>
