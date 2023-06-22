codeunit 60202 Install
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        CreateNumberSequence();
    end;

    local procedure CreateNumberSequence()
    begin
        if not NumberSequence.Exists('DemoHeader', true) then
            NumberSequence.Insert('DemoHeader', 0, 1, true);
    end;
}