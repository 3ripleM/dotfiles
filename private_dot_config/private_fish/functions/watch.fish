function watch --description "Repeat a command with a custom interval"
    # Sets default interval to 2 seconds if no -n flag is provided
    set -l interval 2

    if test (count $argv) -gt 1; and test $argv[1] = "-n"
        set interval $argv[2]
        set -e argv[1..2] # Removes the -n and the number from arguments
    end

    clear
    while true
        printf '\033[H'  # move cursor to top-left without clearing (no flash)
        eval $argv
        printf '\033[J'  # clear any leftover lines below the new output

        # Spinner animation during the sleep interval
        set -l spinner '⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏'
        set -l steps (math "round($interval * 10)")
        for i in (seq 1 $steps)
            set -l frame $spinner[(math "$i % 10 + 1")]
            printf "\r\033[2m%s  refreshing in %.1fs\033[0m" $frame (math "$interval - $i / 10.0")
            sleep 0.1
        end
        printf "\r\033[2K"
    end
end
