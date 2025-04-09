table 51349 "WorkPlan Objectives"
{
    Caption = 'WorkPlan Objectives';
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
        field(3; "Objective"; Text[2048])
        {
            Caption = 'Objective';
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
        field(6; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = " ",Planned,InProgress,Completed;
            OptionCaption = ' ,Planned,In Progress,Completed';
            DataClassification = ToBeClassified;
        }
        field(7; "Priority"; Option)
        {
            Caption = 'Priority';
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
        WorkPlanObj: Record "WorkPlan Objectives";
    begin
        WorkPlanObj.Reset();
        WorkPlanObj.SetRange("Document No.", "Document No.");
        if WorkPlanObj.FindLast() then
            exit(WorkPlanObj."Line No." + 10000)
        else
            exit(10000);
    end;
}
