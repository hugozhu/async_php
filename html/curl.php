<?php


    function fetch_page($url, $timeout = 5) {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
        $data = curl_exec($ch);
        curl_close($ch);
        return $data;
    }

    echo "Before Dispatch";

    echo fetch_page("http://hsf1.test.cnz.alimama.com/30ms.php");

    echo "After Dispatch";

