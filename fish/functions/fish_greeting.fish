function fish_greeting
    echo -ne '\x1b[38;5;15m'  # Set colour to white
    echo '   ______                   __'
    echo '  / __/ /__ __    _____ ___/ /'
    echo ' / _// / _ `/ |/|/ / -_) _  / '
    echo '/_/ /_/\_,_/|__,__/\__/\_,_/  '
    set_color normal
    fastfetch --key-padding-left 5
end
