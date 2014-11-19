#! /bin/bash
projectName="$1"
bitBucketSsh="$2"
gitHubCloneSsh="git@github.com:gokuai/"${projectName}".git"
dirName=${projectName}"/"

cd $dirName;
val=`git config --get remote.origin.url`
if [[ $? -eq 0 ]]; then
	if [[ "$val"x = "$gitHubCloneSsh"x ]]; then
		git pull origin master
		exitcode=$?
		echo "exitcode is "${exitcode};
		if [[ $exitcode -eq 0 ]]; then
			git remote add bitbucket "$bitBucketSsh";
			addSuccess=$?
			echo "addSuccess is" ${addSuccess};
			if [[ $addSuccess -eq 0 ]];then
				git push -u bitbucket --all
				pushcode=$?
				if [[ $pushcode -eq 0 ]]; then
					echo "push to bitbucket success";
				else
					echo "push to bitbucket failed";		
				fi
			else
				echo "add remote failed";
				exit 1
			fi	
		else
			echo "git pull failed";
			exit 1;
		fi
	else
		echo "not the right project";
		exit 40401;
	fi
else
	echo "not a git dir";
	exit 40401;
fi
