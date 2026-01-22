table 51203 "REG-File Movement"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;

        }
        field(4; "File Index"; Code[50])
        {
            TableRelation = "REG-Files"."File Index" where(Status = const(Open), "File Index" = filter(<> 'YET TO UPDATE'));
            trigger OnValidate()
            var
                RF: Record "REG-Files";
            begin
                RF.SetRange("File Index", "File Index");
                if RF.Find('-') then begin
                    "Cabinet Number" := RF."Section Number";
                    "Cabinet Name" := RF."Section Name";
                end;
            end;
        }
        field(2; "Cabinet Number"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Cabinet Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Folio Number"; Text[30])
        {
            //TableRelation = "REG-Files"."File No." where("File Index" = field("File Index"));
            TableRelation = "REG-Doc Attachment"."Folio Number" where("No." = field("File Index"));
        }
        field(5; "Send To"; Text[100])
        {
            TableRelation = "HRM-Employee C"."No.";
            trigger OnValidate()
            var
                Employee: Record "HRM-Employee C";
            begin
                Employee.SetRange("No.", "Send To");
                if Employee.Find('-') then
                    "Receiver Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(15; "Receiver Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Date Sent"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Sent Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Issued Out"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Bring Up Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Return Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Return Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Folio Returned"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "File Returned"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Comment"; Text[1020])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "File No."; code[100])
        {

        }
        field(18; "Folio No."; integer)
        {

        }


    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

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