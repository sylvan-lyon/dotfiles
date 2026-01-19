use smart-commands.nu  [ 'smart archive' ]

def main [ format: string, ...file: string ] {
    smart archive $format ...$file
}
