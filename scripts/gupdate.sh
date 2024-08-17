#!/run/current-system/sw/bin/bash

if [[ $1 = "mac" ]];then
  cd /Users/arkannon/.config/nixos/
elif [[ $1 = "*" ]];then
  cd $1
else
  cd /etc/nixos/
fi

git add .
echo "What to label the commit?: "
read commit
git commit -m "$commit"
echo "Good to push? [y/N] "
read confirm

if [ "$confirm" = Y ] || [ "$confirm" = y ];then  
  git push
  exit
else
  echo "Not pushing commit, closing"
fi
