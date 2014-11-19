#! /bin/bash
dir="~/project/myblog";
if [[ -d "$dir" ]]; then
	echo "is dir";
else
	echo "not dir";
fi
d="bitbucket"
b="origin";
if [[ "$d" = "$b" ]]; then
echo 2;
else
echo 0;
fi