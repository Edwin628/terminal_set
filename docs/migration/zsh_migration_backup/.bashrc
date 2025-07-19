# 🚀 Bash 配置文件 - 终端体验增强版
# 作者: AI Assistant
# 描述: 提供丰富的终端体验，包括颜色、别名、历史记录等功能

# =============================================================================
# 🎨 基础设置
# =============================================================================

# 设置历史记录
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="ls:ll:cd:pwd:clear:history:exit"

# 追加历史记录而不是覆盖
shopt -s histappend

# 检查窗口大小
shopt -s checkwinsize

# 启用命令行编辑
set -o emacs

# 设置默认编辑器
export EDITOR=nano
export VISUAL=nano

# =============================================================================
# 🌈 颜色定义
# =============================================================================

# 重置颜色
RESET='\033[0m'

# 前景色
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

# 粗体前景色
BOLD_BLACK='\033[1;30m'
BOLD_RED='\033[1;31m'
BOLD_GREEN='\033[1;32m'
BOLD_YELLOW='\033[1;33m'
BOLD_BLUE='\033[1;34m'
BOLD_PURPLE='\033[1;35m'
BOLD_CYAN='\033[1;36m'
BOLD_WHITE='\033[1;37m'

# 背景色
BG_BLACK='\033[40m'
BG_RED='\033[41m'
BG_GREEN='\033[42m'
BG_YELLOW='\033[43m'
BG_BLUE='\033[44m'
BG_PURPLE='\033[45m'
BG_CYAN='\033[46m'
BG_WHITE='\033[47m'

# =============================================================================
# 🎯 提示符设置
# =============================================================================

# 设置彩色提示符
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    # SSH 连接时的提示符
    PS1="\[${BOLD_RED}\]\u\[${RESET}\]@\[${BOLD_GREEN}\]\h\[${RESET}\]:\[${BOLD_BLUE}\]\w\[${RESET}\]\$ "
else
    # 本地连接的提示符
    PS1="\[${BOLD_CYAN}\]\u\[${RESET}\]@\[${BOLD_GREEN}\]\h\[${RESET}\]:\[${BOLD_BLUE}\]\w\[${RESET}\]\$ "
fi

# 设置 PS2（多行命令提示符）
PS2="\[${YELLOW}\]>\[${RESET}\] "

# =============================================================================
# 🔧 别名定义
# =============================================================================

# 启用颜色支持
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ls 相关别名
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lsd='ls -d */'  # 只显示目录

# 安全别名
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# 导航别名
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# 系统信息别名
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias meminfo='cat /proc/meminfo'
alias cpuinfo='cat /proc/cpuinfo'

# 网络相关别名
alias myip='curl -s ifconfig.me'
alias ports='netstat -tulanp'
alias ping='ping -c 5'

# Git 相关别名
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'

# 实用工具别名
alias weather='curl -s wttr.in'
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -'
alias extract='tar -xzf'  # 解压 tar.gz 文件

# 快速编辑配置文件
alias bashrc='nano ~/.bashrc'
alias bash_profile='nano ~/.bash_profile'
alias reload='source ~/.bashrc'

# =============================================================================
# 🔍 函数定义
# =============================================================================

# 创建目录并进入
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# 查找文件
ff() {
    find . -name "*$1*" -type f
}

# 查找目录
fd() {
    find . -name "*$1*" -type d
}

# 快速备份文件
backup() {
    cp "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
    echo "已备份: $1 -> $1.backup.$(date +%Y%m%d_%H%M%S)"
}

# 显示目录大小
dus() {
    du -sh "$@" | sort -h
}

# 显示最近修改的文件
recent() {
    find . -type f -mtime -$1 -exec ls -lt {} + | head -10
}

# 显示系统信息
sysinfo() {
    echo -e "${BOLD_CYAN}系统信息:${RESET}"
    echo -e "操作系统: $(uname -s) $(uname -r)"
    echo -e "架构: $(uname -m)"
    echo -e "主机名: $(hostname)"
    echo -e "用户: $(whoami)"
    echo -e "当前目录: $(pwd)"
    echo -e "Shell: $SHELL"
    echo -e "Bash 版本: $BASH_VERSION"
}

# 显示网络连接
netstat() {
    echo -e "${BOLD_CYAN}网络连接:${RESET}"
    ss -tuln | grep LISTEN
}

# 显示进程信息
psinfo() {
    echo -e "${BOLD_CYAN}进程信息:${RESET}"
    ps aux --sort=-%cpu | head -10
}

# =============================================================================
# 🎨 欢迎信息
# =============================================================================

# 显示欢迎信息
welcome() {
    echo -e "${BOLD_CYAN}================================${RESET}"
    echo -e "${BOLD_GREEN}欢迎使用增强版 Bash!${RESET}"
    echo -e "${BOLD_CYAN}================================${RESET}"
    echo -e "当前时间: $(date)"
    echo -e "系统负载: $(uptime | awk -F'load average:' '{print $2}')"
    echo -e "可用命令: ${BOLD_YELLOW}sysinfo${RESET}, ${BOLD_YELLOW}netstat${RESET}, ${BOLD_YELLOW}psinfo${RESET}"
    echo -e "输入 ${BOLD_YELLOW}help${RESET} 查看帮助信息"
    echo -e "${BOLD_CYAN}================================${RESET}"
}

# 帮助信息
help() {
    echo -e "${BOLD_CYAN}可用命令:${RESET}"
    echo -e "${BOLD_GREEN}系统信息:${RESET}"
    echo -e "  sysinfo    - 显示系统信息"
    echo -e "  netstat    - 显示网络连接"
    echo -e "  psinfo     - 显示进程信息"
    echo -e "  weather    - 显示天气信息"
    echo -e "  myip       - 显示公网 IP"
    echo -e ""
    echo -e "${BOLD_GREEN}文件操作:${RESET}"
    echo -e "  ff <name>  - 查找文件"
    echo -e "  fd <name>  - 查找目录"
    echo -e "  backup <file> - 备份文件"
    echo -e "  extract <file> - 解压文件"
    echo -e ""
    echo -e "${BOLD_GREEN}目录操作:${RESET}"
    echo -e "  mkcd <dir> - 创建目录并进入"
    echo -e "  dus        - 显示目录大小"
    echo -e "  recent <days> - 显示最近修改的文件"
    echo -e ""
    echo -e "${BOLD_GREEN}配置:${RESET}"
    echo -e "  bashrc     - 编辑 .bashrc"
    echo -e "  reload     - 重新加载配置"
}

# =============================================================================
# 🔧 自动补全
# =============================================================================

# 启用 bash 补全
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
elif [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

# Git 补全
if [ -f /usr/share/bash-completion/completions/git ]; then
    . /usr/share/bash-completion/completions/git
fi

# =============================================================================
# 🎯 历史记录增强
# =============================================================================

# 搜索历史记录
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# 忽略重复命令
export HISTCONTROL=ignoredups:erasedups

# 保存历史记录到文件
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# =============================================================================
# 🌟 启动时执行
# =============================================================================

# 只在交互式 shell 中执行
if [[ $- == *i* ]]; then
    # 显示欢迎信息（可选，取消注释启用）
    # welcome
    
    # 设置窗口标题
    echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"
fi

# =============================================================================
# 🔧 环境变量
# =============================================================================

# 设置语言环境
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# 设置时区
export TZ='Asia/Shanghai'

# 设置 umask
umask 022

# =============================================================================
# 🎨 结束
# =============================================================================

# 显示当前目录信息（可选）
# echo -e "${CYAN}当前目录:${RESET} $(pwd)" 