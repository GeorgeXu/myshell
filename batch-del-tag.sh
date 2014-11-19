#! /bin/bash
#
#删除本地和远程的所有tag
#
#

tags=$(git tag --list);
for tag in ${tags[@]};do
	echo "====="$tag"=====";
	git tag -d ${tag};
	git push origin --delete tag ${tag};
done;