page 60205 Demo5Items
{
    PageType = API;
    Caption = 'Items';
    SourceTable = Item;
    DelayedInsert = true;
    APIPublisher = 'cronus';
    APIGroup = 'demo';
    APIVersion = 'v1.0';
    EntitySetName = 'items';
    EntityName = 'item';
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(records)
            {
                field(id; Rec.SystemId) { }
                field(Description; Rec.Description) { }
                field(itemCategoryId; Rec."Item Category Id") { }
                field(itemCategoryCode; Rec."Item Category Code") { }
            }
        }
    }
}