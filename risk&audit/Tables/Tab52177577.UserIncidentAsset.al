table 50130 "User Incident Asset"
{
    Caption = 'User Incident Asset';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Incident Ref"; Code[20])
        {
            Caption = 'Incident Ref';
            DataClassification = ToBeClassified;
        }
        field(2; "Tag Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset";
            trigger OnValidate()
            var
                FA: Record "Fixed Asset";
            begin
                FA.Reset();
                FA.SetRange("No.", "Tag Number");
                if FA.FindFirst() then begin
                    Model := FA.Model;
                    "Item Description" := FA.Description;
                    "Serial Number" := FA."Serial No.";
                    Manufacturer := FA.Manufacturer;
                end;
            end;
        }
        field(3; Manufacturer; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Model; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Item Description"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Serial Number"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Date of Return"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Date of Receipt"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Open,Pending,Taken,Returned;
        }

    }
    keys
    {
        key(PK; "Incident Ref", "Tag Number")
        {
            Clustered = true;
        }
    }

}
