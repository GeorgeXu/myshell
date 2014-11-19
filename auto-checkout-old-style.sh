#! /bin/bash
filePath=("app/Lib/Action/MountAction.class.php" "app/Tpl/default/Mount/file_main.html" "app/Tpl/default/Mount/header.html" "app/Tpl/default/Mount/header_old.html" "app/Tpl/default/Mount/index.html" "app/Tpl/default/Org/index.html" "web/Static/css/backup_v1.css" "web/Static/css/bootstrap.css" "web/Static/css/common.css" "web/Static/css/icon.css" "web/Static/css/mount.css" "web/Static/js/lib/file.js" " web/Static/js/mount.js");
commitsha="2f8ecfeac73f9e7528a3ec342b1e96b5dfa808e5";
for i in ${!filePath[@]};do
	git checkout ${commitsha} -- ${filePath[$i]};
done;	