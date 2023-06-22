page 60203 GlobalVarsAPI
{
    PageType = API;
    APIPublisher = 'cronus';
    APIGroup = 'demo';
    APIVersion = 'v1.0';
    EntitySetName = 'globalvars';
    EntityName = 'globalvar';
    DelayedInsert = true;
    SourceTable = Customer;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(record)
            {
                field(id; Rec.SystemId)
                {
                    trigger OnValidate()
                    begin
                        // Rec.GetBySystemId(Rec.SystemId);
                    end;
                }
                field(number; Rec."No.")
                {
                    trigger OnValidate()
                    begin
                        Rec.Get(Rec."No.");
                    end;
                }
                field(name; CustName)
                {
                    trigger OnValidate()
                    begin
                        if Rec."No." = '' then
                            Rec.Insert(true);
                        Rec.Name := CustName;
                        WriteLog('OnValidate', 'CustName');
                        SaveLog();
                    end;
                }
            }
        }
    }

    var
        CustName: Text;
        TempDemoLog: Record LogAPITrigger temporary;
        NextEntryNo: Integer;


    trigger OnInit()
    begin
        WriteLog('OnInit', Rec.GetFilters());
    end;

    trigger OnOpenPage()
    begin
        Rec.AddLoadFields(Name);
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
        CustName := Rec.Name;
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
        TempDemoLog.ObjectName := 'GlobalVarsAPI';
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