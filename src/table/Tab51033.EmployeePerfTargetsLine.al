table 51033 "Employee Perf Targets Line"
{
    Caption = 'Employee Perfomance Target Li';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(3; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                PCSubCategoriesSetup: Record "PC SubCategories Setup";
                PCWorkPlanSubCategories: Record "PC WorkPlan Sub Categories";
                LineNo: Integer;
            begin
                if Select then begin
                    PCWorkPlanSubCategories.Init();
                    repeat
                        if PCWorkPlanSubCategories.FindLast() then
                            LineNo := PCWorkPlanSubCategories."Line No." + 10000
                        else
                            LineNo := 10000;
                        PCSubCategoriesSetup.SetRange("Category Code", Rec."S/No.");
                        PCWorkPlanSubCategories.Reset();
                        PCWorkPlanSubCategories."Line No." := LineNo;
                        PCWorkPlanSubCategories."Document No." := Rec."Document No.";
                        PCWorkPlanSubCategories."Category Code" := PCSubCategoriesSetup."Category Code";
                        PCWorkPlanSubCategories."Category Description" := PCSubCategoriesSetup."Category Description";
                        PCWorkPlanSubCategories.Code := PCSubCategoriesSetup."Category Code";
                        PCWorkPlanSubCategories.Description := PCSubCategoriesSetup.Description;
                        PCWorkPlanSubCategories.Insert();
                    until PCSubCategoriesSetup.Next() = 0;
                end else begin
                    PCWorkPlanSubCategories.Reset();
                    PCWorkPlanSubCategories.SetRange("Document No.", "Document No.");
                    PCWorkPlanSubCategories.DeleteAll();
                end;
                PCWorkPlanSubCategories.SetRange(code, '');
                PCSubCategoriesSetup.DeleteAll();

            end;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            // Editable = false;
        }
        field(5; "WorkPlan Name"; Text[250])
        {
            Caption = 'WorkPlan Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "S/No."; Code[20])
        {
            Caption = 'S/No.';
            DataClassification = ToBeClassified;
            TableRelation = "PC WorkPlans Setup";
            Editable = false;
        }
        field(4; "Performance Criteria"; Text[250])
        {           
            Caption = 'Performance Criteria';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Unit of Measure"; Code[50])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Weight (%)"; Integer)
        {
            //Editable = false;
            Caption = 'Weight (%)';
            DataClassification = ToBeClassified;
        }
        field(9; "Status Previous Year"; Code[20])
        {
            Editable = false;
            Caption = 'Status Previous Year';
            DataClassification = ToBeClassified;
        }
        field(10; Target; Code[20])
        {
            Editable = false;
            Caption = 'Target (FY 2021/22)';
            DataClassification = ToBeClassified;
        }
        field(11; Category; Code[250])
        {
            Editable = false;
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
        field(7; "Your Target"; decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var

            begin
                if "Your Target" > "Weight (%)" then
                    Error('Your target is greater than the weight');

            end;
        }
        field(13; "Actual Achievement B"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Target for Quarter C"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Variance B-C"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Actual Achievement E"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Variance G"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
