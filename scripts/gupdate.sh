#!/run/current-system/sw/bin/bash

cd /etc/nixos/
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
