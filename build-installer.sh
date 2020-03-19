##!/bin/bash

echo "██ Getting current directory ... "
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR

echo "██ Moving resources ... "
cp -f -u ./vimrc ../
cp -f -u ./alias-we-vim.sh ../
cp -f -u ./we-vim.sh ../

cd ../

echo "██ Creating payload ... "
tar -cf payload.tar vimrc alias-we-vim.sh --remove-files

echo "██ Dropping payload into bash file ... "
cat payload.tar >> we-vim.sh
rm -f payload.tar

echo "██ Done"
echo "$DIR/we-vim.sh"