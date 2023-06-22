table 60203 LogAPITrigger
{
    fields
    {
        field(1; EntryNumber; Integer) { Caption = 'Entry No.'; }
        field(2; SessionId; Integer) { Caption = 'Session Id'; }
        field(3; ObjectName; Text[30]) { Caption = 'Object Name'; }
        field(4; TriggerName; Text[30]) { Caption = 'Trigger'; }
        field(5; ExtraInfo; Text[2048]) { Caption = 'Extra Info'; }
    }
}