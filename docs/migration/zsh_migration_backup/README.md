# 🚀 ZSH 配置迁移说明

## 📋 配置文件说明

### `.zshrc` - 精简版终端体验配置
专注于终端体验的轻量级配置：
- ✅ Powerlevel10k 主题和 instant prompt
- ✅ 插件系统（自动建议、语法高亮等）
- ✅ 终端优化设置
- ❌ 不包含环境变量
- ❌ 不包含系统特定配置

## 🎯 配置特点

### 包含的终端体验功能
- **Powerlevel10k 主题** - 美观的提示符和图标
- **zsh-autosuggestions** - 命令自动建议
- **zsh-syntax-highlighting** - 语法高亮
- **zsh-completions** - 增强补全
- **history-substring-search** - 历史搜索
- **autojump** - 智能目录跳转
- **git** - Git 集成

### 性能优化
- Powerlevel10k instant prompt
- 快速启动优化
- 轻量级配置（仅 22 行）

## 🔧 安装脚本

安装脚本会自动：
1. 检测系统环境
2. 安装基础工具
3. 安装 Oh My Zsh
4. 安装 Powerlevel10k 主题
5. 安装所有插件
6. 复制精简版配置文件
7. 安装字体
8. 设置默认 shell

## 📝 使用方法

### 自动安装
```bash
chmod +x install_on_linux.sh
./install_on_linux.sh
```

### 手动安装
参考 `manual_install_guide.md` 进行逐步安装

## 🔄 环境变量处理

如果需要添加环境变量，可以在安装后手动编辑 `~/.zshrc`：

```bash
# 编辑配置文件
nano ~/.zshrc

# 在文件末尾添加你的环境变量
export PATH="/your/custom/path:$PATH"
export MY_VAR="my_value"
```

## 🧪 测试配置

安装完成后，运行测试脚本验证功能：

```bash
./test_zsh_config.sh
```

## 📞 获取帮助

如果遇到问题：
1. 检查配置文件是否正确复制
2. 确认插件是否正确安装
3. 查看安装日志
4. 参考 `manual_install_guide.md`

## 🎉 优势

- 🚀 **轻量级** - 仅 22 行配置
- 🔧 **无冲突** - 避免环境变量冲突
- 🎨 **专注体验** - 专注于终端体验
- 📦 **易维护** - 简洁清晰的配置
- 🔄 **通用性** - 适用于各种 Linux 发行版 