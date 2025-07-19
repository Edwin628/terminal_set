# Tmux 使用指南

## 📋 目录
- [简介](#简介)
- [安装与配置](#安装与配置)
- [基本概念](#基本概念)
- [快捷键操作](#快捷键操作)
- [会话管理](#会话管理)
- [窗口操作](#窗口操作)
- [分屏操作](#分屏操作)
- [复制粘贴](#复制粘贴)
- [插件功能](#插件功能)
- [实用技巧](#实用技巧)
- [常见问题](#常见问题)

## 🎯 简介

Tmux 是一个终端复用器，允许你在一个终端窗口中运行多个会话，每个会话可以包含多个窗口和窗格。即使断开连接，会话也会继续运行。

### 主要优势
- **持久性**：断开连接后会话继续运行
- **多任务**：同时管理多个项目
- **协作**：支持多人共享会话
- **效率**：快速切换和管理终端任务

## 🔧 安装与配置

### 安装
```bash
# macOS (Homebrew)
brew install tmux

# Ubuntu/Debian
sudo apt install tmux

# CentOS/RHEL
sudo yum install tmux
```

### 配置文件
配置文件位置：`~/.tmux.conf`

当前配置特点：
- 前缀键：`Ctrl + a`（更符合 GNU screen 习惯）
- 启用鼠标支持
- 256 色支持
- 窗口编号从 1 开始
- 无前缀键窗格切换（`Ctrl + h/j/k/l`）
- vi 风格复制模式
- 美化状态栏
- 集成 TPM 插件管理器

## 🏗️ 基本概念

### 层级结构
```
Tmux Server
├── Session (会话)
│   ├── Window (窗口)
│   │   ├── Pane (窗格)
│   │   └── Pane (窗格)
│   └── Window (窗口)
└── Session (会话)
```

### 术语说明
- **Session (会话)**：独立的 tmux 环境
- **Window (窗口)**：会话中的标签页
- **Pane (窗格)**：窗口中的分屏区域
- **Prefix (前缀键)**：所有 tmux 命令的前置按键

## ⌨️ 快捷键操作

### 前缀键
- **前缀键**：`Ctrl + a`
- **发送前缀**：`Ctrl + a, Ctrl + a`

### 命令模式
- **进入命令模式**：`Ctrl + a, :`
- **退出命令模式**：`Esc`

### 无前缀键快捷键（新功能）
- **窗格切换**：`Ctrl + h/j/k/l`（无需按前缀键）
- **更自然的操作体验**

## 💼 会话管理

### 创建会话
```bash
# 创建新会话
tmux

# 创建命名会话
tmux new-session -s 会话名

# 创建分离的会话
tmux new-session -d -s 会话名
```

### 会话操作
```bash
# 列出所有会话
tmux ls
tmux list-sessions

# 连接到会话
tmux attach
tmux attach -t 会话名
tmux a -t 会话名

# 分离会话（保持运行）
Ctrl + a, d

# 重命名会话
Ctrl + a, $

# 杀死会话
tmux kill-session -t 会话名
tmux kill-server  # 杀死所有会话
```

### 会话内快捷键
```bash
# 分离会话
Ctrl + a, d

# 重命名会话
Ctrl + a, $

# 列出会话
Ctrl + a, s
```

## 🪟 窗口操作

### 创建窗口
```bash
# 创建新窗口
Ctrl + a, c

# 创建命名窗口
Ctrl + a, ,
```

### 窗口切换
```bash
# 按编号切换
Ctrl + a, 0-9

# 下一个窗口
Ctrl + a, n

# 上一个窗口
Ctrl + a, p

# 窗口列表
Ctrl + a, w
```

### 窗口管理
```bash
# 关闭当前窗口
Ctrl + a, &

# 重命名窗口
Ctrl + a, ,

# 移动窗口
Ctrl + a, .

# 窗口列表
Ctrl + a, w
```

## 📱 分屏操作

### 创建分屏
```bash
# 垂直分屏（左右）
Ctrl + a, |

# 水平分屏（上下）
Ctrl + a, -
```

### 窗格切换
```bash
# 无前缀键切换（推荐）
Ctrl + h  # 左
Ctrl + l  # 右
Ctrl + j  # 下
Ctrl + k  # 上

# 带前缀键切换（备用）
Ctrl + a, h  # 左
Ctrl + a, l  # 右
Ctrl + a, j  # 下
Ctrl + a, k  # 上

# 循环切换
Ctrl + a, o
```

### 窗格管理
```bash
# 调整窗格大小
Ctrl + a, : resize-pane -L 10  # 向左调整10字符
Ctrl + a, : resize-pane -R 10  # 向右调整10字符
Ctrl + a, : resize-pane -U 10  # 向上调整10行
Ctrl + a, : resize-pane -D 10  # 向下调整10行

# 关闭窗格
Ctrl + a, x

# 重新排列窗格
Ctrl + a, Space

# 切换窗格布局
Ctrl + a, {
Ctrl + a, }
```

## 📋 复制粘贴

### 进入复制模式
```bash
# 进入复制模式
Ctrl + a, [
```

### 复制模式操作
```bash
# 进入复制模式
Ctrl + a, [

# vi 风格操作
v                    # 开始选择
hjkl                 # 移动选择
y                    # 复制选中内容
Enter                # 确认复制

# 传统操作
Space                # 开始选择
方向键               # 移动选择
Enter                # 复制选中内容

# 粘贴
Ctrl + a, ]

# 退出复制模式
q
```

### 系统剪贴板集成
```bash
# 复制到系统剪贴板
Ctrl + a, : set-option -s set-clipboard off
Ctrl + a, : bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
```

## 🔌 插件功能

### 已安装插件
- **tpm**：插件管理器
- **tmux-sensible**：合理默认设置
- **tmux-resurrect**：保存/恢复会话
- **tmux-continuum**：自动保存会话

### 插件操作
```bash
# 保存会话
Ctrl + a, Ctrl + s

# 恢复会话
Ctrl + a, Ctrl + r

# 重新加载配置
Ctrl + a, :
# 然后输入：source-file ~/.tmux.conf
```

### 插件管理
```bash
# 安装插件
Ctrl + a, I (大写i)

# 卸载插件
Ctrl + a, Alt + u

# 更新插件
Ctrl + a, Alt + u
```

## 💡 实用技巧

### 同步窗格
```bash
# 同步所有窗格（同时执行相同命令）
Ctrl + a, :
# 然后输入：
setw synchronize-panes on

# 关闭同步
setw synchronize-panes off
```

### 窗格交换
```bash
# 交换窗格位置
Ctrl + a, {
Ctrl + a, }
```

### 最大化窗格
```bash
# 临时最大化窗格
Ctrl + a, z

# 再次按恢复
Ctrl + a, z
```

### 窗格编号
```bash
# 显示窗格编号
Ctrl + a, q
```

## 🎨 状态栏说明

### 状态栏位置
- **位置**：底部
- **刷新间隔**：1秒
- **对齐方式**：居中

### 状态栏内容
- **左侧**：`会话名 窗口:窗格号`
- **右侧**：`日期 时间`
- **中间**：窗口列表（当前窗口高亮）

### 颜色说明
- **绿色**：会话名
- **青色**：窗口和窗格信息
- **黄色**：日期和时间
- **白色**：默认文本
- **亮红色**：当前窗口

## 🚀 常用工作流程

### 开发环境设置
```bash
# 1. 创建开发会话
tmux new-session -s dev

# 2. 创建分屏
Ctrl + a, |    # 垂直分屏
Ctrl + a, -    # 水平分屏

# 3. 在不同窗格中运行不同命令
# 窗格1：运行服务器 (npm start)
# 窗格2：编辑代码 (vim)
# 窗格3：运行测试 (npm test)
# 窗格4：监控日志 (tail -f)

# 4. 分离会话
Ctrl + a, d

# 5. 稍后重新连接
tmux attach -t dev
```

### 服务器管理
```bash
# 1. 创建服务器管理会话
tmux new-session -s server

# 2. 创建多个窗口
Ctrl + a, c    # 窗口1：系统监控
Ctrl + a, c    # 窗口2：日志查看
Ctrl + a, c    # 窗口3：配置编辑

# 3. 重命名窗口
Ctrl + a, ,    # 重命名为 "monitor"
Ctrl + a, c    # 新窗口
Ctrl + a, ,    # 重命名为 "logs"
```

### 多项目开发
```bash
# 1. 为每个项目创建会话
tmux new-session -s project1
tmux new-session -s project2
tmux new-session -s project3

# 2. 在会话间切换
tmux attach -t project1
Ctrl + a, d
tmux attach -t project2
```

## ❓ 常见问题

### Q: 如何修改前缀键？
A: 在 `~/.tmux.conf` 中修改：
```bash
set -g prefix C-b  # 改为 Ctrl + b
```

### Q: 如何启用鼠标支持？
A: 在配置文件中添加：
```bash
set -g mouse on
```

### Q: 如何调整状态栏位置？
A: 在配置文件中设置：
```bash
set -g status-position top    # 顶部
set -g status-position bottom # 底部
```

### Q: 如何自定义状态栏？
A: 修改配置文件中的状态栏设置：
```bash
set -g status-left "自定义左侧内容"
set -g status-right "自定义右侧内容"
```

### Q: 如何保存会话布局？
A: 使用 tmux-resurrect 插件：
```bash
Ctrl + a, Ctrl + s  # 保存
Ctrl + a, Ctrl + r  # 恢复
```

### Q: 如何同步多个窗格？
A: 使用同步窗格功能：
```bash
Ctrl + a, :
setw synchronize-panes on
```

## 📚 进阶配置

### 自定义快捷键
```bash
# 在 ~/.tmux.conf 中添加
bind-key -n C-s send-keys -R \; clear-history
bind-key -n C-l send-keys 'C-l'
```

### 主题定制
```bash
# 修改状态栏颜色
set -g status-bg colour235
set -g status-fg white
setw -g window-status-current-format '#[fg=brightred]#I:#W#F'
```

### 性能优化
```bash
# 更快的按键响应
set -sg escape-time 0

# 启用 256 色
set -g default-terminal "screen-256color"
```

## 🔗 相关资源

- [Tmux 官方文档](https://github.com/tmux/tmux/wiki)
- [Tmux 快捷键速查表](https://tmuxcheatsheet.com/)
- [TPM 插件管理器](https://github.com/tmux-plugins/tpm)
- [Tmux 最佳实践](https://www.hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/)

---

**提示**：记住前缀键是 `Ctrl + a`，所有 tmux 命令都需要先按前缀键！ 