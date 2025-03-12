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
            trigger OnValidate()
            begin
                AffairsMgmt.calculateLeaveEndDate(Rec);
            end;
        }
        field(5; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(6; Reason; Text[250])
        {
            Caption = 'Reason';
        }
        field(7; "Approval Status"; enum "Custom Approval Status")
        {
            Caption = 'Approval Status';
            Editable = false;
            trigger onvalidate()
            begin
                if "Approval Status" = "Approval Status"::Approved then begin
                    "Approval Date" := Today;
                    "Approved By" := USERID;
                    AffairsMgmt.createStudentLeaveLedger(Rec);
                end;
            end;
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
        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(11; "Student Name"; Text[250])
        {
            Caption = 'Student Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Name" where("No." = field("Student No.")));
        }
        field(12; "No of Days"; Decimal)
        {
            Caption = 'No of Days';
            trigger OnValidate()
            begin
                AffairsMgmt.calculateLeaveEndDate(Rec);
            end;
        }
        field(13; "Return Date"; Date)
        {
            Caption = 'Return Date';
        }
        field(14; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(15; "Posting Type"; Option)
        {
            Caption = 'Posting Type';
            OptionMembers = Leave,Recall;
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
        if "Leave No."='' then begin

        clubsetup.Get();
        ClubSetup.TestField("Leave Nos");
        NoseriesMgmt.InitSeries(clubsetup."Leave Nos", xRec."No. Series", 0D, Rec."Leave No.", Rec."No. Series");
        end;
    end;

    var
        NoseriesMgmt: Codeunit "NoSeriesManagement";
        ClubSetup: Record "Student Welfare Setup";
        AffairsMgmt: Codeunit "Student Affairs Management";
}