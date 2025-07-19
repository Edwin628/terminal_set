# 🚀 Bash 配置说明

## 📋 配置文件说明

### `.bashrc` - 增强版 Bash 配置
提供丰富的终端体验，包含：
- ✅ 彩色提示符和输出
- ✅ 丰富的别名和函数
- ✅ 历史记录增强
- ✅ 自动补全支持
- ✅ 系统信息工具
- ✅ 文件操作便利功能

## 🎯 主要功能

### 🎨 视觉效果
- **彩色提示符** - 根据连接类型显示不同颜色
- **彩色输出** - ls、grep 等命令的彩色输出
- **窗口标题** - 自动设置终端窗口标题

### 🔧 别名系统
```bash
# 文件操作
ll          # ls -alF (详细列表)
la          # ls -A (显示隐藏文件)
lsd         # ls -d */ (只显示目录)

# 导航
..          # cd ..
...         # cd ../..
....        # cd ../../..

# 系统信息
df          # df -h (人类可读)
du          # du -h (人类可读)
free        # free -h (人类可读)
myip        # 显示公网 IP
weather     # 显示天气信息

# Git 操作
gs          # git status
ga          # git add
gc          # git commit
gp          # git push
gl          # git log --oneline
gd          # git diff

# 配置编辑
bashrc      # nano ~/.bashrc
reload      # source ~/.bashrc
```

### 🔍 实用函数
```bash
# 系统信息
sysinfo     # 显示系统信息
netstat     # 显示网络连接
psinfo      # 显示进程信息

# 文件操作
ff <name>   # 查找文件
fd <name>   # 查找目录
backup <file> # 备份文件
extract <file> # 解压文件

# 目录操作
mkcd <dir>  # 创建目录并进入
dus         # 显示目录大小
recent <days> # 显示最近修改的文件

# 帮助
help        # 显示帮助信息
```

### 📚 历史记录增强
- **大容量历史** - 10000 条命令历史
- **历史搜索** - 使用上下箭头搜索历史
- **重复过滤** - 自动忽略重复命令
- **实时保存** - 命令实时保存到历史文件

### 🔄 自动补全
- **bash-completion** - 基础命令补全
- **Git 补全** - Git 命令和分支补全
- **路径补全** - 智能路径补全

## 🔧 安装方法

### 自动安装
```bash
chmod +x install_bash_config.sh
./install_bash_config.sh
```

### 手动安装
```bash
# 1. 备份现有配置
cp ~/.bashrc ~/.bashrc.backup

# 2. 复制新配置
cp .bashrc ~/.bashrc

# 3. 重新加载配置
source ~/.bashrc
```

## 🧪 测试配置

安装完成后，运行测试脚本：
```bash
./test_bash_config.sh
```

## 🎨 自定义配置

### 启用欢迎信息
编辑 `~/.bashrc`，取消注释：
```bash
# 显示欢迎信息（可选，取消注释启用）
welcome
```

### 修改提示符
在 `~/.bashrc` 中修改 PS1 变量：
```bash
# 简单提示符
PS1="\u@\h:\w\$ "

# 彩色提示符
PS1="\[${BOLD_CYAN}\]\u\[${RESET}\]@\[${BOLD_GREEN}\]\h\[${RESET}\]:\[${BOLD_BLUE}\]\w\[${RESET}\]\$ "
```

### 添加自定义别名
在 `~/.bashrc` 末尾添加：
```bash
# 自定义别名
alias myalias='my command'
```

## 🔧 故障排除

### 问题1: 颜色不显示
```bash
# 检查终端是否支持颜色
echo -e "\033[0;31m红色文本\033[0m"

# 如果支持，检查配置是否正确加载
source ~/.bashrc
```

### 问题2: 别名不工作
```bash
# 检查别名是否定义
alias | grep ll

# 重新加载配置
source ~/.bashrc
```

### 问题3: 自动补全不工作
```bash
# 安装 bash-completion
sudo apt install bash-completion  # Ubuntu/Debian
sudo yum install bash-completion  # CentOS/RHEL
sudo dnf install bash-completion  # Fedora
sudo pacman -S bash-completion    # Arch Linux
```

## 📚 常用命令参考

### 系统信息
```bash
sysinfo     # 系统信息
netstat     # 网络连接
psinfo      # 进程信息
weather     # 天气信息
myip        # 公网 IP
```

### 文件操作
```bash
ff filename # 查找文件
fd dirname  # 查找目录
backup file # 备份文件
extract file.tar.gz # 解压文件
```

### 目录操作
```bash
mkcd newdir # 创建并进入目录
dus         # 目录大小
recent 7    # 最近7天修改的文件
```

### 配置管理
```bash
bashrc      # 编辑配置
reload      # 重新加载
help        # 查看帮助
```

## 🎉 优势特点

- 🚀 **轻量级** - 纯 Bash 实现，无外部依赖
- 🎨 **美观** - 彩色提示符和输出
- 🔧 **实用** - 丰富的别名和函数
- 📚 **易用** - 清晰的帮助系统
- 🔄 **兼容** - 适用于各种 Linux 发行版
- 📝 **可扩展** - 易于添加自定义功能

## 📞 获取帮助

如果遇到问题：
1. 运行 `help` 命令查看可用功能
2. 检查配置文件语法：`bash -n ~/.bashrc`
3. 查看错误信息：`bash -x ~/.bashrc`
4. 参考 bash 手册：`man bash` 