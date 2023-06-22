page 60207 DemoItemsAPI
{
    APIGroup = 'data';
    APIPublisher = 'cronus';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'demoItemsAPI';
    DelayedInsert = true;
    EntityName = 'demoItem';
    EntitySetName = 'demoItems';
    PageType = API;
    SourceTable = Item;
    ODataKeyFields = SystemId;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(number; Rec."No.")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(inventory; Rec.Inventory)
                {
                }
                field(id; Rec.SystemId)
                {
                }
                field(lastModifiedDateTime; Rec.SystemModifiedAt)
                {
                }
            }
        }
    }
}
