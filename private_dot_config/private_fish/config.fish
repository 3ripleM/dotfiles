if status is-interactive
    # Commands to run in interactive sessions can go here
end

# macOS-specific paths and tools
if test (uname) = "Darwin"
    eval "$(/opt/homebrew/bin/brew shellenv)"

    alias "mux"="tmuxinator"

    fish_add_path /opt/homebrew/opt/ruby/bin

    set -x ANDROID_HOME $HOME/Library/Android/sdk
    fish_add_path $ANDROID_HOME/emulator
    fish_add_path $ANDROID_HOME/platform-tools
    fish_add_path $ANDROID_HOME/tools
    fish_add_path $ANDROID_HOME/tools/bin

    set -x JAVA_HOME /Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

    fish_add_path /opt/podman/bin

    set -x GEM_HOME (ruby -e 'puts Gem.user_dir' 2>/dev/null)
    if test -n "$GEM_HOME"
        fish_add_path $GEM_HOME/bin
    end

    # tmuxinator helper: symlink repo tmuxinator configs to ~/.tmuxinator if missing
    if not test -e $HOME/.tmuxinator
        if test -d $HOME/Documents/Projects/dotenv/private_dot_config/tmuxinator
            ln -s $HOME/Documents/Projects/dotenv/private_dot_config/tmuxinator $HOME/.tmuxinator
        end
    end
end

fzf --fish | source

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

