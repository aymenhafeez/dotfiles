if command -sq nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx MANPAGER 'nvim +Man!'
end

set -gx ZED_ALLOW_EMULATED_GPU 0
set -gx MESA_VK_DEVICE_SELECT 8086:46a6
set -gx _ZO_FZF_OPTS "--height=40% --layout=reverse --info=inline --scrollbar \"▐\" --tiebreak=length,end --color=fg:-1,bg:-1,fg+:-1:reverse,bg+:-1,hl:3,hl+:3:reverse,pointer:-1,marker:4,info:-1,prompt:-1,gutter:-1 --preview \"ls -a {2}\" --preview-window \"right:40%\""
