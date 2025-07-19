# Tmux 快速参考卡片

## 🎯 前缀键
**Ctrl + a** (大部分命令需要先按这个)

**无前缀键快捷键**：
- `Ctrl + h/j/k/l` - 窗格切换（无需前缀键）

## 💼 会话管理
```bash
# 创建会话
tmux                    # 新会话
tmux new-session -s dev # 命名会话

# 会话操作
tmux ls                 # 列出会话
tmux attach -t dev      # 连接会话
Ctrl + a, d            # 分离会话
Ctrl + a, $            # 重命名会话
```

## 🪟 窗口操作
```bash
# 窗口管理
Ctrl + a, c            # 新建窗口
Ctrl + a, &            # 关闭窗口
Ctrl + a, ,            # 重命名窗口
Ctrl + a, 0-9          # 切换到窗口0-9
Ctrl + a, n            # 下一个窗口
Ctrl + a, p            # 上一个窗口
Ctrl + a, w            # 窗口列表
```

## 📱 分屏操作
```bash
# 创建分屏
Ctrl + a, |            # 垂直分屏（左右）
Ctrl + a, -            # 水平分屏（上下）

# 窗格切换
Ctrl + h               # 左窗格（无前缀键）
Ctrl + l               # 右窗格（无前缀键）
Ctrl + j               # 下窗格（无前缀键）
Ctrl + k               # 上窗格（无前缀键）
Ctrl + a, h            # 左窗格（备用）
Ctrl + a, l            # 右窗格（备用）
Ctrl + a, j            # 下窗格（备用）
Ctrl + a, k            # 上窗格（备用）
Ctrl + a, o            # 循环切换

# 窗格管理
Ctrl + a, x            # 关闭窗格
Ctrl + a, z            # 最大化/恢复窗格
Ctrl + a, {            # 交换窗格
Ctrl + a, }            # 交换窗格
```

## 📋 复制粘贴
```bash
# 复制模式
Ctrl + a, [            # 进入复制模式
v                      # 开始选择（vi风格）
hjkl                   # 移动选择
y                      # 复制选中内容（vi风格）
Enter                  # 确认复制
Ctrl + a, ]            # 粘贴
q                      # 退出复制模式
```

## 🔌 插件操作
```bash
# 会话保存/恢复
Ctrl + a, Ctrl + s     # 保存会话
Ctrl + a, Ctrl + r     # 恢复会话

# 插件管理
Ctrl + a, I            # 安装插件
Ctrl + a, Alt + u      # 更新插件
```

## 💡 实用技巧
```bash
# 同步窗格（同时执行相同命令）
Ctrl + a, :
setw synchronize-panes on

# 调整窗格大小
Ctrl + a, :
resize-pane -L 10      # 向左调整10字符

# 重新加载配置
Ctrl + a, :
source-file ~/.tmux.conf
```

## 🎨 状态栏说明
- **左侧**：会话名 + 窗口:窗格号
- **右侧**：日期 + 时间
- **中间**：窗口列表（当前窗口高亮）
- **窗口编号**：从 1 开始

## 🚀 常用工作流
```bash
# 开发环境
tmux new-session -s dev
Ctrl + a, |            # 垂直分屏
Ctrl + a, -            # 水平分屏
# 窗格1：运行服务器
# 窗格2：编辑代码
# 窗格3：运行测试
Ctrl + a, d            # 分离会话
tmux attach -t dev     # 重新连接
```

## ❓ 退出 tmux
```bash
# 方法1：关闭所有窗口
Ctrl + a, & (重复直到关闭所有窗口)

# 方法2：直接退出
Ctrl + a, :
kill-server

# 方法3：从外部杀死
tmux kill-server
```

---

**记住**：前缀键是 `Ctrl + a`！ 