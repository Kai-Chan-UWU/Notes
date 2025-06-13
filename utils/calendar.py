# utils/calendar_backend.py
import sys
from datetime import date, timedelta
from PySide6.QtCore import QObject, QUrl, Slot, Property, QAbstractListModel, QModelIndex, Qt, Signal
from PySide6.QtGui import QGuiApplication # Not strictly needed here, but kept for context (can remove if not used elsewhere)
from PySide6.QtQml import QQmlApplicationEngine # qml_register_type REMOVED
from PySide6.QtCore import QDate # Explicitly import QDate

class CalendarModel(QAbstractListModel):
    # --- Roles ---
    DateRole = Qt.UserRole + 1
    HasNotesRole = Qt.UserRole + 2
    FullDateRole = Qt.UserRole + 3

    # --- Signals for Properties ---
    _current_year_changed = Signal()
    _current_month_changed = Signal()
    _month_name_changed = Signal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self._dates_data = []
        self._current_year_val = date.today().year
        self._current_month_val = date.today().month
        self.set_month(self._current_year_val, self._current_month_val)

    # --- QAbstractListModel Required Methods ---
    def rowCount(self, parent=QModelIndex()):
        return len(self._dates_data)

    def data(self, index, role=Qt.DisplayRole):
        if not index.isValid() or not (0 <= index.row() < len(self._dates_data)):
            return None

        item_data = self._dates_data[index.row()]
        if role == self.DateRole:
            return item_data.get("day")
        elif role == self.HasNotesRole:
            return item_data.get("hasNotes", False)
        elif role == self.FullDateRole:
            return item_data.get("fullDate")
        return None

    def roleNames(self):
        return {
            self.DateRole: b"date",
            self.HasNotesRole: b"hasNotes",
            self.FullDateRole: b"fullDate"
        }

    # --- Calendar Logic Methods ---
    def _fetch_notes_status_for_month(self, year, month):
        # DUMMY: Replace with your actual note fetching logic
        notes_on_dates_julian = {
            QDate(year, month, 5).toJulianDay(),
            QDate(year, month, 12).toJulianDay(),
            QDate(year, month, 20).toJulianDay()
        }
        return notes_on_dates_julian

    @Slot(int, int)
    def set_month(self, year, month):

        self.beginResetModel()

        self._current_year_val = year
        self._current_month_val = month

        self._dates_data.clear()

        first_day_of_month = date(year, month, 1)
        start_day_of_week = (first_day_of_month.weekday() + 1) % 7

        notes_in_month = self._fetch_notes_status_for_month(year, month)

        for _ in range(start_day_of_week):
            self._dates_data.append({"day": "", "hasNotes": False, "fullDate": QDate()})

        current_day = first_day_of_month
        while current_day.month == month:
            qdate_obj = QDate(current_day.year, current_day.month, current_day.day)
            self._dates_data.append({
                "day": str(current_day.day),
                "hasNotes": qdate_obj.toJulianDay() in notes_in_month,
                "fullDate": {
                    "year": qdate_obj.year(),
                    "month": qdate_obj.month(),
                    "day": qdate_obj.day()
                }
            })
            current_day += timedelta(days=1)

        self.endResetModel()

        self._current_year_changed.emit()
        self._current_month_changed.emit()
        self._month_name_changed.emit()

    # --- Properties for QML to read ---
    @Property(int, notify=_current_year_changed)
    def current_year(self):
        return self._current_year_val

    @Property(int, notify=_current_month_changed)
    def current_month(self):
        return self._current_month_val

    @Property(str, notify=_month_name_changed)
    def month_name(self):
        return date(self._current_year_val, self._current_month_val, 1).strftime("%B %Y")

    @Property(int, notify=_month_name_changed)
    def count(self):
        return self.rowCount()


class CalendarBackend(QObject):
    _month_name_changed = Signal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self._calendar_model = CalendarModel()
        self._calendar_model._month_name_changed.connect(self._month_name_changed.emit)

    @Property(QObject, constant=True)
    def calendarModel(self):
        return self._calendar_model

    @Property(str, notify=_month_name_changed)
    def month_name(self):
        return self._calendar_model.month_name

    @Slot()
    def prev_month(self):
        current_date_obj = date(self._calendar_model.current_year, self._calendar_model.current_month, 1)
        prev_month_date = (current_date_obj - timedelta(days=1)).replace(day=1)
        self._calendar_model.set_month(prev_month_date.year, prev_month_date.month)

    @Slot()
    def next_month(self):
        current_date_obj = date(self._calendar_model.current_year, self._calendar_model.current_month, 1)
        next_month_date = date(current_date_obj.year + 1, 1, 1) if current_date_obj.month == 12 else date(current_date_obj.year, current_date_obj.month + 1, 1)
        self._calendar_model.set_month(next_month_date.year, next_month_date.month)
