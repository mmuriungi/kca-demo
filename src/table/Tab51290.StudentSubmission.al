table 51290 "Student Submission"
{
    Caption = 'Student Submission';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; code[20])
        {
            Caption = 'No.';
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = customer where("Customer Type" = CONST(Student));
            trigger OnValidate()
            var
                customer: Record Customer;
            begin
                customer.GET("No.");
                rec."Student Name" := customer.Name;
            end;
        }
        field(3; "Submission Type"; Option)
        {
            Caption = 'Submission Type';
            OptionMembers = "Concept Paper","Thesis";
        }
        field(4; "Submission Date"; Date)
        {
            Caption = 'Submission Date';
        }
        field(5; "Document Link"; Text[250])
        {
            Caption = 'Document Link';
        }
        field(6; Status; enum "Custom Approval Status")
        {
            Caption = 'Status';
        }
        field(7; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(8; "Student Name"; Code[20])
        {
            Caption = 'Student Name';
        }
    }
    keys
    {
        key(PK; "No.", "Student No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        Setup.GET;
        setup.TestField("Submission Nos");
        NoSeries.InitSeries(setup."Submission Nos", xRec."No. Series", 0D, Rec."No.", xRec."No. Series");
    end;

    var
        NoSeries: Codeunit NoSeriesManagement;
        Setup: Record "PostGraduate Setup";
}
