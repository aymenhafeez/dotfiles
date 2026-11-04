import json
import queue
import sys
import threading


def main():
    from qtconsole.qtconsoleapp import JupyterQtConsoleApp
    from qtpy import QtCore

    app = JupyterQtConsoleApp.instance()
    app.initialize(["--JupyterQtConsoleApp.confirm_exit=False"])
    snippets = queue.Queue()

    def read_input():
        for line in sys.stdin:
            snippets.put(json.loads(line))
        snippets.put(None)

    threading.Thread(target=read_input, daemon=True).start()

    def dispatch():
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

    timer = QtCore.QTimer()
    timer.timeout.connect(dispatch)
    timer.start(25)
    app.start()


if __name__ == "__main__":
    main()
