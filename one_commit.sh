NOW=$(date)
THIS_DIR=$(pwd)

git config credential.helper store

echo "Starting commit"
git pull
git add .
git commit -m "automated commit at $NOW from $THIS_DIR"
git push
echo "Finished commit"