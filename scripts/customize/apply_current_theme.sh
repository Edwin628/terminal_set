#!/bin/bash

# 应用当前终端颜色配置脚本
# 基于图片中的 Powerlevel10k 颜色方案

echo "🎨 应用当前终端颜色配置"
echo "================================"

# 检查配置文件
if [[ ! -f ~/.p10k.zsh ]]; then
    echo "❌ 未找到 ~/.p10k.zsh 配置文件"
    exit 1
fi

# 备份原文件
cp ~/.p10k.zsh ~/.p10k.zsh.backup.$(date +%Y%m%d_%H%M%S)
echo "✅ 已备份原配置文件"

echo ""
echo "正在应用颜色配置..."

# 应用图片中的颜色方案
# 目录颜色：浅蓝色背景 (6)，深灰色文字 (254)
sed -i.bak 's/POWERLEVEL9K_DIR_BACKGROUND=.*/POWERLEVEL9K_DIR_BACKGROUND=6/' ~/.p10k.zsh
sed -i.bak 's/POWERLEVEL9K_DIR_FOREGROUND=.*/POWERLEVEL9K_DIR_FOREGROUND=254/' ~/.p10k.zsh

# Git 分支颜色：浅绿色背景 (2)，深灰色文字
sed -i.bak 's/POWERLEVEL9K_VCS_CLEAN_BACKGROUND=.*/POWERLEVEL9K_VCS_CLEAN_BACKGROUND=2/' ~/.p10k.zsh

# Conda 环境颜色：浅蓝色背景 (6)，深灰色文字 (254)
sed -i.bak 's/POWERLEVEL9K_ANACONDA_BACKGROUND=.*/POWERLEVEL9K_ANACONDA_BACKGROUND=6/' ~/.p10k.zsh
sed -i.bak 's/POWERLEVEL9K_ANACONDA_FOREGROUND=.*/POWERLEVEL9K_ANACONDA_FOREGROUND=254/' ~/.p10k.zsh

# 时间颜色：白色背景 (7)，深灰色文字 (0)
sed -i.bak 's/POWERLEVEL9K_TIME_BACKGROUND=.*/POWERLEVEL9K_TIME_BACKGROUND=7/' ~/.p10k.zsh
sed -i.bak 's/POWERLEVEL9K_TIME_FOREGROUND=.*/POWERLEVEL9K_TIME_FOREGROUND=0/' ~/.p10k.zsh

# 命令执行时间颜色：橙色背景 (3)，深灰色文字 (0)
sed -i.bak 's/POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=.*/POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=3/' ~/.p10k.zsh
sed -i.bak 's/POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=.*/POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=0/' ~/.p10k.zsh

# 设置分隔符颜色
sed -i.bak 's/POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND=.*/POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND=242/' ~/.p10k.zsh

# 设置提示符颜色：绿色 (76)
sed -i.bak 's/POWERLEVEL9K_PROMPT_CHAR_OK_VIINS_FOREGROUND=.*/POWERLEVEL9K_PROMPT_CHAR_OK_VIINS_FOREGROUND=76/' ~/.p10k.zsh

echo "✅ 颜色配置已应用！"
echo ""
echo "🎨 应用的颜色方案："
echo "  目录: 浅蓝色背景 (6) + 深灰色文字 (254)"
echo "  Git分支: 浅绿色背景 (2) + 深灰色文字"
echo "  Conda环境: 浅蓝色背景 (6) + 深灰色文字 (254)"
echo "  时间: 白色背景 (7) + 深灰色文字 (0)"
echo "  命令时间: 橙色背景 (3) + 深灰色文字 (0)"
echo "  提示符: 绿色 (76)"
echo ""
echo "🔄 请运行以下命令来应用更改："
echo "source ~/.p10k.zsh"
echo ""
echo "💡 如果效果不理想，可以运行 'p10k configure' 重新配置" 