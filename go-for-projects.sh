#! /bin/bash
projects=("fengcloud" "gokuai.com" "yunku");
bitbuckets=("test1" "test2" "test3");
for i in ${!projects[@]};do
	if [[ -d ${projects[$i]} ]]; then
		./myshell/auto-push.sh ${projects[$i]} ${bitbuckets[$i]};
		echo "return val is "$?;
		if [[ $? -eq 40401 ]]; then
			./myshell/auto-clone.sh ${projects[$i]} ${bitbuckets[$i]} ${projects[$i]}"-1";
		fi
	else
		./myshell/auto-clone.sh ${projects[$i]} ${bitbuckets[$i]};
	fi
done;