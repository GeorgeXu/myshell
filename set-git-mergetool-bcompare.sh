#! /bin/bash
ln -s /Applications/Beyond\ Compare.app/Contents/MacOS/bcomp /usr/local/bin/bcompare;
git config --global diff.tool bc3;
git config --global difftool.bc3 trustExitCode true;
git config --global merge.tool bc3;
git config --global mergetool.bc3 trustExitCode true;
echo 'success';
exit(0);

