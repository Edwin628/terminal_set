#!/bin/bash
echo "🧪 Bash 配置测试脚本"
echo "===================="

echo "1. 检查 Bash 版本..."
bash --version

echo -e "\n2. 检查配置文件..."
if [[ -f "$HOME/.bashrc" ]]; then
    echo "✅ .bashrc 存在"
    echo "   大小: $(wc -c < "$HOME/.bashrc") 字节"
    echo "   行数: $(wc -l < "$HOME/.bashrc") 行"
else
    echo "❌ .bashrc 不存在"
fi

if [[ -f "$HOME/.bash_profile" ]]; then
    echo "✅ .bash_profile 存在"
else
    echo "❌ .bash_profile 不存在"
fi

echo -e "\n3. 检查 bash-completion..."
if [[ -f /etc/bash_completion ]] || [[ -f /usr/share/bash-completion/bash_completion ]]; then
    echo "✅ bash-completion 已安装"
else
    echo "❌ bash-completion 未安装"
fi

echo -e "\n4. 测试别名..."
echo "测试 ll 别名:"
alias ll 2>/dev/null || echo "ll 别名未定义"

echo -e "\n5. 测试函数..."
echo "测试 sysinfo 函数:"
type sysinfo 2>/dev/null || echo "sysinfo 函数未定义"

echo -e "\n6. 启动 Bash 进行测试..."
echo "在 Bash 中测试以下功能:"
echo "  - 彩色提示符"
echo "  - 别名功能 (ll, la, ..)"
echo "  - 函数功能 (sysinfo, help)"
echo "  - 历史记录搜索 (上下箭头)"
echo "  - 输入 exit 退出"
echo ""
echo "按 Enter 启动 Bash..."
read
bash
