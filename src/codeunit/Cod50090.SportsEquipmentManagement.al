// Codeunit: Sports Equipment Management
codeunit 50090 "Sports Equipment Management"
{
    procedure IssueEquipment(ItemNo: Code[20]; UserID: Code[50]; UserType: Option Student,Staff)
    var
        Item: Record Item;
        EquipmentIssuance: Record "Equipment Issuance";
    begin
        Item.Get(ItemNo);
        Item.CalcFields("Item Category");
        Item.TestField("Item Category", item."Item Category"::"Sporting Equipment");

        EquipmentIssuance.Init();
        EquipmentIssuance."Item No." := ItemNo;
        EquipmentIssuance."User ID" := UserID;
        EquipmentIssuance."User Type" := UserType;
        EquipmentIssuance."Issue Date" := Today;
        EquipmentIssuance.Status := EquipmentIssuance.Status::Issued;
        EquipmentIssuance.Insert(true);

        Item.Validate(Inventory, Item.Inventory - 1);
        Item.Modify();
    end;

    procedure ReturnEquipment(EntryNo: Integer)
    var
        EquipmentIssuance: Record "Equipment Issuance";
        Item: Record Item;
    begin
        EquipmentIssuance.Get(EntryNo);
        EquipmentIssuance.TestField(Status, EquipmentIssuance.Status::Issued);

        EquipmentIssuance."Return Date" := Today;
        EquipmentIssuance.Status := EquipmentIssuance.Status::Returned;
        EquipmentIssuance.Modify();

        Item.Get(EquipmentIssuance."Item No.");
        Item.Validate(Inventory, Item.Inventory + 1);
        Item.Modify();
    end;

    procedure ReportLostEquipment(EntryNo: Integer)
    var
        EquipmentIssuance: Record "Equipment Issuance";
    begin
        EquipmentIssuance.Get(EntryNo);
        EquipmentIssuance.TestField(Status, EquipmentIssuance.Status::Issued);

        EquipmentIssuance.Status := EquipmentIssuance.Status::Lost;
        EquipmentIssuance.Modify();
    end;
}
