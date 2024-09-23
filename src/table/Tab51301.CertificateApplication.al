table 51301 "Certificate Application"
{
    Caption = 'Certificate Application';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; code[25])
        {
            Caption = 'No.';
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = Customer where("Customer Type" = const(Student));
            trigger OnValidate()
            var
                Student: Record Customer;
            begin
                student.reset;
                Student.SetRange("No.", "Student No.");
                if Student.FindFirst then begin
                    "Student Name" := Student.Name;
                end;
                //check if student has any pending applications
                CertMgmt.CheckApplicantQualification(Rec);
            end;


        }
        field(3; "Application Type"; Option)
        {
            Caption = 'Application Type';
            OptionMembers = "New Certificate","Copy of Certificate","Reissue Transcript","Special Examination";
        }
        field(4; "Application Date"; Date)
        {
            Caption = 'Application Date';
        }
        field(5; Status; enum "Custom Approval Status")
        {
            Caption = 'Status';
        }
        field(6; "Clearance Status"; Boolean)
        {
            Caption = 'Clearance Status';
        }
        field(7; "Gown Returned"; Boolean)
        {
            Caption = 'Gown Returned';
        }
        field(8; "National ID Provided"; Boolean)
        {
            Caption = 'National ID Provided';
        }
        field(9; "Police Abstract Provided"; Boolean)
        {
            Caption = 'Police Abstract Provided';
        }
        field(10; "Fee Paid"; Boolean)
        {
            Caption = 'Fee Paid';
        }
        field(11; "Special Exam Reason"; Text[250])
        {
            Caption = 'Special Exam Reason';
        }
        field(12; "Student Name"; Code[20])
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

    end;

    var
        CertMgmt: Codeunit "Student Certificate Management";
}
