# Created By: Virgil Dupras
# Created On: 2009-10-31
# Copyright 2010 Hardcoded Software (http://www.hardcoded.net)
# 
# This software is licensed under the "BSD" License as described in the "LICENSE" file, 
# which should be included with this package. The terms are also available at 
# http://www.hardcoded.net/licenses/bsd_license

from PyQt4.QtCore import Qt
from PyQt4.QtGui import QPixmap

from qtlib.column import Column
from hscommon.trans import tr
from core.gui.transaction_table import TransactionTable as TransactionTableModel
from ...support.item_delegate import ItemDecoration
from ..table import TableDelegate, DATE_EDIT, DESCRIPTION_EDIT, PAYEE_EDIT, ACCOUNT_EDIT
from ..table_with_transactions import TableWithTransactions

class TransactionTableDelegate(TableDelegate):
    def __init__(self, model, columns):
        TableDelegate.__init__(self, model, columns)
        arrow = QPixmap(':/right_arrow_gray_12')
        arrowSelected = QPixmap(':/right_arrow_white_12')
        self._decoFromArrow = ItemDecoration(arrow, self._model.show_from_account)
        self._decoFromArrowSelected = ItemDecoration(arrowSelected, self._model.show_from_account)
        self._decoToArrow = ItemDecoration(arrow, self._model.show_to_account)
        self._decoToArrowSelected = ItemDecoration(arrowSelected, self._model.show_to_account)
    
    def _get_decorations(self, index, isSelected):
        column = self._columns[index.column()]
        if column.attrname == 'from':
            return [self._decoFromArrowSelected if isSelected else self._decoFromArrow]
        elif column.attrname == 'to':
            return [self._decoToArrowSelected if isSelected else self._decoToArrow]
        else:
            return []
    

class TransactionTable(TableWithTransactions):
    COLUMNS = [
        Column('status', '', 25, cantTruncate=True),
        Column('date', tr('Date'), 86, editor=DATE_EDIT, cantTruncate=True),
        Column('description', tr('Description'), 230, editor=DESCRIPTION_EDIT),
        Column('payee', tr('Payee'), 150, editor=PAYEE_EDIT),
        Column('checkno', tr('Check #'), 80),
        Column('from', tr('From'), 120, editor=ACCOUNT_EDIT),
        Column('to', tr('To'), 120, editor=ACCOUNT_EDIT),
        Column('amount', tr('Amount'), 100, alignment=Qt.AlignRight, cantTruncate=True),
    ]
    
    def __init__(self, transaction_view, view):
        model = TransactionTableModel(view=self, transaction_view=transaction_view.model)
        TableWithTransactions.__init__(self, model, view)
        self.tableDelegate = TransactionTableDelegate(self.model, self.COLUMNS)
        self.view.setItemDelegate(self.tableDelegate)
        self.view.sortByColumn(1, Qt.AscendingOrder) # sorted by date by default
        self.view.deletePressed.connect(self.model.delete)
    
