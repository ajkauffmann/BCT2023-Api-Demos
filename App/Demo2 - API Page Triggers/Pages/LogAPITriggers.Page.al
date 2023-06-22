page 60204 LogAPITriggers
{
    PageType = List;
    Caption = 'Log API Triggers';
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = LogAPITrigger;
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(records)
            {
                field(EntryNumber; Rec.EntryNumber) { ApplicationArea = All; }
                field(SessionId; Rec.SessionId) { ApplicationArea = All; }
                field(ObjectName; Rec.ObjectName) { ApplicationArea = All; }
                field(TriggerName; Rec.TriggerName) { ApplicationArea = All; }
                field(ExtraInfo; Rec.ExtraInfo) { ApplicationArea = All; }
                field(SystemCreatedAt; Rec.SystemCreatedAt) { ApplicationArea = All; }
            }
        }
    }
}