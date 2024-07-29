page 50173 "Asset Movements Ledgers"
{
    ApplicationArea = All;
    Caption = 'Asset Movements Ledgers';
    PageType = List;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "Asset Movement Ledgers";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document Nos"; Rec."Document Nos") { ApplicationArea = all; }
                field("FA No"; rec."FA No") { ApplicationArea = all; }
                field("Asset description"; Rec."Asset description") { ApplicationArea = all; }
                field("Document Date"; Rec."Document Date") { ApplicationArea = all; }
                field("Current User"; rec."Current User") { ApplicationArea = all; }
                field("Current Location"; Rec."Current Location") { ApplicationArea = all; }
                field("New User"; Rec."New User") { ApplicationArea = all; }
                field("New Location"; Rec."New Location") { ApplicationArea = all; }


            }
        }
    }
}
