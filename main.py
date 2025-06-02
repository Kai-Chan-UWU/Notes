import sys
import os
import signal
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Get the directory of the current script
    # This makes the path relative to our project
    script_dir = os.path.dirname(os.path.realpath(__file__))

    # Construct the path to 'qml' directory
    qml_dir = os.path.join(script_dir, 'qml')
    print("Adding QML import path: {qml_dir}")
    engine.addImportPath(qml_dir)

    # Now load the main QML file. Since 'qml_dir' is in the import path
    engine.load(os.path.join(qml_dir, 'MainApp.qml'))

    if not engine.rootObjects():
        sys.exit(-1)

    signal.signal(signal.SIGINT, signal.SIG_DFL)
    sys.exit(app.exec())
