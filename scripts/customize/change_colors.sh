#!/bin/bash

# Powerlevel10k 颜色修改脚本
# 这个脚本可以帮助你快速修改终端提示符的颜色

set -e

# 颜色定义
declare -A COLORS=(
    ["black"]="0"
    ["red"]="1"
    ["green"]="2"
    ["yellow"]="3"
    ["blue"]="4"
    ["purple"]="5"
    ["cyan"]="6"
    ["white"]="7"
    ["bright_black"]="8"
    ["bright_red"]="9"
    ["bright_green"]="10"
    ["bright_yellow"]="11"
    ["bright_blue"]="12"
    ["bright_purple"]="13"
    ["bright_cyan"]="14"
    ["bright_white"]="15"
)

# 颜色显示函数
show_color() {
    local color_name="$1"
    local color_code="$2"
    echo -e "\033[48;5;${color_code}m  ${color_name}  \033[0m (代码: ${color_code})"
}

# 显示所有可用颜色
show_all_colors() {
    echo "🎨 可用的颜色："
    echo "=================="
    for color_name in "${!COLORS[@]}"; do
        show_color "$color_name" "${COLORS[$color_name]}"
    done
    echo ""
}

# 显示当前配置
show_current_config() {
    echo "📋 当前颜色配置："
    echo "=================="
    
    if [[ -f ~/.p10k.zsh ]]; then
        echo "目录颜色："
        local dir_bg=$(grep "POWERLEVEL9K_DIR_BACKGROUND=" ~/.p10k.zsh | cut -d'=' -f2)
        local dir_fg=$(grep "POWERLEVEL9K_DIR_FOREGROUND=" ~/.p10k.zsh | cut -d'=' -f2)
        echo "  背景: $(get_color_name "$dir_bg")"
        echo "  前景: $(get_color_name "$dir_fg")"
        
        echo ""
        echo "Git 分支颜色："
        local vcs_bg=$(grep "POWERLEVEL9K_VCS_CLEAN_BACKGROUND=" ~/.p10k.zsh | cut -d'=' -f2)
        echo "  背景: $(get_color_name "$vcs_bg")"
        
        echo ""
        echo "右侧提示符颜色："
        local time_bg=$(grep "POWERLEVEL9K_TIME_BACKGROUND=" ~/.p10k.zsh | cut -d'=' -f2)
        local time_fg=$(grep "POWERLEVEL9K_TIME_FOREGROUND=" ~/.p10k.zsh | cut -d'=' -f2)
        echo "  时间背景: $(get_color_name "$time_bg")"
        echo "  时间前景: $(get_color_name "$time_fg")"
        
        local cmd_bg=$(grep "POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=" ~/.p10k.zsh | cut -d'=' -f2)
        local cmd_fg=$(grep "POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=" ~/.p10k.zsh | cut -d'=' -f2)
        echo "  命令时间背景: $(get_color_name "$cmd_bg")"
        echo "  命令时间前景: $(get_color_name "$cmd_fg")"
        
        local conda_bg=$(grep "POWERLEVEL9K_ANACONDA_BACKGROUND=" ~/.p10k.zsh | cut -d'=' -f2)
        local conda_fg=$(grep "POWERLEVEL9K_ANACONDA_FOREGROUND=" ~/.p10k.zsh | cut -d'=' -f2)
        echo "  Conda背景: $(get_color_name "$conda_bg")"
        echo "  Conda前景: $(get_color_name "$conda_fg")"
    else
        echo "❌ 未找到 ~/.p10k.zsh 配置文件"
        exit 1
    fi
    echo ""
}

# 根据颜色代码获取颜色名称
get_color_name() {
    local code="$1"
    for color_name in "${!COLORS[@]}"; do
        if [[ "${COLORS[$color_name]}" == "$code" ]]; then
            echo "$color_name"
            return 0
        fi
    done
    echo "未知颜色($code)"
}

# 验证颜色代码
validate_color() {
    local color="$1"
    if [[ -n "${COLORS[$color]}" ]]; then
        return 0
    fi
    return 1
}

# 修改颜色配置
change_color() {
    local setting="$1"
    local current_value="$2"
    local current_name=$(get_color_name "$current_value")
    
    echo "当前 $setting: $current_name ($current_value)"
    echo "选择新的颜色："
    
    # 显示颜色选项
    local i=1
    local options=()
    for color_name in "${!COLORS[@]}"; do
        echo "$i. $(show_color "$color_name" "${COLORS[$color_name]}")"
        options+=("$color_name")
        ((i++))
    done
    
    echo ""
    read -p "请输入颜色编号 (1-$((i-1))) 或颜色名称: " choice
    
    local new_color=""
    if [[ "$choice" =~ ^[0-9]+$ ]] && [[ "$choice" -ge 1 ]] && [[ "$choice" -le $((i-1)) ]]; then
        new_color="${options[$((choice-1))]}"
    elif validate_color "$choice"; then
        new_color="$choice"
    else
        echo "❌ 无效的选择"
        return 1
    fi
    
    local new_code="${COLORS[$new_color]}"
    echo "✅ 将 $setting 从 $current_name ($current_value) 改为 $new_color ($new_code)"
    
    # 备份原文件
    cp ~/.p10k.zsh ~/.p10k.zsh.backup.$(date +%Y%m%d_%H%M%S)
    
    # 修改配置文件
    sed -i.bak "s/POWERLEVEL9K_${setting}=${current_value}/POWERLEVEL9K_${setting}=${new_code}/" ~/.p10k.zsh
    
    echo "✅ 颜色已更新！"
    echo "🔄 请运行 'source ~/.p10k.zsh' 来应用更改"
}

# 预设主题
apply_preset() {
    local preset="$1"
    
    echo "🎨 应用预设主题: $preset"
    
    # 备份原文件
    cp ~/.p10k.zsh ~/.p10k.zsh.backup.$(date +%Y%m%d_%H%M%S)
    
    case "$preset" in
        "dark")
            # 深色主题
            sed -i.bak 's/POWERLEVEL9K_DIR_BACKGROUND=.*/POWERLEVEL9K_DIR_BACKGROUND=4/' ~/.p10k.zsh
            sed -i.bak 's/POWERLEVEL9K_DIR_FOREGROUND=.*/POWERLEVEL9K_DIR_FOREGROUND=7/' ~/.p10k.zsh
            sed -i.bak 's/POWERLEVEL9K_VCS_CLEAN_BACKGROUND=.*/POWERLEVEL9K_VCS_CLEAN_BACKGROUND=2/' ~/.p10k.zsh
            sed -i.bak 's/POWERLEVEL9K_TIME_BACKGROUND=.*/POWERLEVEL9K_TIME_BACKGROUND=8/' ~/.p10k.zsh
            sed -i.bak 's/POWERLEVEL9K_TIME_FOREGROUND=.*/POWERLEVEL9K_TIME_FOREGROUND=7/' ~/.p10k.zsh
            echo "✅ 深色主题已应用"
            ;;
        "light")
            # 浅色主题
            sed -i.bak 's/POWERLEVEL9K_DIR_BACKGROUND=.*/POWERLEVEL9K_DIR_BACKGROUND=7/' ~/.p10k.zsh
            sed -i.bak 's/POWERLEVEL9K_DIR_FOREGROUND=.*/POWERLEVEL9K_DIR_FOREGROUND=0/' ~/.p10k.zsh
            sed -i.bak 's/POWERLEVEL9K_VCS_CLEAN_BACKGROUND=.*/POWERLEVEL9K_VCS_CLEAN_BACKGROUND=10/' ~/.p10k.zsh
            sed -i.bak 's/POWERLEVEL9K_TIME_BACKGROUND=.*/POWERLEVEL9K_TIME_BACKGROUND=15/' ~/.p10k.zsh
            sed -i.bak 's/POWERLEVEL9K_TIME_FOREGROUND=.*/POWERLEVEL9K_TIME_FOREGROUND=0/' ~/.p10k.zsh
            echo "✅ 浅色主题已应用"
            ;;
        "rainbow")
            # 彩虹主题
            sed -i.bak 's/POWERLEVEL9K_DIR_BACKGROUND=.*/POWERLEVEL9K_DIR_BACKGROUND=5/' ~/.p10k.zsh
            sed -i.bak 's/POWERLEVEL9K_DIR_FOREGROUND=.*/POWERLEVEL9K_DIR_FOREGROUND=7/' ~/.p10k.zsh
            sed -i.bak 's/POWERLEVEL9K_VCS_CLEAN_BACKGROUND=.*/POWERLEVEL9K_VCS_CLEAN_BACKGROUND=1/' ~/.p10k.zsh
            sed -i.bak 's/POWERLEVEL9K_TIME_BACKGROUND=.*/POWERLEVEL9K_TIME_BACKGROUND=3/' ~/.p10k.zsh
            sed -i.bak 's/POWERLEVEL9K_TIME_FOREGROUND=.*/POWERLEVEL9K_TIME_FOREGROUND=0/' ~/.p10k.zsh
            echo "✅ 彩虹主题已应用"
            ;;
        "ocean")
            # 海洋主题
            sed -i.bak 's/POWERLEVEL9K_DIR_BACKGROUND=.*/POWERLEVEL9K_DIR_BACKGROUND=6/' ~/.p10k.zsh
            sed -i.bak 's/POWERLEVEL9K_DIR_FOREGROUND=.*/POWERLEVEL9K_DIR_FOREGROUND=0/' ~/.p10k.zsh
            sed -i.bak 's/POWERLEVEL9K_VCS_CLEAN_BACKGROUND=.*/POWERLEVEL9K_VCS_CLEAN_BACKGROUND=4/' ~/.p10k.zsh
            sed -i.bak 's/POWERLEVEL9K_TIME_BACKGROUND=.*/POWERLEVEL9K_TIME_BACKGROUND=12/' ~/.p10k.zsh
            sed -i.bak 's/POWERLEVEL9K_TIME_FOREGROUND=.*/POWERLEVEL9K_TIME_FOREGROUND=7/' ~/.p10k.zsh
            echo "✅ 海洋主题已应用"
            ;;
        *)
            echo "❌ 未知预设: $preset"
            return 1
            ;;
    esac
    
    echo "🔄 请运行 'source ~/.p10k.zsh' 来应用更改"
}

# 主菜单
main_menu() {
    while true; do
        echo ""
        echo "🎨 Powerlevel10k 颜色配置工具"
        echo "================================"
        echo "1. 查看当前配置"
        echo "2. 查看所有颜色"
        echo "3. 修改目录颜色"
        echo "4. 修改 Git 分支颜色"
        echo "5. 修改时间颜色"
        echo "6. 修改命令执行时间颜色"
        echo "7. 修改 Conda 环境颜色"
        echo "8. 应用预设主题"
        echo "9. 重新配置 Powerlevel10k"
        echo "0. 退出"
        echo ""
        read -p "请选择操作 (0-9): " choice
        
        case $choice in
            1)
                show_current_config
                ;;
            2)
                show_all_colors
                ;;
            3)
                local dir_bg=$(grep "POWERLEVEL9K_DIR_BACKGROUND=" ~/.p10k.zsh | cut -d'=' -f2)
                local dir_fg=$(grep "POWERLEVEL9K_DIR_FOREGROUND=" ~/.p10k.zsh | cut -d'=' -f2)
                echo "修改目录背景色："
                change_color "DIR_BACKGROUND" "$dir_bg"
                echo "修改目录前景色："
                change_color "DIR_FOREGROUND" "$dir_fg"
                ;;
            4)
                local vcs_bg=$(grep "POWERLEVEL9K_VCS_CLEAN_BACKGROUND=" ~/.p10k.zsh | cut -d'=' -f2)
                change_color "VCS_CLEAN_BACKGROUND" "$vcs_bg"
                ;;
            5)
                local time_bg=$(grep "POWERLEVEL9K_TIME_BACKGROUND=" ~/.p10k.zsh | cut -d'=' -f2)
                local time_fg=$(grep "POWERLEVEL9K_TIME_FOREGROUND=" ~/.p10k.zsh | cut -d'=' -f2)
                echo "修改时间背景色："
                change_color "TIME_BACKGROUND" "$time_bg"
                echo "修改时间前景色："
                change_color "TIME_FOREGROUND" "$time_fg"
                ;;
            6)
                local cmd_bg=$(grep "POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=" ~/.p10k.zsh | cut -d'=' -f2)
                local cmd_fg=$(grep "POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=" ~/.p10k.zsh | cut -d'=' -f2)
                echo "修改命令执行时间背景色："
                change_color "COMMAND_EXECUTION_TIME_BACKGROUND" "$cmd_bg"
                echo "修改命令执行时间前景色："
                change_color "COMMAND_EXECUTION_TIME_FOREGROUND" "$cmd_fg"
                ;;
            7)
                local conda_bg=$(grep "POWERLEVEL9K_ANACONDA_BACKGROUND=" ~/.p10k.zsh | cut -d'=' -f2)
                local conda_fg=$(grep "POWERLEVEL9K_ANACONDA_FOREGROUND=" ~/.p10k.zsh | cut -d'=' -f2)
                echo "修改 Conda 环境背景色："
                change_color "ANACONDA_BACKGROUND" "$conda_bg"
                echo "修改 Conda 环境前景色："
                change_color "ANACONDA_FOREGROUND" "$conda_fg"
                ;;
            8)
                echo "选择预设主题："
                echo "1. dark (深色主题)"
                echo "2. light (浅色主题)"
                echo "3. rainbow (彩虹主题)"
                echo "4. ocean (海洋主题)"
                read -p "请选择主题 (1-4): " theme_choice
                case $theme_choice in
                    1) apply_preset "dark" ;;
                    2) apply_preset "light" ;;
                    3) apply_preset "rainbow" ;;
                    4) apply_preset "ocean" ;;
                    *) echo "❌ 无效选择" ;;
                esac
                ;;
            9)
                echo "🔄 启动 Powerlevel10k 配置向导..."
                p10k configure
                ;;
            0)
                echo "👋 再见！"
                exit 0
                ;;
            *)
                echo "❌ 无效选择，请重试"
                ;;
        esac
        
        echo ""
        read -p "按回车键继续..."
    done
}

# 检查是否在 zsh 环境中
if [[ "$SHELL" != */zsh ]]; then
    echo "⚠️  警告：建议在 zsh 环境中运行此脚本"
fi

# 检查配置文件是否存在
if [[ ! -f ~/.p10k.zsh ]]; then
    echo "❌ 未找到 ~/.p10k.zsh 配置文件"
    echo "请先安装 Powerlevel10k 主题"
    exit 1
fi

# 运行主菜单
main_menu 