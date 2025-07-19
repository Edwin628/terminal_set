#!/bin/bash

# 🚀 ZSH 配置快速迁移脚本
# 用于将配置从 macOS 传输到 Linux

echo "🚀 ZSH 配置快速迁移工具"
echo "========================"

# 检查当前系统
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "✅ 检测到 macOS 系统"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "✅ 检测到 Linux 系统"
else
    echo "❌ 不支持的系统类型: $OSTYPE"
    exit 1
fi

# 创建迁移包
echo ""
echo "📦 创建迁移包..."

# 检查必要文件
if [[ ! -f ~/.zshrc ]]; then
    echo "❌ 未找到 ~/.zshrc"
    exit 1
fi

# 创建迁移目录
MIGRATION_DIR="zsh_migration_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$MIGRATION_DIR"

# 复制配置文件
echo "📋 复制配置文件..."
cp ~/.zshrc "$MIGRATION_DIR/"
if [[ -f ~/.p10k.zsh ]]; then
    cp ~/.p10k.zsh "$MIGRATION_DIR/"
    echo "✅ 已复制 .p10k.zsh"
else
    echo "⚠️  未找到 .p10k.zsh"
fi

# 复制安装脚本
cp install_on_linux.sh "$MIGRATION_DIR/"
cp manual_install_guide.md "$MIGRATION_DIR/"

# 创建系统信息文件
echo "📊 收集系统信息..."
cat > "$MIGRATION_DIR/system_info.txt" << EOF
# 系统信息
OS: $(uname -s)
Architecture: $(uname -m)
ZSH Version: $(zsh --version | head -1)
Date: $(date)

# 配置文件信息
.zshrc size: $(wc -c < ~/.zshrc) bytes
$(if [[ -f ~/.p10k.zsh ]]; then echo ".p10k.zsh size: $(wc -c < ~/.p10k.zsh) bytes"; fi)

# 插件信息
$(if [[ -d ~/.oh-my-zsh ]]; then echo "Oh My Zsh: 已安装"; else echo "Oh My Zsh: 未安装"; fi)
$(if [[ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]]; then echo "Powerlevel10k: 已安装"; else echo "Powerlevel10k: 未安装"; fi)
EOF

# 创建传输脚本
cat > "$MIGRATION_DIR/transfer_to_linux.sh" << 'EOF'
#!/bin/bash

# 🚀 传输到 Linux 的脚本
echo "🚀 开始传输 ZSH 配置到 Linux..."

# 检查参数
if [[ $# -eq 0 ]]; then
    echo "用法: $0 <linux_user@linux_host>"
    echo "示例: $0 user@192.168.1.100"
    exit 1
fi

LINUX_HOST="$1"
REMOTE_DIR="~/zsh_migration"

echo "📤 传输文件到 $LINUX_HOST..."

# 创建远程目录
ssh "$LINUX_HOST" "mkdir -p $REMOTE_DIR"

# 传输文件
scp -r . "$LINUX_HOST:$REMOTE_DIR/"

echo "✅ 传输完成！"
echo ""
echo "🔧 在 Linux 机器上执行以下命令："
echo "1. ssh $LINUX_HOST"
echo "2. cd $REMOTE_DIR"
echo "3. chmod +x install_on_linux.sh"
echo "4. ./install_on_linux.sh"
echo ""
echo "或者查看 manual_install_guide.md 进行手动安装"
EOF

chmod +x "$MIGRATION_DIR/transfer_to_linux.sh"

# 创建压缩包
echo "📦 创建压缩包..."
tar -czf "${MIGRATION_DIR}.tar.gz" "$MIGRATION_DIR"

echo ""
echo "🎉 迁移包创建完成！"
echo "========================"
echo "📁 迁移目录: $MIGRATION_DIR"
echo "📦 压缩包: ${MIGRATION_DIR}.tar.gz"
echo ""
echo "📋 包含的文件："
ls -la "$MIGRATION_DIR/"
echo ""
echo "🚀 使用方法："
echo "1. 将 ${MIGRATION_DIR}.tar.gz 传输到 Linux 机器"
echo "2. 解压: tar -xzf ${MIGRATION_DIR}.tar.gz"
echo "3. 进入目录: cd $MIGRATION_DIR"
echo "4. 运行安装脚本: ./install_on_linux.sh"
echo ""
echo "📤 或者使用传输脚本："
echo "./transfer_to_linux.sh user@linux_host" 