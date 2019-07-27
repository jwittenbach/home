message=$1

hexo clean; hexo generate

git add .
git commit -m \"$message\"
commit_hash=`git log --oneline | awk 'NR==1{print $1}' | xargs git rev-parse`
commit_url=https://github.com/jwittenbach/home/commits/$commit_hash

rm -rf jwittenbach.github.io/*
cp -R public/* jwittenbach.github.io/
git submodule foreach git add .
git submodule foreach git commit -m "updates content from $commit_url"
git submodule foreach git push

git add jwittenbach.github.io
git commit -a -m "updates submodule from $commit_url"
git push
