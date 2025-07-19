table 52179001 "CRM Segmentation"
{
    DataClassification = CustomerContent;
    Caption = 'CRM Segmentation';
    
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; "Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Segmentation Type"; Enum "CRM Segmentation Type")
        {
            Caption = 'Segmentation Type';
        }
        field(4; "Criteria"; Text[250])
        {
            Caption = 'Criteria';
        }
        field(5; "Active"; Boolean)
        {
            Caption = 'Active';
            InitValue = true;
        }
        field(6; "Target Audience"; Enum "CRM Customer Type")
        {
            Caption = 'Target Audience';
        }
        field(7; "Marketing Priority"; Enum "CRM Priority Level")
        {
            Caption = 'Marketing Priority';
        }
        field(8; "Customer Count"; Integer)
        {
            Caption = 'Customer Count';
            FieldClass = FlowField;
            CalcFormula = count("CRM Customer" where("Segmentation Code" = field(Code)));
            Editable = false;
        }
        field(9; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            Editable = false;
        }
        field(10; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(11; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            Editable = false;
        }
        field(12; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(13; "Notes"; Text[250])
        {
            Caption = 'Notes';
        }
    }
    
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
        key(Type; "Segmentation Type")
        {
        }
        key(Active; "Active")
        {
        }
    }
    
    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
        "Created By" := UserId;
        "Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
    end;
    
    trigger OnModify()
    begin
        "Modified Date" := CurrentDateTime;
        "Modified By" := UserId;
    end;
}