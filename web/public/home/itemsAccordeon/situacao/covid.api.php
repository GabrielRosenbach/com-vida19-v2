<?php

    if (isset($_GET['uf'])) {
        echo getDadosEstadoJSON($_GET['uf']);
    }

    function getDadosEstadoJSON($estado) {
        $url = "https://covid19-brazil-api.now.sh/api/report/v1/brazil/uf/" .$estado;

        return file_get_contents($url);
    }

    function getDadosEstado($estado) {
        return json_decode(getDadosEstadoJSON($estado));
    }

    function getDadosPais() {
        $url = "https://covid19-brazil-api.now.sh/api/report/v1/brazil";

        return json_decode(file_get_contents($url))->{'data'};
    }
?>