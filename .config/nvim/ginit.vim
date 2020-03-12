exec "GuiFont! Hack NF:h10"

" Disable GUI popupmenu
if exists(':GuiPopupmenu') == 2
    GuiPopupmenu 0
endif

" Disable GUI tabline
if exists(':GuiTabline') == 2
    GuiTabline 0
endif

call GuiWindowMaximized(1)
