python
import sys
import pwndbg.color.memory
import pwndbg.ui

original_banner = pwndbg.ui.banner

def new_banner(title, target=sys.stdout, width=None, extra=""):
    _height, width = pwndbg.ui.get_window_size(target)
    banner_w_indent = original_banner(title,target,width,extra)
    if title == "":
        banner_w_indent = banner_w_indent + original_banner((width-4)*">") + 1*width*" "
    return banner_w_indent

pwndbg.ui.banner = new_banner



if not hasattr(pwndbg.color.memory, 'original_legend'):
    pwndbg.color.memory.original_legend = pwndbg.color.memory.legend

def patched_legend_with_banner():
    _height, width = pwndbg.ui.get_window_size(sys.stdout)
    lines = pwndbg.ui.banner((width-4)*"<")
    banner = pwndbg.ui.banner("legend")
    content = pwndbg.color.memory.original_legend()
    return 2*width*" " + lines+ banner + content

pwndbg.color.memory.legend = patched_legend_with_banner
end




# install pwndbg with:
# curl -qsL 'https://install.pwndbg.re' | sh -s -- -u -t pwndbg-gdb
# -u dont install as root


