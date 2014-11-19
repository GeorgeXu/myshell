#! /bin/bash
#
#更新bitbucket项目
#
#

# 配置项目的路径

projectDirs=("/Users/george/project/yunku");
function showError()
{
	echo "!!!!!!!!!!error!!!!!!!!!: "${1};	
}

for i in ${!projectDirs[@]};do
	projectDir=${projectDirs[$i]}
	echo "----------start refresh "${projectDir}"----------";
	if [[ -d "$projectDir" ]]; then
		cd ${projectDir}"/";
		bitBucketRemote=$(git config --get remote.bitbucket.url);
		if [[ ! $? -eq 0 ]]; then
			showError "remote bitbucket not find";
			exit 1;
		fi
		echo "-----stash branch "${arrTemp[1]}" in case uncommit change-----";
		git stash;
		branches=$(git branch -r);
		if [[ $? -eq 0 ]]; then
			for branch in ${branches[@]};do
				arrTemp=(${branch//\// });
				echo "====="$branch"=====";
				if [[ "${arrTemp[0]}"x = "origin"x ]]; then
					if [[ "${arrTemp[1]}"x != "HEAD"x ]]; then
							echo "-----start checkout branch "${arrTemp[1]}"-----";
					git checkout -B ${arrTemp[1]};
					if [[ $? -eq 0 ]]; then
						git pull origin ${arrTemp[1]} -q;
						if [[ $? -eq 0 ]]; then
							git push bitbucket ${arrTemp[1]} -q;
						else
							showError "pull branch "${branch}" failed";
							exit 1;
						fi
					else
						showError "checkout branch "${branch}" failed";
						exit 1;
					fi
					fi
					
				else
					echo "not =";	
				fi
			done
		else
			showError $projectDir
			exit 1;
		fi
	else
		showError ${projectDir}" is not a dir";
		exit 1;
	fi
done	