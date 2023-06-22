codeunit 60201 GLEntriesAPIMgt
{
    Access = Internal;
    procedure GetIncomeTransactions(var GLEntryBuffer: Record GLEntryBuffer)
    var
        Transactions: Query GLEntries;
    begin
        Transactions.SetRange(GlobalDimension1Code, 'QR00000', 'QR99999');
        Transactions.SetFilter(ShortcutDimension4Code, '%1|%2', 'XPRA01', '#');
        Transactions.SetRange(BalanceAccountType, "Gen. Journal Account Type"::Customer);
        Transactions.SetRange(IncomeBalance, Transactions.IncomeBalance::"Balance Sheet");
        Transactions.SetRange(AccountCategory, "G/L Account Category"::Assets);
        Transactions.SetRange(AccountSubcategory, 'Bank and Cash');
        Transactions.SetRange(AccountType, "G/L Account Type"::Posting);
        Transactions.SetRange(PostingDate, GLEntryBuffer.GetMinDateFilter(), GLEntryBuffer.GetMaxDateFilter());

        Transactions.Open();

        while Transactions.Read() do
            GLEntryBuffer.CopyFromTransaction(Transactions);

        Transactions.Close();
    end;
}