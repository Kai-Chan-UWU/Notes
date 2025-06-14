# /utils/eventbridge.py
from PySide6.QtCore import QObject, Signal, Slot

class EventBridge(QObject):
    dayClicked = Signal (str)
    
    def __init__(self):
        super().__init__()

