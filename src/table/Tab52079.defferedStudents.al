table 52079 defferedStudents
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; studentNo; Code[20])
        {
            TableRelation = Customer where("Customer Posting Group" = const('Student'));
            trigger OnValidate()
            begin
                if cust.get(Rec.studentNo) then begin
                    Rec.studentName := cust.Name;
                    cust.CalcFields(Programme);
                    Rec.programme := cust.Programme;
                    Rec."E-mail" := cust."E-Mail";
                    Rec."Mobile No" := cust."Mobile Phone No.";
                end;
            end;

        }
        field(2; studentName; Text[200])
        {

        }
        field(3; programme; code[20])
        {
            TableRelation = "ACA-Programme";
            trigger OnValidate()
            begin
                progs.Reset();
                progs.SetRange(Code, Rec.programme);
                if progs.Find('-') then begin
                    Rec.Department := progs."Department Code";
                    Rec."School Code" := progs.Faculty;
                end;
            end;
        }
        field(4; stage; code[20])
        {
            Caption = 'Year';
            TableRelation = "ACA-Programme Stages" where("Programme Code" = field(programme));
        }
        field(5; status; Option)
        {
            OptionMembers = Open,Pending,Approved,Cancelled,Posted;
        }
        field(7; deffermentReason; Text[300])
        {

        }
        field(8; Semeter; Code[20])
        {
            TableRelation = "ACA-Semesters";
            trigger OnValidate()
            begin
                creg.Reset();
                creg.SetRange(Semester, Rec.Semeter);
                if creg.Find('-') then begin
                    Rec.stage := creg.Stage;
                end;
            end;
        }
        field(9; "Mobile No"; Text[15])
        {

        }
        field(10; Department; code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(11; "School Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('FACULTY'));
        }
        field(12; "Request Type"; Option)
        {
            OptionMembers = " ","Call Off",Deferment;
        }
        field(13; "Reason for Calling off"; Option)
        {
            OptionMembers = "Financial Constraints",Medical,Personal;
        }
        field(14; "Recommendation COD"; text[200])
        {

        }
        field(15; "Recommendation Dean"; text[200])
        {

        }
        field(16; "E-mail"; Text[50])
        {

        }


    }

    keys
    {
        key(Key1; studentNo)
        {
            Clustered = true;
        }
    }

    var
        cust: Record Customer;
        creg: Record "ACA-Course Registration";
        progs: Record "ACA-Programme";

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}