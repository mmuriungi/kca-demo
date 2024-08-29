table 50166 "Student Leave"
{
    Caption = 'Student Leave';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Leave No."; Code[20])
        {
            Caption = 'Leave No.';
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = customer where("Customer Type" = CONST(Student));
        }
        field(3; "Leave Type"; Option)
        {
            Caption = 'Leave Type';
            OptionMembers = Regular,Compassionate;
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(5; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(6; Reason; Text[250])
        {
            Caption = 'Reason';
        }
        field(7; "Approval Status"; enum "Common Approval Status")
        {
            Caption = 'Approval Status';
        }
        field(8; "Approved By"; Code[20])
        {
            Caption = 'Approved By';
            TableRelation = Employee;
        }
        field(9; "Approval Date"; Date)
        {
            Caption = 'Approval Date';
        }
        //"No. Series"
        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        //Studnet Name
        field(11; "Student Name"; Text[250])
        {
            Caption = 'Student Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Name" where("No." = field("Student No.")));
        }
    }

    keys
    {
        key(PK; "Leave No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        clubsetup.Get();
        ClubSetup.TestField("Leave Nos");
        NoseriesMgmt.InitSeries(clubsetup."Leave Nos", xRec."No. Series", 0D, Rec."Leave No.", Rec."No. Series");
    end;

    var
        NoseriesMgmt: Codeunit "NoSeriesManagement";
        ClubSetup: Record "Student Welfare Setup";
}