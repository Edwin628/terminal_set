# 🐚 Bash 插件使用指南

本指南介绍如何在 Bash 中实现类似 Zsh 插件的功能。

## 📋 概述

虽然 Bash 的插件生态系统不如 Zsh 丰富，但通过一些工具和配置，我们可以实现类似的功能：

- **自动补全** (类似 zsh-completions)
- **历史搜索** (类似 zsh-history-substring-search)
- **模糊搜索** (类似 zsh-autosuggestions)
- **目录跳转** (类似 zsh-autojump)
- **语法高亮** (类似 zsh-syntax-highlighting)

## 🚀 快速安装

### 一键安装
```bash
./scripts/install/install_bash_plugins.sh
```

### 手动安装
```bash
# 1. 安装基础工具
brew install fzf ripgrep bat fd tree htop bash-completion@2

# 2. 安装 bash-preexec
curl -L https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o ~/.bash-preexec.sh

# 3. 安装 Git 自动补全
curl -L https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

# 4. 应用配置
cp configs/shell/.bashrc_enhanced ~/.bashrc_enhanced
source ~/.bashrc_enhanced
```

## 🔧 功能详解

### 1. 自动补全 (类似 zsh-completions)

**功能**: 提供智能的命令和参数补全

**安装**:
```bash
# macOS
brew install bash-completion@2

# Ubuntu/Debian
sudo apt install bash-completion

# CentOS/RHEL
sudo yum install bash-completion
```

**使用**:
- 输入命令时按 `Tab` 键补全
- 支持 Git、Docker 等工具的自动补全

### 2. 历史搜索 (类似 zsh-history-substring-search)

**功能**: 使用上下箭头搜索历史命令

**配置**:
```bash
# 在 .bashrc 中添加
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'
```

**使用**:
- 输入部分命令后按上下箭头搜索历史
- `Ctrl+P/Ctrl+N` 也可以搜索历史

### 3. 模糊搜索 (类似 zsh-autosuggestions)

**功能**: 使用 fzf 实现模糊搜索

**安装**:
```bash
# 安装 fzf
brew install fzf  # macOS
sudo apt install fzf  # Ubuntu
```

**配置**:
```bash
# 历史命令搜索
bind '"\C-r": "\C-x1\e^\er"'
bind -x '"\C-x1": __fzf_history';

__fzf_history() {
    __ehc $(history | fzf --tac --tiebreak=index | perl -ne 'm/^\s*([0-9]+)/ and print "!$1"')
}
```

**使用**:
- `Ctrl+R`: 搜索历史命令
- `Ctrl+T`: 搜索目录
- `Ctrl+F`: 搜索文件

### 4. 目录跳转 (类似 zsh-autojump)

**功能**: 快速跳转到常用目录

**实现**:
```bash
j() {
    if [ -z "$1" ]; then
        cd ~
    elif [ -d "$1" ]; then
        cd "$1"
    else
        # 搜索历史目录
        local dir
        dir=$(find ~ -type d -name "*$1*" 2>/dev/null | head -1)
        if [ -n "$dir" ]; then
            cd "$dir"
        else
            echo "目录未找到: $1"
        fi
    fi
}
```

**使用**:
```bash
j documents  # 跳转到包含 "documents" 的目录
j ~/Desktop  # 直接跳转到指定路径
```

### 5. 语法高亮 (类似 zsh-syntax-highlighting)

**功能**: 命令执行前显示高亮

**安装**:
```bash
# 安装 bash-preexec
curl -L https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o ~/.bash-preexec.sh
```

**配置**:
```bash
# 在 .bashrc 中添加
if [ -f ~/.bash-preexec.sh ]; then
    source ~/.bash-preexec.sh
    
    preexec() {
        echo -e "\033[1;33m$1\033[0m"
    }
fi
```

### 6. 目录历史 (类似 zsh-dirhistory)

**功能**: 记录和快速访问目录历史

**实现**:
```bash
# 目录历史
export DIRHISTORY_SIZE=20
declare -a dirhistory

# 记录目录历史
cd() {
    builtin cd "$@"
    local dir=$(pwd)
    
    # 添加到历史
    dirhistory=("$dir" "${dirhistory[@]}")
    
    # 保持历史大小
    if [ ${#dirhistory[@]} -gt $DIRHISTORY_SIZE ]; then
        dirhistory=("${dirhistory[@]:0:$DIRHISTORY_SIZE}")
    fi
}

# 目录历史导航
dh() {
    if [ -z "$1" ]; then
        echo "目录历史:"
        for i in "${!dirhistory[@]}"; do
            echo "$i: ${dirhistory[$i]}"
        done
    else
        if [ "$1" -ge 0 ] && [ "$1" -lt ${#dirhistory[@]} ]; then
            cd "${dirhistory[$1]}"
        else
            echo "无效的索引: $1"
        fi
    fi
}
```

**使用**:
```bash
dh      # 显示目录历史
dh 0    # 跳转到最近的目录
dh 5    # 跳转到第5个历史目录
```

## 🎨 提示符配置

### 彩色提示符
```bash
# 基础彩色提示符
PS1='\[\033[1;32m\]\u@\h\[\033[0m\]:\[\033[1;34m\]\w\[\033[0m\]\$ '

# 带 Git 分支的提示符
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1='\[\033[1;32m\]\u@\h\[\033[0m\]:\[\033[1;34m\]\w\[\033[1;33m\]$(parse_git_branch)\[\033[0m\]\$ '
```

### 条件提示符
```bash
# SSH 连接时显示红色
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    PS1='\[\033[1;31m\]\u@\h\[\033[0m\]:\[\033[1;34m\]\w\[\033[0m\]\$ '
else
    PS1='\[\033[1;32m\]\u@\h\[\033[0m\]:\[\033[1;34m\]\w\[\033[0m\]\$ '
fi
```

## 🔧 实用函数

### 通用解压函数
```bash
extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)          echo "'$1' 无法解压" ;;
        esac
    else
        echo "'$1' 不是有效的文件"
    fi
}
```

### 复制路径到剪贴板
```bash
copypath() {
    local path=$(pwd)
    if command -v pbcopy >/dev/null 2>&1; then
        # macOS
        echo -n "$path" | pbcopy
    elif command -v xclip >/dev/null 2>&1; then
        # Linux with xclip
        echo -n "$path" | xclip -selection clipboard
    else
        echo "未找到剪贴板工具"
        return 1
    fi
    echo "路径已复制到剪贴板: $path"
}
```

## 📝 别名配置

### 常用别名
```bash
# 文件操作
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git 别名
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'

# 系统别名
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias top='htop'

# 安全别名
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
```

## 🐛 故障排除

### 常见问题

1. **自动补全不工作**
   ```bash
   # 检查 bash-completion 是否安装
   which bash-completion
   
   # 重新加载配置
   source ~/.bashrc
   ```

2. **fzf 快捷键不工作**
   ```bash
   # 检查 fzf 是否安装
   which fzf
   
   # 重新绑定快捷键
   bind -f ~/.inputrc
   ```

3. **历史搜索不工作**
   ```bash
   # 检查历史配置
   echo $HISTSIZE
   echo $HISTFILESIZE
   
   # 重新加载配置
   source ~/.bashrc
   ```

### 调试技巧

1. **检查配置是否加载**
   ```bash
   # 查看当前 PS1
   echo $PS1
   
   # 查看已定义的函数
   declare -F | grep -E "(j|dh|extract)"
   ```

2. **测试功能**
   ```bash
   # 测试目录跳转
   j ~
   
   # 测试历史搜索
   # 输入部分命令后按上下箭头
   
   # 测试自动补全
   # 输入命令后按 Tab
   ```

## 🔄 更新和维护

### 更新工具
```bash
# macOS
brew update && brew upgrade

# Ubuntu
sudo apt update && sudo apt upgrade

# CentOS
sudo yum update
```

### 更新配置
```bash
# 重新加载配置
source ~/.bashrc

# 或者重启终端
```

## 📚 参考资源

- [Bash 官方文档](https://www.gnu.org/software/bash/manual/)
- [bash-completion 项目](https://github.com/scop/bash-completion)
- [fzf 项目](https://github.com/junegunn/fzf)
- [bash-preexec 项目](https://github.com/rcaloras/bash-preexec)
- [bash-it 项目](https://github.com/Bash-it/bash-it)

---

**注意**: 这些功能虽然类似 Zsh 插件，但实现方式不同。Bash 的功能相对简单，但足够实用。 