if command -sq nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx MANPAGER 'nvim +Man!'
end

set -gx ZED_ALLOW_EMULATED_GPU 0
set -gx MESA_VK_DEVICE_SELECT 8086:46a6
