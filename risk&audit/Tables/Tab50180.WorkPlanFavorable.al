table 51348 "WorkPlan Favorable"
{
    Caption = 'WorkPlan Favorable';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
            TableRelation = "Audit Header"."No." where(Type = const("Audit WorkPlan"));
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Favorable Condition"; Text[2048])
        {
            Caption = 'Favorable Condition';
            DataClassification = ToBeClassified;
        }
        field(4; "Done By"; Text[50])
        {
            Caption = 'Done By';
            DataClassification = ToBeClassified;
        }
        field(5; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(6; "Impact"; Option)
        {
            Caption = 'Impact';
            OptionMembers = " ",Low,Medium,High;
            OptionCaption = ' ,Low,Medium,High';
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

    trigger OnInsert()
    begin
        if "Line No." = 0 then
            "Line No." := GetNextLineNo();
    end;

    local procedure GetNextLineNo(): Integer
    var
        WorkPlanFav: Record "WorkPlan Favorable";
    begin
        WorkPlanFav.Reset();
        WorkPlanFav.SetRange("Document No.", "Document No.");
        if WorkPlanFav.FindLast() then
            exit(WorkPlanFav."Line No." + 10000)
        else
            exit(10000);
    end;
}
