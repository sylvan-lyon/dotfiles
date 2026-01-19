def supported_format [] {[
    "7z",
    "tar.bz2",
    "tbz2",
    "tar.gz",
    "tgz",
    "tar.xz",
    "txz",
    "wim",
    "zip"
]}

def strip-to-stem [file_name: string] {
    $file_name | str replace --regex --all '\.(\w*)' ''
}

def theoretically-stem [files: list<string>] {
    match ($files | length) {
        0 => {
            error make {
                msg: $"(ansi red_bold)[ERROR](ansi reset) 没有文件输入!"
                label: {
                    text: "此处应有一些文件作为输入",
                    span: (metadata $files).span
                }
            }
        },
        1 => (strip-to-stem ($files | first)),
        _ => ($env.PWD | path parse | get stem)
    }
}

def find-available-name [extension: string, files: list<string>] {
    # 获取基础名称
    let basename = theoretically-stem $files
    # 获取不重名的文件名
    mut archive_name = $"($basename).($extension)"
    if ($archive_name | path exists) {
        mut count = 1
        while ($archive_name | path exists) {
            $archive_name = $"($basename)-($count).($extension)"
            print $"(ansi yellow_bold)[WARNING](ansi reset) 存在同名冲突, 尝试重命名为 ($archive_name)"
            $count += 1
        }
    }
    $archive_name
}

def run-7z [
    ...args: string
] {
    let data = (^7z ...$args)
    let op = match ($args | first) {
        "a" => "压缩",
        "e" | "x" => "解压",
        _ => "操作"
    }
    match $env.LAST_EXIT_CODE {
        0 => (print $"(ansi green_bold)[INFO](ansi reset) 成功完成($op)!"),
        1 => (print $"(ansi yello_bold)[WARNING](ansi reset) ($op)完成! 但有一个警告, 请检查上面 7z 的输出"),
        2 => (print $"(ansi red_bold)[FATAL](ansi reset) ($op)失败! 请检查 7z 的输出"),
        7 => (print $"(ansi red_bold)[FATAL](ansi reset) ($op)失败! 命令行错误!"),
        255 => (print $"(ansi red_bold)[ERROR](ansi reset) 您已取消($op)!")
    }
    if ($args | any {|elt| $elt == '-so'}) {
        $data
    }
}

# 智能压缩
export def "smart archive" [
    format: string@supported_format,  # 要创建的压缩文件的格式, 接受的值为 zip wim 7z tar.gz tar.xz tar.bz2 tgz txz tbz2
    ...files: string                  # 要压缩的所有文件
] {
    try {
        let archive_name = find-available-name $format $files
        match $format {
            "zip" | "wim" | "7z" => {        
                run-7z a $archive_name ...$files
            },
            "tar.gz" | "tar.xz" | "tar.bz2" | "tgz" | "txz" | "tbz2" => {
                run-7z "a" "-so" $"(random chars --length 16).tar" ...$files | run-7z "a" "-si" ($archive_name | path expand)
            },
            _ => {
                error make {
                    msg: $"(ansi red_bold)[ERROR](ansi reset) 不支持此类型的压缩: ($format)"
                }
            }
        }
    } catch { |err|
        print $err.msg
    }
}

# 智能解压
export def "smart extract" [
    file: string                      # 要解压的文件
] {
    let tmp = mktemp --tmpdir smart-extract-tmp.XXX --tmpdir-path . -d
    run-7z "x" $file $"-o($tmp)"

    # 切换到解压产生的目录中
    cd $tmp
    let file_list = ls
    match ($file_list | length) {
        1 => {
            let inode = ($file_list | first)
            if $inode.type == "file" and ($inode.name | str ends-with '.tar') {
                print $"(ansi green_bold)[INFO](ansi reset) 这个压缩文件使用 tar 打包后再压缩, tar 文件名: ($inode.name), 正在为你自动解压"
                run-7z "x" $inode.name # 把这个 tar 包打开
                print $"(ansi green_bold)[INFO](ansi reset) 正在删除上述的 tar 文件"
                rm $inode.name         # 删除这个 tar 中间文件
                                
                cd .. # 返回上一级, 重命名为 tar 文件的文件名
                let available_name = find-available-name "" [$inode.name]
                mv $tmp $available_name
            } else if $inode.type == "dir" {
                print $"(ansi green_bold)[INFO](ansi reset) 这个压缩文件中只有一个文件夹, 正在尝试提取"

                cd .. # 返回上一级, 查看可用的文件夹名称, 移出来并删除中间文件夹
                let available_name = find-available-name "" [$inode.name]
                mv $"($tmp)/($inode.name)" $".($available_name)"
                rm -rf $tmp
            }
        },
        _ => {
            cd ..
            let available_name = find-available-name "" [(strip-to-stem $file)]
            mv $tmp $available_name
        }
    }
}
