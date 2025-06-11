# file_handler.py
import sys
import os
from PySide6.QtCore import QObject, Signal, Slot
from PySide6.QtWidgets import QFileDialog # Make sure QApplication is used in main.py, not QGuiApplication

class FileHandler(QObject):
    # Signals to send results back to QML
    filePathSelected = Signal(str)      # For open/upload: emits the selected file path
    savePathConfirmed = Signal(str)     # For save/download: emits the confirmed save path
    fileContentOpened = Signal(str, str) # Emits (title, content) after a file is opened

    def __init__(self, parent=None):
        super().__init__(parent)

    # Slots - These are callable from QML
    @Slot(str, str, str) # Specify the argument types if you want to call it from QML
    def updateContent(self, filepath, title_text, content_text):  # function to update the text files
        try:
            with open(filepath, 'w', encoding='utf-8') as file: # Added encoding for broader compatibility
                file.write(content_text)
            print(f"Python: Content successfully saved to: {filepath}")
        except Exception as e:
            print(f"Python: Error saving content to {filepath}: {e}")

    @Slot(str, str) # New slot to be called from QML after save dialog
    def saveTextToFile(self, save_path, content):
        try:
            with open(save_path, 'w', encoding='utf-8') as file:
                file.write(content)
            print(f"Python: Successfully wrote content to {save_path}")
        except Exception as e:
            print(f"Python: Error writing content to {save_path}: {e}")


    @Slot()
    def openFileDialog(self):
        # QFileDialog.getOpenFileName returns a tuple (filename, filter)
        file_path_tuple = QFileDialog.getOpenFileName(
                None,
                "Select File to Open",    # Dialog Title
                "",                       # Starting directory
                "Text Files (*.txt);;All files (*);;Images (*.png *.jpg *.jpeg)" # Option
                )
        file_path = file_path_tuple[0] # Extract just the path

        if file_path:
            print(f"Python: File selected for open: {file_path}")
            # Emit the selected path to QML so QML can then request to open it
            self.filePathSelected.emit(file_path)
        else:
            print("Python: File selection cancelled.")
            self.filePathSelected.emit("") # Emit empty string or special value

    @Slot()
    def saveFileDialog(self):
        # QFileDialog.getSaveFileName returns a tuple (filename, filter)
        file_path_tuple = QFileDialog.getSaveFileName(
                None,
                "Save File As...",  # Dialog title
                "untitled.txt",     # Default File name
                "Text Files (*.txt);;All Files (*)"  # File filters
                )
        file_path = file_path_tuple[0] # Extract just the path

        if file_path:
            print(f"Python: Save path confirmed: {file_path}")
            # Emit the confirmed save path to QML
            self.savePathConfirmed.emit(file_path)
        else:
            print("Python: Save operation cancelled.")
            self.savePathConfirmed.emit("") # Emit empty string or a special value

    @Slot(str) # openFile now takes one string argument: filepath
    def openFile(self, filepath):
        try:
            with open(filepath, 'r', encoding='utf-8') as file: # Added encoding
                # Extract filename without path and extension for title
                title_name = os.path.splitext(os.path.basename(filepath))[0]
                content = file.read()
                print(f"Python: Opened file - Title: '{title_name}', Content length: {len(content)}")
                self.fileContentOpened.emit(title_name, content) # Use the new signal
        except FileNotFoundError:
            print(f"Python: Error - File not found: {filepath}")
            self.fileContentOpened.emit("", "") # Emit empty if file not found
        except Exception as e:
            print(f"Python: Error reading file {filepath}: {e}")
            self.fileContentOpened.emit("", "") # Emit empty if error
