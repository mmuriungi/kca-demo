table 54287 "Required Item/Asset"
{
    Caption = 'Required Item/Asset';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(Item)) Item else
            if (Type = const(Asset)) "Fixed Asset";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Type = Type::Item then begin
                    ItemRec.Reset;
                    if ItemRec.Get("No.") then begin
                        Description := ItemRec.Description;
                    end else
                        if Type = Type::Asset then begin
                            FixedAsset.Reset;
                            if FixedAsset.Get("No.") then begin
                                Description := FixedAsset.Description;
                            end;
                        end;
                end;
            end;
        }
        field(2; Description; Text[260])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(3; Quantity; Integer)
        {
            Caption = 'Quantity';
        }
        field(4; "Request Date"; Date)
        {
            Caption = 'Request Date';
        }
        field(5; "Required Date"; Date)
        {
            Caption = 'Required Date';
            Editable = false;
        }
        field(6; "Required by"; Code[20])
        {
            Caption = 'Required by';
            Editable = false;
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Pending,Provided,"Never Provided",Faulty;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if (Status = Status::Provided) then
                    "Date Provided" := Today
            end;
        }
        field(8; "Date Provided"; Date)
        {
            Caption = 'Date Provided';
            trigger OnValidate()
            var
                InvalidDate: Label 'Sorry Date provided cannot be before %1';
            begin
                if "Date Provided" < "Request Date" then
                    Error(InvalidDate, "Date Provided");
            end;
        }
        field(9; "Maintenance Officer"; Code[20])
        {
            Caption = 'Maintenance Officer';
        }
        field(10; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Item,Asset;
        }
    }
    keys
    {
        key(PK; "No.", "Maintenance Officer")
        {
            Clustered = true;
        }
    }
    var
        FixedAsset: Record "Fixed Asset";
        ItemRec: Record Item;

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        "Required by" := UserId;
        "Request Date" := Today;
    end;
}
