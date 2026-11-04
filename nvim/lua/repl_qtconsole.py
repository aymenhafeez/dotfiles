import json
import queue
import sys
import threading

from qtconsole.qtconsoleapp import JupyterQtConsoleApp
from qtpy import QtCore


def read_input(snippets):
    for line in sys.stdin:
        snippets.put(json.loads(line))

    snippets.put(None)


def dispatch(app, snippets):
    widget = app.widget
    if widget._starting or widget._executing or widget._reading:
        return

    try:
        code = snippets.get_nowait()
    except queue.Empty:
        return

    if code is None:
        app.window.close()
    else:
        widget.execute(code)


def main():
    app = JupyterQtConsoleApp.instance()
    app.initialize(["--JupyterQtConsoleApp.confirm_exit=False"])
    snippets = queue.Queue()
    threading.Thread(target=read_input, args=(snippets,), daemon=True).start()

    timer = QtCore.QTimer()
    timer.timeout.connect(lambda: dispatch(app, snippets))
    timer.start(25)
    app.start()


if __name__ == "__main__":
    main()
