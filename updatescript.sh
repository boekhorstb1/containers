git remote add upstream https://github.com/maintaina/containers.git
git fetch upstream
git switch master
git rebase upstream/master
git push --force origin master
