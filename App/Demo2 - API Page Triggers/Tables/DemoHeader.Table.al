table 60201 DemoHeader
{
    fields
    {
        field(1; Number; Code[20]) { }
        field(2; Field2; Text[30]) { }
        field(3; Field3; Integer) { }
        field(4; Field4; Decimal) { }
        field(5; Field5; Boolean) { }
        field(6; Field6; Date) { }
        field(7; Field7; Time) { }
        field(8; Field8; DateTime) { }
        field(9; Field9; Duration) { }
    }

    trigger OnInsert()
    var
        NextNumber: Integer;
    begin
        NextNumber := NumberSequence.Next('DemoHeader', true);
        Number := StrSubstNo('HEADER%1', Format(NextNumber).PadLeft(5, '0'));
    end;
}