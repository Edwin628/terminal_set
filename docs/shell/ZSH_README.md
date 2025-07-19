# Zsh 配置说明

## 📋 目录
- [简介](#简介)
- [安装与配置](#安装与配置)
- [插件说明](#插件说明)
- [主题配置](#主题配置)
- [快捷键说明](#快捷键说明)
- [功能特性](#功能特性)
- [故障排除](#故障排除)

## 🎯 简介

这是一个基于 Oh My Zsh 和 Powerlevel10k 的 Zsh 配置，提供了：
- 智能命令补全和语法高亮
- 美观的 Powerlevel10k 主题
- 实用的别名和函数
- 历史记录增强
- 自动跳转目录

## 🔧 安装与配置

### 安装 Oh My Zsh
```bash
# 自动安装
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 手动安装
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
```

### 安装 Powerlevel10k
```bash
# 克隆主题
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# 设置主题
echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc
```

### 安装插件
```bash
# 自动补全
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# 语法高亮
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 自动跳转
git clone https://github.com/wting/autojump.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autojump
```

## 🔌 插件说明

### 核心插件
| 插件 | 功能 | 状态 |
|------|------|------|
| **zsh-autosuggestions** | 命令自动补全 | ✅ 已配置 |
| **zsh-syntax-highlighting** | 语法高亮 | ✅ 已配置 |
| **zsh-completions** | 增强补全 | ✅ 已配置 |
| **history-substring-search** | 历史搜索 | ✅ 已配置 |
| **autojump** | 智能跳转 | ✅ 已配置 |

### 插件详细说明

#### 1. zsh-autosuggestions
**功能**：基于历史记录的命令建议
- 输入命令时显示灰色建议
- 按 `→` 键接受建议
- 按 `Ctrl + →` 接受部分建议

#### 2. zsh-syntax-highlighting
**功能**：实时语法高亮
- 命令高亮为绿色
- 错误命令高亮为红色
- 路径高亮为蓝色

#### 3. zsh-completions
**功能**：增强的命令补全
- 支持更多命令的补全
- 智能路径补全
- 参数补全

#### 4. history-substring-search
**功能**：历史记录搜索
```bash
# 快捷键
Ctrl + ↑    " 搜索历史命令（向上）
Ctrl + ↓    " 搜索历史命令（向下）
```

#### 5. autojump
**功能**：智能目录跳转
```bash
# 使用方法
j 目录名    " 快速跳转到目录
jc 目录名   " 只跳转到子目录
jo 目录名   " 在文件管理器中打开
```

## 🎨 主题配置

### Powerlevel10k 特性
- **自适应提示符**：根据目录内容显示不同信息
- **Git 状态**：显示分支、状态、提交数
- **时间显示**：显示命令执行时间
- **错误状态**：显示命令执行结果
- **Python 环境**：显示虚拟环境

### 自定义配置
```bash
# 重新配置主题
p10k configure

# 手动编辑配置
vim ~/.p10k.zsh
```

### 常用配置选项
- **字符集**：推荐使用 Nerd Fonts
- **颜色方案**：支持浅色/深色主题
- **图标样式**：多种图标风格可选
- **提示符样式**：可自定义显示内容

## ⌨️ 快捷键说明

### 基础快捷键
```bash
# 移动
Ctrl + a    " 行首
Ctrl + e    " 行尾
Ctrl + b    " 左移一个字符
Ctrl + f    " 右移一个字符
Ctrl + u    " 删除到行首
Ctrl + k    " 删除到行尾

# 历史
Ctrl + r    " 搜索历史命令
Ctrl + ↑    " 向上搜索历史
Ctrl + ↓    " 向下搜索历史
```

### 插件快捷键
```bash
# 自动补全
→           " 接受建议
Ctrl + →    " 接受部分建议

# 历史搜索
Ctrl + ↑    " 向上搜索历史
Ctrl + ↓    " 向下搜索历史
```

### 窗口管理
```bash
# 分屏
Ctrl + h    " 左分屏
Ctrl + j    " 下分屏
Ctrl + k    " 上分屏
Ctrl + l    " 右分屏
```

## 🎯 功能特性

### 智能补全
- **命令补全**：基于历史记录
- **路径补全**：智能路径建议
- **参数补全**：命令参数提示
- **文件补全**：Tab 键补全文件

### 历史记录
- **增量搜索**：实时搜索历史
- **去重**：自动去除重复命令
- **时间戳**：记录命令执行时间
- **共享历史**：多个终端共享历史

### 别名系统
```bash
# 常用别名
ll          " ls -la
la          " ls -A
l           " ls -CF
..          " cd ..
...         " cd ../..
....        " cd ../../..
```

### 函数增强
```bash
# 目录操作
mkcd        " 创建目录并进入
extract     " 解压各种格式文件
```

## 🔧 自定义配置

### 添加别名
```bash
# 在 .zshrc 中添加
alias 别名='命令'
```

### 添加函数
```bash
# 在 .zshrc 中添加
function 函数名() {
    # 函数内容
}
```

### 修改插件
```bash
# 在 .zshrc 中修改 plugins 数组
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

### 自定义提示符
```bash
# 在 .zshrc 中添加
PROMPT='%n@%m %~ %# '
```

## 🚨 故障排除

### 常见问题

#### 1. 插件不工作
```bash
# 检查插件是否正确安装
ls ~/.oh-my-zsh/custom/plugins/

# 重新安装插件
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
```

#### 2. 主题不显示
```bash
# 检查主题是否正确安装
ls ~/.oh-my-zsh/custom/themes/powerlevel10k

# 重新安装主题
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
```

#### 3. 自动补全不工作
```bash
# 检查插件配置
grep -n "zsh-autosuggestions" ~/.zshrc

# 重新加载配置
source ~/.zshrc
```

#### 4. 语法高亮不工作
```bash
# 检查插件顺序（zsh-syntax-highlighting 必须在最后）
tail -5 ~/.zshrc
```

### 重置配置
```bash
# 备份当前配置
cp ~/.zshrc ~/.zshrc.backup

# 重新安装 Oh My Zsh
rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## 📦 插件管理

### 安装新插件
```bash
# 克隆插件到自定义目录
git clone https://github.com/用户名/插件名.git ~/.oh-my-zsh/custom/plugins/插件名

# 在 .zshrc 中添加插件
plugins=(... 插件名)
```

### 更新插件
```bash
# 更新 Oh My Zsh
omz update

# 更新特定插件
cd ~/.oh-my-zsh/custom/plugins/插件名
git pull
```

### 删除插件
```bash
# 从 .zshrc 中移除插件
# 删除插件目录
rm -rf ~/.oh-my-zsh/custom/plugins/插件名
```

## 🎯 使用建议

### 新手入门
1. 熟悉基础快捷键（Ctrl + a/e, Ctrl + r）
2. 使用 Tab 键进行补全
3. 使用 `j` 命令快速跳转目录
4. 使用 `Ctrl + r` 搜索历史命令

### 进阶使用
1. 自定义别名和函数
2. 配置 Powerlevel10k 主题
3. 添加更多插件
4. 优化性能设置

### 工作流程
1. 使用 `j 目录名` 快速跳转
2. 使用自动补全提高效率
3. 使用历史搜索重复命令
4. 使用别名简化常用操作

## 🔗 相关资源

### 官方文档
- [Zsh 官方文档](https://zsh.sourceforge.io/Doc/)
- [Oh My Zsh 文档](https://ohmyz.sh/)
- [Powerlevel10k 文档](https://github.com/romkatv/powerlevel10k)

### 插件资源
- [Zsh 插件列表](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)
- [Awesome Zsh](https://github.com/unixorn/awesome-zsh-plugins)

---

**提示**：这个配置提供了现代化的 Zsh 体验，适合日常开发使用。 