function memory
    if test (uname -s) = "Darwin"
        set mem (sysctl -n hw.memsize)
        echo (math "$mem / 1024 / 1024")
    else if test (uname -s) = "Linux"
        set memkb (awk '/MemTotal/ {print $2}' /proc/meminfo)
        echo (math "$memkb / 1024")
    else
        echo 0
    end
end

