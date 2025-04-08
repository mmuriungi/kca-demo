table 50181 "WorkPlan Recommendation"
{
    Caption = 'WorkPlan Recommendation';
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
        field(3; "Recommendation"; Text[2048])
        {
            Caption = 'Recommendation';
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
        field(6; "Priority"; Option)
        {
            Caption = 'Priority';
            OptionMembers = " ",Low,Medium,High;
            OptionCaption = ' ,Low,Medium,High';
            DataClassification = ToBeClassified;
        }
        field(7; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = " ",Planned,InProgress,Implemented,"Not Implemented";
            OptionCaption = ' ,Planned,In Progress,Implemented,Not Implemented';
            DataClassification = ToBeClassified;
        }
        field(8; "Implementation Date"; Date)
        {
            Caption = 'Implementation Date';
            DataClassification = ToBeClassified;
        }
        field(9; "Department Responsible"; Code[30])
        {
            Caption = 'Department Responsible';
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
        WorkPlanRec: Record "WorkPlan Recommendation";
    begin
        WorkPlanRec.Reset();
        WorkPlanRec.SetRange("Document No.", "Document No.");
        if WorkPlanRec.FindLast() then
            exit(WorkPlanRec."Line No." + 10000)
        else
            exit(10000);
    end;
}
