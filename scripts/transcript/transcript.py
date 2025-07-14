#! /usr/bin/python3
import i3ipc

ipc = i3ipc.Connection()

transparent = [
    "sioyek",
    "org.pwmt.zathura"
]

def on_window_focus(ipc, e):
    for c in ipc.get_tree():
        if (c.focused or c.type == "floating_con") and (c.window_class not in transparent) and (c.app_id not in transparent):
            c.command('opacity 1')
        else:
            c.command('opacity 0.9')


ipc.on("window::focus", on_window_focus)
ipc.main()
