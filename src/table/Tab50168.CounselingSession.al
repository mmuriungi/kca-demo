table 50168 "Counseling Session"
{
    Caption = 'Counseling Session';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Counseling Session List";
    LookupPageId = "Counseling Session List";


    fields
    {
        field(1; "Session No."; Code[20])
        {
            Caption = 'Session No.';
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = Customer where("Customer Type" = CONST(Student));
        }
        field(3; "Counselor No."; Code[20])
        {
            Caption = 'Counselor No.';
            TableRelation = "HRM-Employee C"."No." where("Employee Type" = filter('Counselor'));
            trigger OnValidate()
            var
                Emp: Record "HRM-Employee C";
            begin
                emp.GET("Counselor No.");
                Rec."Counsellor Name" := Emp.FullName();
            end;
        }
        field(4; "Session Date"; Date)
        {
            Caption = 'Session Date';
        }
        field(5; "Issue Description"; Text[250])
        {
            Caption = 'Issue Description';
        }
        field(6; Recommendations; Text[250])
        {
            Caption = 'Recommendations';
        }
        field(7; "Follow-up Required"; Boolean)
        {
            Caption = 'Follow-up Required';
        }
        //"No. Series"
        field(8; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        //Counsellor Name
        field(9; "Counsellor Name"; Text[250])
        {
            Caption = 'Counsellor Name';
        }
    }

    keys
    {
        key(PK; "Session No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        clubsetup.Get();
        ClubSetup.TestField("Counseling Nos");
        NoseriesMgmt.InitSeries(clubsetup."Counseling Nos", xRec."No. Series", 0D, Rec."Session No.", Rec."No. Series");
    end;

    var
        NoseriesMgmt: Codeunit "NoSeriesManagement";
        ClubSetup: Record "Student Welfare Setup";
        Emp: Record "HRM-Employee C";
}
