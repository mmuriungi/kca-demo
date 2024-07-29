table 54301 "Dept Activities"
{
    Caption = 'Dept Activities';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            TableRelation = "PC SubCategories Setup";
            trigger OnValidate()
            var
                PCWorkPlansSetup: Record "PC SubCategories Setup";
            begin
                PCWorkPlansSetup.SetRange(Code, Rec.Code);
                if PCWorkPlansSetup.FindFirst() then begin
                    Description := PCWorkPlansSetup.Description;
                    "Category Code" := PCWorkPlansSetup."Category Code";
                    "Category Description" := PCWorkPlansSetup."Category Description";
                end;
            end;
        }
        field(2; "Description"; Text[250])
        {
            Caption = 'Activities';
        }
        field(3; "Category Code"; Code[20])
        {
        }
        field(8; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(13; "Department Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("DepartMent Work Plan".Department where("No." = field("Document No.")));
        }
        field(19; "Plan Year"; code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("DepartMent Work Plan"."Plan Year" where("No." = field("Document No.")));
        }
        field(20; "WorkPlan Name"; Text[250])
        {
            Caption = 'WorkPlan Name';
            DataClassification = ToBeClassified;
        }
        field(21; "Type"; Code[50])
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
        field(22; "S/No."; Code[20])
        {
            Caption = 'S/No.';
            DataClassification = ToBeClassified;
            TableRelation = "PC WorkPlans Setup";
            trigger OnValidate()
            var
                PCWorkPlansSetup: Record "PC WorkPlans Setup";
            begin
                PCWorkPlansSetup.SetRange("S/No.", Rec."S/No.");
                if PCWorkPlansSetup.FindFirst() then begin
                    "Performance Criteria" := PCWorkPlansSetup."Performance Criteria";
                    "Unit of Measure" := PCWorkPlansSetup."Unit of Measure";
                    "Weight (%)" := PCWorkPlansSetup."Weight (%)";
                    "Status Previous Year" := PCWorkPlansSetup."Status Previous Year";
                    Target := PCWorkPlansSetup.Target;
                    Category := PCWorkPlansSetup."Category Description";
                    "Category Description" := PCWorkPlansSetup."Category Description";
                end;
            end;
        }
        field(23; "Performance Criteria"; Text[250])
        {
            Caption = 'Performance Criteria';
            DataClassification = ToBeClassified;
        }
        field(24; "Unit of Measure"; Code[50])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
        }
        field(25; "Weight (%)"; Integer)
        {
            Caption = 'Weight (%)';
            DataClassification = ToBeClassified;
        }
        field(9; "Status Previous Year"; Code[20])
        {
            Caption = 'Status Previous Year';
            DataClassification = ToBeClassified;
        }
        field(10; Target; Code[20])
        {
            Caption = 'Target (FY 2021/22)';
            DataClassification = ToBeClassified;
        }
        field(11; Category; Code[250])
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
        field(12; "Category Description"; Text[250])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(31; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Code", "Document No.")
        {
            Clustered = true;
        }
    }
}
