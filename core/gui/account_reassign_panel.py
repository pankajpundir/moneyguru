# Created By: Virgil Dupras
# Created On: 2009-04-12
# Copyright 2010 Hardcoded Software (http://www.hardcoded.net)
# 
# This software is licensed under the "BSD" License as described in the "LICENSE" file, 
# which should be included with this package. The terms are also available at 
# http://www.hardcoded.net/licenses/bsd_license

from hscommon.trans import tr
from ..model.account import sort_accounts
from .base import MainWindowPanel

class AccountReassignPanel(MainWindowPanel):
    def _load(self, account):
        self.account = account
        accounts = self.document.accounts[:]
        accounts.remove(self.account)
        sort_accounts(accounts)
        self.available_accounts = [a.name for a in accounts]
        self.available_accounts.insert(0, tr('No Account'))
        self._accounts = accounts
        self._accounts.insert(0, None)
        self.account_index = 0
    
    def _save(self):
        reassign_to = self._accounts[self.account_index]
        self.document.delete_account(self.account, reassign_to=reassign_to)
    
