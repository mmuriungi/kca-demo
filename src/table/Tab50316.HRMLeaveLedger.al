table 50316 "HRM-Leave Ledger"
{
    DrillDownPageID = "HRM-Leave Ledger View";
    LookupPageID = "HRM-Leave Ledger View";

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            TableRelation = "HRM-Employee C"."No.";
        }
        field(8; "Entry No."; Integer)
        {
        }

        field(9; "Document No"; Code[30])
        {
        }
        field(10; "Leave Type"; Code[20])
        {
            TableRelation = "HRM-Leave Types".Code;
        }
        field(11; "Transaction Date"; Date)
        {
        }
        field(12; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Allocation,Application,Positive Adjustment,Negative Adjustment';
            OptionMembers = " ",Allocation,Application,"Positive Adjustment","Negative Adjustment";
        }
        field(13; "No. of Days"; Decimal)
        {

        }
        field(2; "Remaining days"; Decimal)
        {
            TableRelation = "HRM-Leave Requisition"."Leave Balance";

        }
        field(14; "Transaction Description"; Text[250])
        {
        }
        field(15; "Leave Period"; Integer)
        {
        }
        field(16; "Entry Type"; Option)
        {
            OptionCaption = 'Application,Allocation';
            OptionMembers = Application,Allocation;
        }
        field(17; "Created By"; Code[30])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(18; "Reversed By"; Code[30])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(19; "First Name"; Text[150])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HRM-Employee C"."First Name" where("No." = field("Employee No")));
        }
        field(20; "Middle Name"; Text[150])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HRM-Employee C"."Middle Name" where("No." = field("Employee No")));
        }
        field(22; "Last Name"; Text[150])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("HRM-Employee C"."Last Name" where("No." = field("Employee No")));
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Document No")
        {
        }
        key(Key2; "Employee No", "Leave Type")
        {
            SumIndexFields = "No. of Days";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
    end;
}

