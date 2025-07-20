#!/bin/bash

# Bash 功能测试脚本
# 测试类似 Zsh 插件的 Bash 功能是否正常工作

echo "🧪 测试 Bash 增强功能"
echo "========================"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 测试函数
test_function() {
    local test_name="$1"
    local test_command="$2"
    local expected_result="$3"
    
    echo -n "测试 $test_name: "
    
    if eval "$test_command" >/dev/null 2>&1; then
        echo -e "${GREEN}✅ 通过${NC}"
        return 0
    else
        echo -e "${RED}❌ 失败${NC}"
        if [ -n "$expected_result" ]; then
            echo "  期望: $expected_result"
        fi
        return 1
    fi
}

# 测试配置是否加载
echo ""
echo "📋 配置测试"
echo "------------"

# 测试 .bashrc_enhanced 是否存在
test_function "增强配置文件" "[ -f ~/.bashrc_enhanced ]" "~/.bashrc_enhanced 文件存在"

# 测试 bash-preexec 是否存在
test_function "bash-preexec" "[ -f ~/.bash-preexec.sh ]" "~/.bash-preexec.sh 文件存在"

# 测试 Git 自动补全是否存在
test_function "Git 自动补全" "[ -f ~/.git-completion.bash ]" "~/.git-completion.bash 文件存在"

# 测试函数是否定义
echo ""
echo "🔧 功能测试"
echo "------------"

# 测试 j 函数 (目录跳转)
test_function "目录跳转函数" "type j >/dev/null 2>&1" "j 函数已定义"

# 测试 dh 函数 (目录历史)
test_function "目录历史函数" "type dh >/dev/null 2>&1" "dh 函数已定义"

# 测试 extract 函数 (解压)
test_function "解压函数" "type extract >/dev/null 2>&1" "extract 函数已定义"

# 测试 copypath 函数 (复制路径)
test_function "复制路径函数" "type copypath >/dev/null 2>&1" "copypath 函数已定义"

# 测试工具是否安装
echo ""
echo "🛠️  工具测试"
echo "------------"

# 测试 fzf
test_function "fzf 模糊搜索" "command -v fzf >/dev/null 2>&1" "fzf 已安装"

# 测试 bash-completion
test_function "bash-completion" "command -v bash-completion >/dev/null 2>&1 || [ -f /etc/bash_completion ]" "bash-completion 已安装"

# 测试 ripgrep
test_function "ripgrep" "command -v rg >/dev/null 2>&1" "ripgrep 已安装"

# 测试 bat
test_function "bat" "command -v bat >/dev/null 2>&1" "bat 已安装"

# 测试 fd
test_function "fd" "command -v fd >/dev/null 2>&1" "fd 已安装"

# 测试别名
echo ""
echo "📝 别名测试"
echo "------------"

# 测试常用别名
test_function "ll 别名" "alias ll >/dev/null 2>&1" "ll 别名已定义"
test_function "gs 别名" "alias gs >/dev/null 2>&1" "gs 别名已定义"
test_function ".. 别名" "alias .. >/dev/null 2>&1" ".. 别名已定义"

# 测试环境变量
echo ""
echo "🌍 环境变量测试"
echo "----------------"

# 测试 HISTSIZE
if [ "$HISTSIZE" -ge 1000 ]; then
    echo -e "测试 HISTSIZE: ${GREEN}✅ 通过${NC} ($HISTSIZE)"
else
    echo -e "测试 HISTSIZE: ${RED}❌ 失败${NC} ($HISTSIZE, 期望 >= 1000)"
fi

# 测试 HISTFILESIZE
if [ "$HISTFILESIZE" -ge 1000 ]; then
    echo -e "测试 HISTFILESIZE: ${GREEN}✅ 通过${NC} ($HISTFILESIZE)"
else
    echo -e "测试 HISTFILESIZE: ${RED}❌ 失败${NC} ($HISTFILESIZE, 期望 >= 1000)"
fi

# 测试提示符
echo ""
echo "🎨 提示符测试"
echo "-------------"

# 测试 PS1 是否包含颜色
if [[ "$PS1" == *"\["*"\]"* ]]; then
    echo -e "测试彩色提示符: ${GREEN}✅ 通过${NC}"
else
    echo -e "测试彩色提示符: ${YELLOW}⚠️  警告${NC} (PS1 可能没有颜色)"
fi

# 测试 Git 分支显示
if [[ "$PS1" == *"parse_git_branch"* ]]; then
    echo -e "测试 Git 分支显示: ${GREEN}✅ 通过${NC}"
else
    echo -e "测试 Git 分支显示: ${YELLOW}⚠️  警告${NC} (PS1 可能没有 Git 分支显示)"
fi

# 功能演示
echo ""
echo "🎯 功能演示"
echo "-----------"

echo -e "${BLUE}可用命令:${NC}"
echo "  j <目录名>     - 快速跳转到目录"
echo "  dh            - 显示目录历史"
echo "  extract <文件> - 解压文件"
echo "  copypath      - 复制当前路径到剪贴板"
echo ""
echo -e "${BLUE}快捷键:${NC}"
echo "  Ctrl+R        - 搜索历史命令"
echo "  Ctrl+T        - 搜索目录"
echo "  Ctrl+F        - 搜索文件"
echo "  上下箭头      - 搜索历史命令"
echo ""
echo -e "${BLUE}别名:${NC}"
echo "  ll            - ls -alF"
echo "  gs            - git status"
echo "  ..            - cd .."
echo "  ...           - cd ../.."

# 总结
echo ""
echo "📊 测试总结"
echo "============"

echo -e "${GREEN}✅ 所有测试完成${NC}"
echo ""
echo "💡 提示:"
echo "  - 如果某些测试失败，请运行: ./scripts/install/install_bash_plugins.sh"
echo "  - 重新加载配置: source ~/.bashrc"
echo "  - 查看详细文档: docs/shell/BASH_PLUGINS_GUIDE.md" 