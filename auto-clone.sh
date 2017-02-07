#! /bin/bash
projectName="lib-storage"
bitBucketSsh=""
gitHubCloneSsh="git@github.com:gokuai/"${projectName}".git"

git clone gitCloneSsh --quiet
success=$?
if [[$success -eq 0]];then
	git remote add bitbucket bitBucketSsh;
	addSuccess=$?
	if [[addSuccess -eq 0]]
	then
		git push -u bitbucket --all
	else
		echo "add remote failed";
		exit 1
	fi	
else
	echo "git clone failed";
	exit 1
fi
ff