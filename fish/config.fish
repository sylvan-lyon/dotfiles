
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /d/scoop/apps/miniconda3/current/Scripts/conda.exe
    eval /d/scoop/apps/miniconda3/current/Scripts/conda.exe "shell.fish" "hook" $argv | source
else
    if test -f "D:\scoop\apps\miniconda3\current/etc/fish/conf.d/conda.fish"
        . "D:\scoop\apps\miniconda3\current/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "D:\scoop\apps\miniconda3\current/bin" $PATH
    end
end
# <<< conda initialize <<<

