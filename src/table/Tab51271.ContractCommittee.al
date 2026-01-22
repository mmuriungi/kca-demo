table 51271 "Contract Committee"
{
    Caption = 'Contract Committee';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Document No"; Code[50])
        {
            Caption = 'Document No';
            DataClassification = ToBeClassified;
        }
        field(3; Title; Text[30])
        {
            Caption = 'Title';
            DataClassification = ToBeClassified;
        }
        field(4; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(5; Comment; Text[250])
        {
            Caption = 'Comment';
            DataClassification = ToBeClassified;
        }
        field(6; "Acceptance Status"; Option)
        {
            Caption = 'Acceptance Status';
            OptionMembers = " ",Accepted,Rejected;
            OptionCaption = ' ,Accepted,Rejected';
            DataClassification = ToBeClassified;
        }
        field(7; No; code[50])
        {
            Caption = 'Employee No';
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee C"."No.";
            trigger OnValidate()
            var
                TbcomExt: Record "HRM-Employee C";
            begin
                if TbcomExt.Get(No) then begin
                    // TbcomExt.TestField("User ID");
                    Name := TbcomExt.FullName;
                    // Title := TbcomExt.Role;
                end;
            end;
        }
    }
    keys
    {
        key(PK; "Entry No", "Document No")
        {
            Clustered = true;
        }
    }

}
