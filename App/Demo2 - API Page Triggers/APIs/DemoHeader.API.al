page 60201 DemoHeaderAPI
{
    PageType = API;
    APIPublisher = 'cronus';
    APIGroup = 'demo';
    APIVersion = 'v1.0';
    EntitySetName = 'demoHeaders';
    EntityName = 'demoHeader';
    DelayedInsert = true;
    SourceTable = DemoHeader;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(records)
            {
                field(id; Rec.SystemId) { }
                field(number; Rec.Number) { }
                field(field2; Rec.Field2)
                {
                    trigger OnValidate()
                    begin
                        WriteLog('OnValidate', 'Field2');
                    end;
                }
                field(field3; Rec.Field3)
                {
                    trigger OnValidate()
                    begin
                        WriteLog('OnValidate', 'Field3');
                    end;
                }
                field(field4; Rec.Field4)
                {
                    trigger OnValidate()
                    begin
                        WriteLog('OnValidate', 'Field4');
                    end;
                }
                field(field5; Rec.Field5)
                {
                    trigger OnValidate()
                    begin
                        WriteLog('OnValidate', 'Field5');
                    end;
                }
                field(field6; Rec.Field6)
                {
                    trigger OnValidate()
                    begin
                        WriteLog('OnValidate', 'Field6');
                    end;
                }
                field(field7; Rec.Field7)
                {
                    trigger OnValidate()
                    var
                        TypeHelper: Codeunit "Type Helper";
                        SessionSettings: SessionSettings;
                        Offset: Duration;
                    begin
                        TypeHelper.GetTimezoneOffset(Offset, 'UTC');
                        Rec.Field7 += Offset;
                        Rec.Field9 := Offset;
                        WriteLog('OnValidate', 'Field7');
                    end;
                }
                field(field8; Rec.Field8)
                {
                    trigger OnValidate()
                    begin
                        WriteLog('OnValidate', 'Field8');
                    end;
                }
                field(field9; Rec.Field9)
                {
                    Caption = 'A perfect field number 9';
                    trigger OnValidate()
                    begin
                        WriteLog('OnValidate', 'Field9');
                    end;
                }
                field(lastModifiedAt; Rec.SystemModifiedAt) { }

                part(demoLines; DemoLineAPI)
                {
                    // EntitySetName = 'demoLines';
                    // EntityName = 'demoLine';
                    SubPageLink = HeaderId = field(SystemId);
                }
            }
        }
    }

    var
        TempDemoLog: Record LogAPITrigger temporary;
        NextEntryNo: Integer;


    trigger OnInit()
    begin
        WriteLog('OnInit', Rec.GetFilters());
    end;

    trigger OnOpenPage()
    begin
        WriteLog('OnOpenPage', Rec.GetFilters());
        SaveLog();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        WriteLog('OnNewRecord');
        SaveLog();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        WriteLog('OnInsertRecord');
        SaveLog();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        WriteLog('OnModifyRecord');
        SaveLog();
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        WriteLog('OnDeleteRecord');
        SaveLog();
    end;

    trigger OnAfterGetRecord()
    begin
        WriteLog('OnAfterGetRecord');
        SaveLog();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        WriteLog('OnAfterGetCurrRecord');
        SaveLog();
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        WriteLog('OnFindRecord');
        SaveLog();
        exit(Rec.Find(Which));
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        WriteLog('OnNextRecord');
        SaveLog();
        exit(Rec.Next(Steps));
    end;

    trigger OnClosePage()
    begin
        WriteLog('OnClosePage');
        SaveLog();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        WriteLog('OnQueryClosePage');
        SaveLog();
        exit(true);
    end;

    local procedure WriteLog(TriggerName: Text)
    begin
        WriteLog(TriggerName, '');
    end;

    local procedure WriteLog(TriggerName: Text; ExtraInfo: Text)
    begin
        NextEntryNo += 1;
        TempDemoLog.Init();
        TempDemoLog.EntryNumber := NextEntryNo;
        TempDemoLog.SessionId := SessionId();
        TempDemoLog.ObjectName := 'DemoHeaderAPI';
        TempDemoLog.TriggerName := TriggerName;
        TempDemoLog.ExtraInfo := ExtraInfo;
        TempDemoLog.Insert();
    end;

    local procedure SaveLog()
    var
        DemoLog: Record LogAPITrigger;
    begin
        if DemoLog.FindLast() then
            NextEntryNo := DemoLog.EntryNumber
        else
            NextEntryNo := 0;
        if TempDemoLog.FindSet() then
            repeat
                NextEntryNo += 1;
                DemoLog := TempDemoLog;
                DemoLog.EntryNumber := NextEntryNo;
                DemoLog.Insert();
            until TempDemoLog.Next() = 0;
        TempDemoLog.DeleteAll();
    end;
}