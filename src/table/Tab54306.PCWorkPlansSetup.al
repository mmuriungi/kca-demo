table 54306 "PC WorkPlans Setup"
{
    Caption = 'WorkPlans Setup List';
    DataClassification = ToBeClassified;
    LookupPageId = "PC Work Plan Setup";
    DrillDownPageId = "PC Work Plan Setup";

    fields
    {
        field(1; "S/No."; Code[20])
        {
            Caption = 'S/No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Performance Criteria"; Text[250])
        {
            Caption = 'Performance Criteria';
            DataClassification = ToBeClassified;
        }
        field(3; "Unit of Measure"; Code[50])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
        }
        field(4; "Weight (%)"; Decimal)
        {
            Caption = 'Weight (%)';
            DataClassification = ToBeClassified;
        }
        field(5; "Status Previous Year"; Code[20])
        {
            Caption = 'Status Previous Year';
            DataClassification = ToBeClassified;
        }
        field(6; "Target"; Code[20])
        {
            Caption = 'Target';
            DataClassification = ToBeClassified;
        }
        field(7; Category; Code[20])
        {
            Caption = 'Category';
            TableRelation = "PC Category Table";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                PCCategoryTable: Record "PC Category Table";
            begin
                if PCCategoryTable.Get(Category) then begin
                    "Category Description" := PCCategoryTable.Description
                end;
            end;
        }
        field(8; "Category Description"; Text[250])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "S/No.")
        {
            Clustered = true;
        }
    }
}
