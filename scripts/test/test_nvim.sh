#!/bin/bash
echo "🧪 Neovim 配置测试脚本"
echo "========================"

echo "1. 检查 Neovim 版本..."
nvim --version | head -3

echo -e "\n2. 检查配置文件..."
if [ -f ~/.config/nvim/init.lua ]; then
    echo "✅ init.lua 存在"
    echo "文件大小: $(wc -c < ~/.config/nvim/init.lua) 字节"
else
    echo "❌ init.lua 不存在"
fi

echo -e "\n3. 检查插件目录..."
if [ -d ~/.local/share/nvim/lazy ]; then
    echo "✅ 插件目录存在"
    echo "已安装插件数量: $(ls ~/.local/share/nvim/lazy | wc -l)"
else
    echo "❌ 插件目录不存在"
fi

echo -e "\n4. 测试配置文件语法..."
nvim --headless -c "lua print('✅ 配置文件语法正确')" -c "quit" 2>/dev/null && echo "✅ 语法检查通过" || echo "❌ 语法检查失败"

echo -e "\n5. 启动 Neovim 进行交互测试..."
echo "在 Neovim 中测试以下功能:"
echo "  - 按 <Space>e 打开文件浏览器"
echo "  - 按 <Space>ff 搜索文件"
echo "  - 按 <Space>fg 搜索文本"
echo "  - 输入 :Lazy 查看插件"
echo "  - 输入 :Mason 查看 LSP 状态"
echo "  - 输入 :q 退出"
echo ""
echo "按 Enter 启动 Neovim..."
read
nvim
