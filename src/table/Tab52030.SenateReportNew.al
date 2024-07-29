table 52030 "Senate Report New"
{
    Caption = 'Senate Report New';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Student No."; Code[20])
        {

        }
        field(2; "Student Name"; Text[200])
        {

        }
        field(3; Average; Decimal)
        {

        }
        field(4; "Acdemic Year"; Code[20])
        {

        }
        field(5; Semester; code[20])
        {
            TableRelation = "ACA-Semesters";
        }
        field(6; Status; code[20])
        {
            //OptionMembers = Pass,Fail;
            trigger OnValidate()
            begin
                Order := GetOrderNo(rec);
                //Modify();
            end;
        }
        field(7; Grade; Code[20])
        {

        }
        field(8; Programme; code[20])
        {
            TableRelation = "ACA-Programme";
        }
        field(9; Stage; code[20])
        {

        }
        field(10; SuppUnits; text[200])
        {

        }
        field(11; "Year of Study"; Decimal)
        {

        }
        field(12; Order; Integer)
        {

        }

    }
    keys
    {
        key(PK; "Student No.", Semester, "Acdemic Year", Stage, Status)
        {
            Clustered = true;
        }
        key(pk2; Order)
        {

        }
    }

    trigger OnInsert()
    begin
        if Status <> '' then
            Order := GetOrderNo(Rec);
    end;

    procedure GetOrderNo(SenateReport: Record "Senate Report New"): Integer

    begin
        case
            SenateReport.Status of
            'PASS':
                exit(1);
            'FAIL':
                exit(2);
            'RETAKE ONE':
                exit(3);
            'ABSCONDED':
                exit(4);
            'SUPPLEMENTARY':
                exit(5);
        end;
    end;
}
