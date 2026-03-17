#! /usr/bin/env bash
if ! command -v stow > /dev/null; then
    echo '`stow` is not installed!'
    exit 1
fi

cd config
echo 'depolying configuration...'

for folder in `ls`
do
    stow $folder -t $HOME
done

echo "done!"
