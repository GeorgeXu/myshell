#! /bin/bash
projectName="$1"
bitBucketSsh="$2"
gitHubCloneSsh="git@github.com:gokuai/"${projectName}".git"

dirName=${projectName}"/"
cd $dirName;
val=$(git config --get remote.origin.url)
if [[ "$val"x = "$gitHubCloneSsh" ]]; then
git pull origin
exitcode=$?
	if [[ $exitcode -eq 0]]; then
		git remote add bitbucket bitBucketSsh;
		addSuccess=$?
		if [[$addSuccess -eq 0]];then
			git push -u bitbucket --all
		else
			echo "add remote failed";
			exit 1
		fi	
	else
		echo "git pull failed";
		exit 1;
	fi
else

fi
