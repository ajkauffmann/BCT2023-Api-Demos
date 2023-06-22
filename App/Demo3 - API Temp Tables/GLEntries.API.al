page 60200 IncomeAPIv10
{
    PageType = API;
    DataAccessIntent = ReadOnly;
    APIPublisher = 'cronus';
    APIGroup = 'data';
    APIVersion = 'v1.0';
    EntitySetName = 'glEntries';
    EntityName = 'glEntry';
    Editable = false;
    SourceTable = GLEntryBuffer;

    layout
    {
        area(Content)
        {
            repeater(records)
            {
                field(companyName; Rec.CompanyName) { }
                field(glAccountNumber; Rec.GLAccountNumber) { }
                field(dimensionCode; Rec.GlobalDimension1Code) { }
                field(dimensionName; Rec.DimensionValueName) { }
                field(period; Rec.Period) { }
                field(postingDate; Rec.PostingDate) { }
                field(amount; Rec.Amount) { }
                field(documentNumber; Rec.DocumentNumber) { }
                field(documentType; Rec.DocumentType) { }
                field(description; Rec.Description) { }
                field(entryNumber; Rec.EntryNumber) { }
            }
        }
    }

    trigger OnOpenPage()
    var
        GLEntriesAPIMgt: Codeunit GLEntriesAPIMgt;
    begin
        GLEntriesAPIMgt.GetIncomeTransactions(Rec);
    end;
}