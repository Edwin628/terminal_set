# 工具检查和安装清单

## 📋 检查清单

### 🔧 基础工具检查
```bash
# 检查所有工具是否已安装
echo "=== 基础工具检查 ==="
which zsh && echo "✅ Zsh 已安装: $(zsh --version | head -1)"
which bash && echo "✅ Bash 已安装: $(bash --version | head -1)"
which nvim && echo "✅ Neovim 已安装: $(nvim --version | head -1)"
which vim && echo "✅ Vim 已安装: $(vim --version | head -1)"
which tmux && echo "✅ Tmux 已安装: $(tmux -V)"
```

### 📁 配置文件检查
```bash
echo "=== 配置文件检查 ==="
[ -f ~/.zshrc ] && echo "✅ ~/.zshrc 存在" || echo "❌ ~/.zshrc 不存在"
[ -f ~/.bashrc ] && echo "✅ ~/.bashrc 存在" || echo "❌ ~/.bashrc 不存在"
[ -f ~/.vimrc ] && echo "✅ ~/.vimrc 存在" || echo "❌ ~/.vimrc 不存在"
[ -f ~/.tmux.conf ] && echo "✅ ~/.tmux.conf 存在" || echo "❌ ~/.tmux.conf 不存在"
[ -d ~/.config/nvim ] && echo "✅ ~/.config/nvim 目录存在" || echo "❌ ~/.config/nvim 目录不存在"
```

### 🔌 插件检查
```bash
echo "=== 插件检查 ==="
[ -d ~/.oh-my-zsh ] && echo "✅ Oh My Zsh 已安装" || echo "❌ Oh My Zsh 未安装"
[ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ] && echo "✅ Powerlevel10k 已安装" || echo "❌ Powerlevel10k 未安装"
[ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ] && echo "✅ zsh-autosuggestions 已安装" || echo "❌ zsh-autosuggestions 未安装"
[ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ] && echo "✅ zsh-syntax-highlighting 已安装" || echo "❌ zsh-syntax-highlighting 未安装"
[ -d ~/.vim/autoload ] && echo "✅ vim-plug 目录存在" || echo "❌ vim-plug 目录不存在"
[ -d ~/.tmux/plugins/tpm ] && echo "✅ TPM 已安装" || echo "❌ TPM 未安装"
```

## 🚀 安装指南

### macOS 安装
```bash
# 使用 Homebrew 安装
brew install zsh nvim tmux

# 安装 Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 安装 Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# 安装 Zsh 插件
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 安装 vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 安装 TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Ubuntu/Debian 安装
```bash
# 更新包列表
sudo apt update

# 安装基础工具
sudo apt install zsh nvim tmux git curl

# 安装 Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 安装 Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# 安装 Zsh 插件
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 安装 vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 安装 TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### CentOS/RHEL 安装
```bash
# 安装 EPEL 仓库
sudo yum install epel-release

# 安装基础工具
sudo yum install zsh nvim tmux git curl

# 安装 Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 安装 Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# 安装 Zsh 插件
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 安装 vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 安装 TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## 🔧 配置步骤

### 1. 复制配置文件
```bash
# 复制 Zsh 配置
cp .zshrc ~/.zshrc

# 复制 Bash 配置
cp .bashrc ~/.bashrc

# 复制 Vim 配置
cp .vimrc ~/.vimrc

# 复制 Tmux 配置
cp .tmux.conf ~/.tmux.conf

# 复制 Neovim 配置
cp -r .config/nvim ~/.config/
```

### 2. 安装插件
```bash
# 安装 Vim 插件
vim +PlugInstall +qall

# 安装 Tmux 插件
tmux source-file ~/.tmux.conf
# 在 tmux 中按 Ctrl + a, I 安装插件

# 安装 Neovim 插件
nvim --headless -c "Lazy install" -c "qa"
```

### 3. 设置默认 Shell
```bash
# 设置 Zsh 为默认 Shell
chsh -s $(which zsh)

# 重新登录或重启终端
```

## ✅ 验证安装

### 验证 Zsh 配置
```bash
# 启动 Zsh
zsh

# 检查插件是否工作
# 输入命令时应该有自动补全
# 命令应该有语法高亮
```

### 验证 Vim 配置
```bash
# 启动 Vim
vim

# 检查插件是否加载
:PlugStatus
```

### 验证 Neovim 配置
```bash
# 启动 Neovim
nvim

# 检查插件是否加载
:Lazy
```

### 验证 Tmux 配置
```bash
# 启动 Tmux
tmux

# 检查插件是否工作
# 状态栏应该显示美化信息
```

## 🚨 故障排除

### 常见问题解决

#### 1. 权限问题
```bash
# 修复权限
chmod +x ~/.oh-my-zsh/oh-my-zsh.sh
chmod +x ~/.tmux/plugins/tpm/tpm
```

#### 2. 网络问题
```bash
# 使用镜像源
export ZSH_CUSTOM=~/.oh-my-zsh/custom
git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k
```

#### 3. 依赖问题
```bash
# 安装必要依赖
sudo apt install build-essential python3-dev nodejs npm
```

## 📝 完成检查

### 最终验证
```bash
# 运行完整检查脚本
./check_installation.sh

# 或者手动检查
echo "=== 最终验证 ==="
echo "1. Zsh 是否正常工作？"
echo "2. Powerlevel10k 主题是否显示？"
echo "3. 自动补全是否工作？"
echo "4. 语法高亮是否工作？"
echo "5. Vim 插件是否加载？"
echo "6. Neovim 插件是否加载？"
echo "7. Tmux 插件是否工作？"
```

---

**提示**：按照此清单逐步检查和安装，确保所有工具都正确配置。 