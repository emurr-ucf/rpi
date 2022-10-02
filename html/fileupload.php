<?php
header('Content-Type: text/html; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_FILES['files'])) {
        $errors = [];
        $path = '/var/www/html/';
        $extensions = ['jpg', 'jpeg', 'png', 'gif', 'mp4', 'mov', 'html', 'js'];

        $all_files = count($_FILES);

        $file_name = $_FILES['files']['name'];
        $file_tmp = $_FILES['files']['tmp_name'];
        $file_type = $_FILES['files']['type'];
        $file_size = $_FILES['files']['size'];
        $file_ext = strtolower(end(explode('.', $_FILES['files']['name'])));

        $file = $path . $file_name;

        if (!in_array($file_ext, $extensions)) {
            $errors[] = 'Extension not allowed: ' . $file_name . ' ' . $file_type;
        }

        if ($file_size > 2097152) {
            $errors[] = 'File size exceeds limit: ' . $file_name . ' ' . $file_type;
        }

        if (empty($errors)) {
            echo $file_tmp . ' ' . $file;
            move_uploaded_file($file_tmp, $file);
        }

        if ($errors) print_r($errors);
    }
}
?>

