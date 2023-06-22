table 60200 GLEntryBuffer
{
    TableType = Temporary;
    Caption = 'G/L Entry Buffer';

    fields
    {
        field(1; EntryNumber; Integer) { }
        field(2; CompanyName; Text[30]) { }
        field(4; GlobalDimension1Code; Code[20]) { }
        field(5; DimensionValueName; Text[50]) { }
        field(6; GLAccountNumber; Code[20]) { }
        field(7; Period; Code[7]) { }
        field(8; PostingDate; Date) { }
        field(9; Amount; Decimal) { }
        field(11; DocumentNumber; Code[20]) { }
        field(12; DocumentType; Text[30]) { }
        field(13; Description; Text[100]) { }
    }

    internal procedure CopyFromTransaction(GLEntries: Query GLEntries)
    begin
        Rec.Init();
        Rec.EntryNumber := GLEntries.EntryNumber;
        Rec.CompanyName := CompanyName;
        Rec.GlobalDimension1Code := GLEntries.GlobalDimension1Code;
        Rec.DimensionValueName := GLEntries.DimensionValueName;
        Rec.GLAccountNumber := GLEntries.GLAccountNumber;
        Rec.Period := CalcPeriod(GLEntries.PostingDate);
        Rec.PostingDate := GLEntries.PostingDate;
        Rec.Amount := GLEntries.Amount;
        Rec.DocumentNumber := GLEntries.DocumentNumber;
        Rec.DocumentType := Format(GLEntries.DocumentType);
        Rec.Description := GLEntries.Description;
        Rec.Insert();
    end;

    local procedure CalcPeriod(FromDate: Date) Period: Text
    var
        Year, Month : Integer;
    begin
        case true of
            (Date2DMY(FromDate, 2) = 3) and (Date2DMY(FromDate, 1) = 31):
                begin
                    Year := Date2DMY(FromDate, 3);
                    Month := 13;
                end;
            Date2DMY(FromDate, 2) < 4:
                begin
                    Year := Date2DMY(FromDate, 3);
                    Month := Date2DMY(FromDate, 2) + 9;
                end;
            else begin
                Year := Date2DMY(FromDate, 3) + 1;
                Month := Date2DMY(FromDate, 2) - 3;
            end;
        end;
        Period := StrSubstNo('%1%2', Year, Format(Month).PadLeft(3, '0'));
    end;

    var
        PeriodFilterMustBeInFormatYYYYMMMErr: Label 'The period filter must be in format YYYYMMM';
        MonthNotInRangeErr: Label 'The month is not in range 001 - 013';

    procedure GetMinDateFilter() DateValue: Date
    var
        Year, Month, Day : Integer;
        IsClosingPeriod: Boolean;
    begin
        RetrievePostingDateFromFilter(Rec.GetRangeMin(Period), Year, Month, IsClosingPeriod);
        if IsClosingPeriod then
            Day := 31
        else
            Day := 1;

        DateValue := DMY2Date(Day, Month, Year);
    end;

    procedure GetMaxDateFilter() DateValue: Date
    var
        Year, Month, Day : Integer;
        IsClosingPeriod: Boolean;
    begin
        RetrievePostingDateFromFilter(Rec.GetRangeMax(Period), Year, Month, IsClosingPeriod);
        case Month of
            3:
                begin
                    if IsClosingPeriod then
                        Day := 31
                    else
                        Day := 30;
                    DateValue := DMY2Date(Day, Month, Year);
                end;
            else begin
                Day := 1;
                DateValue := DMY2Date(Day, Month, Year);
                DateValue := CalcDate('<1M-1D>', DateValue);
            end;
        end;
    end;

    local procedure RetrievePostingDateFromFilter(FilterText: Code[7]; var Year: Integer; var Month: Integer; var IsClosingPeriod: Boolean)
    var
        IntegerValue: Integer;
    begin
        if not (StrLen(FilterText) = 7) then
            Error(PeriodFilterMustBeInFormatYYYYMMMErr);

        if not Evaluate(IntegerValue, FilterText) then
            Error(PeriodFilterMustBeInFormatYYYYMMMErr);

        Evaluate(Year, CopyStr(FilterText, 1, 4));
        Evaluate(Month, CopyStr(FilterText, 5, 3));

        case Month of
            1, 2, 3, 4, 5, 6, 7, 8, 9:
                begin
                    Year -= 1;
                    Month += 3;
                    IsClosingPeriod := false;
                end;
            10, 11, 12:
                begin
                    Month -= 9;
                    IsClosingPeriod := false;
                end;
            13:
                begin
                    Month := 3;
                    IsClosingPeriod := true;
                end;
            else
                Error(MonthNotInRangeErr);
        end
    end;
}