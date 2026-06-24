if command -sq nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx MANPAGER 'nvim +Man!'
end

set -gx ZED_ALLOW_EMULATED_GPU 0
set -gx MESA_VK_DEVICE_SELECT 8086:46a6
set -gx _ZO_FZF_OPTS "--border=none --height=50% --layout=reverse --info=inline --scrollbar \"▐\" --tiebreak=length,end --color=border:0,fg:-1,bg:-1,fg+:-1:reverse,bg+:-1,hl:3,hl+:3:reverse,pointer:-1,marker:4,info:-1,prompt:-1,gutter:0 --preview \"eza --color=always {2}\" --preview-window \"right:40%\""

# set -gx _ZO_FZF_OPTS "
#   --height=50%
#   --layout=reverse
#   --color=bg+:#1e2430
#   --color=bg:#0e1018
#   --color=border:#222838
#   --color=fg:#c8d0e0
#   --color=fg+:#dce4f0
#   --color=gutter:#0e1018
#   --color=header:#80c8e0
#   --color=hl:#80c8e0
#   --color=hl+:#98d8f0
#   --color=info:#586478
#   --color=marker:#90c8a0
#   --color=pointer:#80c8e0
#   --color=prompt:#b0a0d8
#   --color=query:#c8d0e0
#   --color=scrollbar:#222838
#   --color=separator:#222838
#   --color=spinner:#80c8e0
#   --preview \"eza --color=always {2}\"
#   --preview-window \"right:40%\"
# "
