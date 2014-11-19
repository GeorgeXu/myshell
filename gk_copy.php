<?php

/**
 * 支持参数:
 * config   表示清理配置相关文件
 * data     表示清理数据库结构缓存
 */

$user = 'ala';
$password = 'cOO1day2GO';
$port = 27822;

$files = array(
    '/Users/george/Documents/gk_config.php'
);

$app_name = 'gokuai.com';

$cmds = array(
    'mv /home/ala/gk_config.php /var/www/'. $app_name .'/app/Conf/config.php',
    'sudo rm -rf /home/ala/www/' . $app_name . '/app/Runtime/*.php'
);

$purges = [
    'config' => 'sudo rm -rf /home/ala/www/' . $app_name . '/app/Runtime/*.php',
    'data' => 'sudo rm -rf /home/ala/www/' . $app_name . '/app/Runtime/Data/_fields/*.php',
];

if ($argc > 1) {
    for ($i = 1; $i < $argc; $i++) {
        $cmd = $purges[$argv[$i]];
        if ($cmd) {
            $cmds[] = $cmd;
        }
    }
}

$servers = array(
    '42.121.14.19',
    '42.121.121.96',
    '42.121.121.98',
    '110.76.44.54',
    '121.199.29.66',
    '121.199.11.150',
    '42.121.7.181',
);

foreach ($servers as $hostip) {
    try {
        echo 'start ' . $hostip . "\n";
        $conn = ssh2_connect($hostip, $port);
        if (!$conn) {
            echo 'fail to connect ' . $hostip . "\n";
            continue;
        }
        if (!ssh2_auth_password($conn, $user, $password)) {
            echo 'password invalid ' . $hostip . "\n";
            continue;
        }
        if ($files) {
            foreach ($files as $file) {
                if (!ssh2_scp_send($conn, $file, '/home/ala/' . basename($file))) {
                    echo 'fail to copy ' . $file . ' -> ' . $hostip . "\n";
                }
            }
        }
        if ($cmds) {
            $shell = ssh2_shell($conn, 'xterm');
            stream_set_blocking($shell, 1);
            foreach ($cmds as $cmd) {
                fwrite($shell, $cmd . PHP_EOL);
            }
            fwrite($shell, 'exit' . PHP_EOL);
            while ($line = fgets($shell)) {
                echo $line;
            }
            fclose($shell);
        }
    } catch (Exception $e) {
        echo $e->getMessage() . "\n";
    }
}

