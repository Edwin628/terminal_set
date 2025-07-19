#!/bin/bash

# 快速颜色修改脚本
# 简单易用的 Powerlevel10k 颜色修改工具

echo "🎨 Powerlevel10k 快速颜色修改"
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
echo "选择要修改的颜色："
echo "1. 目录颜色 (当前路径)"
echo "2. Git 分支颜色"
echo "3. 时间颜色"
echo "4. 命令执行时间颜色"
echo "5. Conda 环境颜色"
echo "6. 应用预设主题"
echo ""

read -p "请选择 (1-6): " choice

case $choice in
    1)
        echo "修改目录颜色："
        echo "背景色选项："
        echo "  1. 蓝色 (4)"
        echo "  2. 绿色 (2)"
        echo "  3. 紫色 (5)"
        echo "  4. 青色 (6)"
        echo "  5. 红色 (1)"
        read -p "选择背景色 (1-5): " bg_choice
        
        case $bg_choice in
            1) bg_color="4" ;;
            2) bg_color="2" ;;
            3) bg_color="5" ;;
            4) bg_color="6" ;;
            5) bg_color="1" ;;
            *) bg_color="4" ;;
        esac
        
        sed -i.bak "s/POWERLEVEL9K_DIR_BACKGROUND=.*/POWERLEVEL9K_DIR_BACKGROUND=${bg_color}/" ~/.p10k.zsh
        echo "✅ 目录背景色已修改为 $bg_color"
        ;;
    2)
        echo "修改 Git 分支颜色："
        echo "  1. 绿色 (2)"
        echo "  2. 蓝色 (4)"
        echo "  3. 黄色 (3)"
        echo "  4. 红色 (1)"
        read -p "选择颜色 (1-4): " git_choice
        
        case $git_choice in
            1) git_color="2" ;;
            2) git_color="4" ;;
            3) git_color="3" ;;
            4) git_color="1" ;;
            *) git_color="2" ;;
        esac
        
        sed -i.bak "s/POWERLEVEL9K_VCS_CLEAN_BACKGROUND=.*/POWERLEVEL9K_VCS_CLEAN_BACKGROUND=${git_color}/" ~/.p10k.zsh
        echo "✅ Git 分支颜色已修改为 $git_color"
        ;;
    3)
        echo "修改时间颜色："
        echo "  1. 白色背景 (7)"
        echo "  2. 黑色背景 (0)"
        echo "  3. 灰色背景 (8)"
        echo "  4. 蓝色背景 (4)"
        read -p "选择背景色 (1-4): " time_choice
        
        case $time_choice in
            1) time_bg="7"; time_fg="0" ;;
            2) time_bg="0"; time_fg="7" ;;
            3) time_bg="8"; time_fg="7" ;;
            4) time_bg="4"; time_fg="7" ;;
            *) time_bg="7"; time_fg="0" ;;
        esac
        
        sed -i.bak "s/POWERLEVEL9K_TIME_BACKGROUND=.*/POWERLEVEL9K_TIME_BACKGROUND=${time_bg}/" ~/.p10k.zsh
        sed -i.bak "s/POWERLEVEL9K_TIME_FOREGROUND=.*/POWERLEVEL9K_TIME_FOREGROUND=${time_fg}/" ~/.p10k.zsh
        echo "✅ 时间颜色已修改"
        ;;
    4)
        echo "修改命令执行时间颜色："
        echo "  1. 橙色 (3)"
        echo "  2. 红色 (1)"
        echo "  3. 黄色 (11)"
        echo "  4. 绿色 (2)"
        read -p "选择背景色 (1-4): " cmd_choice
        
        case $cmd_choice in
            1) cmd_bg="3"; cmd_fg="0" ;;
            2) cmd_bg="1"; cmd_fg="7" ;;
            3) cmd_bg="11"; cmd_fg="0" ;;
            4) cmd_bg="2"; cmd_fg="0" ;;
            *) cmd_bg="3"; cmd_fg="0" ;;
        esac
        
        sed -i.bak "s/POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=.*/POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=${cmd_bg}/" ~/.p10k.zsh
        sed -i.bak "s/POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=.*/POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=${cmd_fg}/" ~/.p10k.zsh
        echo "✅ 命令执行时间颜色已修改"
        ;;
    5)
        echo "修改 Conda 环境颜色："
        echo "  1. 蓝色 (4)"
        echo "  2. 绿色 (2)"
        echo "  3. 紫色 (5)"
        echo "  4. 青色 (6)"
        read -p "选择背景色 (1-4): " conda_choice
        
        case $conda_choice in
            1) conda_bg="4"; conda_fg="7" ;;
            2) conda_bg="2"; conda_fg="0" ;;
            3) conda_bg="5"; conda_fg="7" ;;
            4) conda_bg="6"; conda_fg="0" ;;
            *) conda_bg="4"; conda_fg="7" ;;
        esac
        
        sed -i.bak "s/POWERLEVEL9K_ANACONDA_BACKGROUND=.*/POWERLEVEL9K_ANACONDA_BACKGROUND=${conda_bg}/" ~/.p10k.zsh
        sed -i.bak "s/POWERLEVEL9K_ANACONDA_FOREGROUND=.*/POWERLEVEL9K_ANACONDA_FOREGROUND=${conda_fg}/" ~/.p10k.zsh
        echo "✅ Conda 环境颜色已修改"
        ;;
    6)
        echo "选择预设主题："
        echo "1. 深色主题"
        echo "2. 浅色主题"
        echo "3. 彩虹主题"
        echo "4. 海洋主题"
        read -p "选择主题 (1-4): " theme_choice
        
        case $theme_choice in
            1)
                # 深色主题
                sed -i.bak 's/POWERLEVEL9K_DIR_BACKGROUND=.*/POWERLEVEL9K_DIR_BACKGROUND=4/' ~/.p10k.zsh
                sed -i.bak 's/POWERLEVEL9K_DIR_FOREGROUND=.*/POWERLEVEL9K_DIR_FOREGROUND=7/' ~/.p10k.zsh
                sed -i.bak 's/POWERLEVEL9K_VCS_CLEAN_BACKGROUND=.*/POWERLEVEL9K_VCS_CLEAN_BACKGROUND=2/' ~/.p10k.zsh
                sed -i.bak 's/POWERLEVEL9K_TIME_BACKGROUND=.*/POWERLEVEL9K_TIME_BACKGROUND=8/' ~/.p10k.zsh
                sed -i.bak 's/POWERLEVEL9K_TIME_FOREGROUND=.*/POWERLEVEL9K_TIME_FOREGROUND=7/' ~/.p10k.zsh
                echo "✅ 深色主题已应用"
                ;;
            2)
                # 浅色主题
                sed -i.bak 's/POWERLEVEL9K_DIR_BACKGROUND=.*/POWERLEVEL9K_DIR_BACKGROUND=7/' ~/.p10k.zsh
                sed -i.bak 's/POWERLEVEL9K_DIR_FOREGROUND=.*/POWERLEVEL9K_DIR_FOREGROUND=0/' ~/.p10k.zsh
                sed -i.bak 's/POWERLEVEL9K_VCS_CLEAN_BACKGROUND=.*/POWERLEVEL9K_VCS_CLEAN_BACKGROUND=10/' ~/.p10k.zsh
                sed -i.bak 's/POWERLEVEL9K_TIME_BACKGROUND=.*/POWERLEVEL9K_TIME_BACKGROUND=15/' ~/.p10k.zsh
                sed -i.bak 's/POWERLEVEL9K_TIME_FOREGROUND=.*/POWERLEVEL9K_TIME_FOREGROUND=0/' ~/.p10k.zsh
                echo "✅ 浅色主题已应用"
                ;;
            3)
                # 彩虹主题
                sed -i.bak 's/POWERLEVEL9K_DIR_BACKGROUND=.*/POWERLEVEL9K_DIR_BACKGROUND=5/' ~/.p10k.zsh
                sed -i.bak 's/POWERLEVEL9K_DIR_FOREGROUND=.*/POWERLEVEL9K_DIR_FOREGROUND=7/' ~/.p10k.zsh
                sed -i.bak 's/POWERLEVEL9K_VCS_CLEAN_BACKGROUND=.*/POWERLEVEL9K_VCS_CLEAN_BACKGROUND=1/' ~/.p10k.zsh
                sed -i.bak 's/POWERLEVEL9K_TIME_BACKGROUND=.*/POWERLEVEL9K_TIME_BACKGROUND=3/' ~/.p10k.zsh
                sed -i.bak 's/POWERLEVEL9K_TIME_FOREGROUND=.*/POWERLEVEL9K_TIME_FOREGROUND=0/' ~/.p10k.zsh
                echo "✅ 彩虹主题已应用"
                ;;
            4)
                # 海洋主题
                sed -i.bak 's/POWERLEVEL9K_DIR_BACKGROUND=.*/POWERLEVEL9K_DIR_BACKGROUND=6/' ~/.p10k.zsh
                sed -i.bak 's/POWERLEVEL9K_DIR_FOREGROUND=.*/POWERLEVEL9K_DIR_FOREGROUND=0/' ~/.p10k.zsh
                sed -i.bak 's/POWERLEVEL9K_VCS_CLEAN_BACKGROUND=.*/POWERLEVEL9K_VCS_CLEAN_BACKGROUND=4/' ~/.p10k.zsh
                sed -i.bak 's/POWERLEVEL9K_TIME_BACKGROUND=.*/POWERLEVEL9K_TIME_BACKGROUND=12/' ~/.p10k.zsh
                sed -i.bak 's/POWERLEVEL9K_TIME_FOREGROUND=.*/POWERLEVEL9K_TIME_FOREGROUND=7/' ~/.p10k.zsh
                echo "✅ 海洋主题已应用"
                ;;
            *)
                echo "❌ 无效选择"
                exit 1
                ;;
        esac
        ;;
    *)
        echo "❌ 无效选择"
        exit 1
        ;;
esac

echo ""
echo "🔄 请运行以下命令来应用更改："
echo "source ~/.p10k.zsh"
echo ""
echo "💡 提示：如果效果不理想，可以运行 'p10k configure' 重新配置" 