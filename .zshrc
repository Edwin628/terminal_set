# 🚀 Powerlevel10k instant prompt（放首位加速启动）
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# 🌟 Oh My Zsh & 主题设置
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# 🧠 插件系统增强
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
  history-substring-search
  autojump
)

source $ZSH/oh-my-zsh.sh

# 🎨 加载 Powerlevel10k 主题配置
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh