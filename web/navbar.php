<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" onClick="abrirPag('public/home/home.php');" href="#">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" onClick="abrirPag('public/conta/contaForm.php');" href="#"><?= isset($ticketAcesso) ? 'Conta' : 'Cadastrar' ?></a>
        </li>
        <?php 
          if (!isset($ticketAcesso)) {
        ?>
          <li class="nav-item">
            <a class="nav-link" onClick="abrirPag('public/login/loginForm.php');" href="#">Login</a>
          </li>
        <?php 
          } else {
        ?>
          <li class="nav-item">
            <a class="nav-link" onClick="abrirPag('private/prontuario/prontuarioForm.php');" href="#">Prontuário</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="utils/cookieHelper.php?sair=true">Sair</a>
          </li>
        <?php 
          }
        ?>
      </ul>
    </div>
  </div>
</nav>