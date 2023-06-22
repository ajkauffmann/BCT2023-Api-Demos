page 60210 ItemAPIBoundAction
{
    PageType = API;
    Caption = 'Items';
    SourceTable = Item;
    DelayedInsert = true;
    APIPublisher = 'cronus';
    APIGroup = 'demo';
    APIVersion = 'v1.0';
    EntitySetName = 'demo4Items';
    EntityName = 'demo4Item';
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            field(id; Rec.SystemId) { ApplicationArea = All; }
            field(number; Rec."No.") { ApplicationArea = All; }
            field(description; Rec.Description) { }
            field(inventory; Rec.Inventory) { ApplicationArea = All; }
        }
    }


    [ServiceEnabled]
    procedure setDescription(value: Text)
    begin
        Rec.Description := value;
        Rec.Modify();
    end;

    [ServiceEnabled]
    procedure copyItem(var actionContext: WebServiceActionContext)
    var
        Item: Record Item;
    begin
        Item := Rec;
        Item."No." := '';
        Item.Insert(true);

        actionContext.SetObjectType(ObjectType::Page);
        actionContext.SetObjectId(Page::ItemAPIBoundAction);
        actionContext.AddEntityKey(Rec.FieldNo(SystemId), Item.SystemId);
        actionContext.SetResultCode(WebServiceActionResultCode::Created);
    end;

    [ServiceEnabled]
    procedure getPrice(customerNumber: Code[20]; quantity: Decimal) Price: Decimal
    var
        SalesHeader: Record "Sales Header" temporary;
        SalesLine: Record "Sales Line" temporary;
    begin
        SalesHeader."No." := 'API';
        SalesHeader."Sell-to Customer No." := customerNumber;
        SalesHeader."Bill-to Customer No." := customerNumber;
        SalesLine.SetSalesHeader(SalesHeader);

        SalesLine."Document No." := 'API';
        SalesLine."Sell-to Customer No." := customerNumber;
        SalesLine."Bill-to Customer No." := customerNumber;
        SalesLine.Validate(Type, SalesLine.Type::Item);
        SalesLine.Validate("No.", Rec."No.");
        SalesLine.Validate(Quantity, quantity);
        Price := SalesLine."Unit Price";
    end;
}