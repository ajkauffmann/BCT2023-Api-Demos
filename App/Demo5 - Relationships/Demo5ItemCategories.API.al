page 60206 Demo5ItemCategories
{
    PageType = API;
    Caption = 'Items';
    SourceTable = "Item Category";
    DelayedInsert = true;
    APIPublisher = 'cronus';
    APIGroup = 'demo';
    APIVersion = 'v1.0';
    EntitySetName = 'itemCategories';
    EntityName = 'itemCategory';
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(Items)
            {
                field(systemId; Rec.SystemId) { }
                field(code; Rec.Code) { }
                field(description; Rec.Description) { }
            }
        }
    }
}