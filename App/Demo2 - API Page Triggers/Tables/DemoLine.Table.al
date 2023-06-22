table 60202 DemoLine
{
    fields
    {
        field(1; HeaderNumber; Code[20]) { }
        field(2; LineNumber; Integer) { }
        field(3; HeaderId; Guid) { }
        field(4; Field4; Text[30]) { }
        field(5; Field5; Decimal) { }
    }

    keys
    {
        key(PK; HeaderNumber, LineNumber) { Clustered = true; }
    }
}