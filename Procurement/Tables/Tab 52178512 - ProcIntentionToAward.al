table 52178512 "Proc-Intention To Award"
{
    DrillDownPageId = "Proc-Intention To Award";
    Caption = 'Proc-Intention To Award';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
        }
        field(2; "Procurement Method"; Enum "Proc-Procurement Methods")
        {
            Caption = 'Procurement Method';
        }
        field(3; "Bidder No"; Code[50])
        {
            Caption = 'Bidder No';
            TableRelation = "Purchase Header"."No." where("Quote Status" = filter("Recommended Award"), "Request for Quote No." = field("No."));
            trigger OnValidate()
            begin
                Pheader.Reset();
                Pheader.SetRange("No.", "Bidder No");
                if Pheader.Find('-') then begin
                    "Supplier No" := Pheader."Buy-from Vendor No.";
                    "Supplier Name" := Pheader."Buy-from Vendor Name";
                end;
            end;
        }
        field(4; "Supplier No"; Code[50])
        {
            Caption = 'Supplier No';
        }
        field(5; "Supplier Name"; Text[150])
        {
            Caption = 'Supplier Name';
        }
        field(6; "Tender Amount"; Decimal)
        {
            Caption = 'Tender Amount';
        }
        field(7; "Standstill End"; Date)
        {
            Caption = 'Standstill End';
        }
        field(8; "Created By"; Code[50])
        {

        }
        field(9; "Date"; Date)
        {

        }
        field(10; "Name"; Text[200])
        {

        }
        field(11; "Address"; Text[150])
        {

        }
        field(12; "Phone No"; Integer)
        {

        }
        field(13; Email; text[150])
        {

        }
        field(14; "Supplier Email"; Text[100])
        {

        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }

    }
    var


        Pheader: Record "Purchase Header";
}
