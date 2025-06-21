<?php
// $table = 'product_siswa'; // ganti sesuai kebutuhan
// $url = "https://allend.site/other/akses.php?$table";

// $response = file_get_contents($url);

// // Cek apakah berhasil
// if ($response === FALSE) {
//     die("Gagal mengambil data dari server");
// }

// // Ubah ke array PHP
// $data = json_decode($response, true);

// // Tampilkan semua data
// if ($data && $data['success'] === true) {
//     echo "<h2>Tabel: {$data['table']}</h2>";
//     echo "<pre>" . print_r($data['data'], true) . "</pre>";
// } else {
//     echo "Gagal: " . ($data['message'] ?? 'Tidak diketahui');
// }


// Akses semua data

$url = "https://allend.site/other/akses.php";

$response = file_get_contents($url);

if ($response === FALSE) {
    die("Gagal mengambil data dari server");
}

$data = json_decode($response, true);

if ($data && $data['success'] === true) {
    foreach ($data['data'] as $tableName => $tableData) {
        echo "<h2>Tabel: {$tableName}</h2>";
        echo "<pre>" . print_r($tableData, true) . "</pre>";
    }
} else {
    echo "Gagal: " . ($data['message'] ?? 'Tidak diketahui');
}
