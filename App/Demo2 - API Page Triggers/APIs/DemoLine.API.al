page 60202 DemoLineAPI
{
    PageType = API;
    APIPublisher = 'cronus';
    APIGroup = 'demo';
    APIVersion = 'v1.0';
    EntitySetName = 'demoLines';
    EntityName = 'demoLine';
    DelayedInsert = true;
    SourceTable = DemoLine;
    ODataKeyFields = SystemId;
    AutoSplitKey = true;
    PopulateAllFields = true;

    layout
    {
        area(Content)
        {
            repeater(records)
            {
                field(id; Rec.SystemId) { }
                field(headerEntryNumber; Rec.HeaderNumber)
                {
                    trigger OnValidate()
                    begin
                        WriteLog('OnValidate', 'HeaderEntryNumber');
                    end;
                }
                field(lineNumber; Rec.LineNumber)
                {
                    trigger OnValidate()
                    begin
                        WriteLog('OnValidate', 'LineNumber');
                    end;
                }
                field(headerId; Rec.HeaderId)
                {
                    trigger OnValidate()
                    begin
                        WriteLog('OnValidate', 'HeaderId');
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
                field(lastModifiedAt; Rec.SystemModifiedAt) { }
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
    var
        DemoHeader: Record DemoHeader;
    begin
        WriteLog('OnNewRecord', Rec.GetFilters());
        Rec.Field4 := 'OnNewRecord';
        DemoHeader.GetBySystemId(Rec.HeaderId);
        Rec.HeaderNumber := DemoHeader.Number;
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
        TempDemoLog.ObjectName := 'DemoLineAPI';
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