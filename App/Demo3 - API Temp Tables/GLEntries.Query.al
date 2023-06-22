query 60200 GLEntries
{
    DataAccessIntent = ReadOnly;
    Access = Internal;
    Caption = 'Transactions';

    elements
    {
        dataitem(GLAccount; "G/L Account")
        {
            filter(IncomeBalance; "Income/Balance") { }
            filter(AccountCategory; "Account Category") { }
            filter(AccountSubcategory; "Account Subcategory Descript.") { }
            filter(AccountType; "Account Type") { }
            dataitem(GLEntries; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = GLAccount."No.";
                filter(ShortcutDimension4Code; "Shortcut Dimension 4 Code") { }
                filter(BalanceAccountType; "Bal. Account Type") { }
                column(EntryNumber; "Entry No.") { }
                column(GLAccountNumber; "G/L Account No.") { }
                column(PostingDate; "Posting Date") { }
                column(DocumentType; "Document Type") { }
                column(DocumentNumber; "Document No.") { }
                column(Description; Description) { }
                column(Amount; Amount) { }
                column(GlobalDimension1Code; "Global Dimension 1 Code") { }
                column(SystemCreatedAt; SystemCreatedAt) { }
                dataitem(DimensionValue; "Dimension Set Entry")
                {
                    DataItemLink = "Dimension Set ID" = GLEntries."Dimension Set ID", "Dimension Value Code" = GLEntries."Global Dimension 1 Code";
                    SqlJoinType = LeftOuterJoin;
                    column(DimensionValueName; "Dimension Value Name") { }
                }
            }
        }
    }
}