table 51285 "HelpDesk Header"
{
    Caption = 'HelpDesk Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Integer)
        {
            Caption = 'Code';
            AutoIncrement = true;
        }
        field(2; "Sender ID"; Text[30])
        {
            Caption = 'Sender ID';
        }
        field(3; Question; Text[250])
        {
            Caption = 'Question';
        }
        field(4; Response; Text[250])
        {
            Caption = 'Response';
            trigger OnValidate()
            begin
                RespondedBy := USERID;
                "Response Date" := CREATEDATETIME(TODAY, TIME);
            end;
        }
        field(5; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = New,Closed,Assigned,Resolved;
        }
        field(6; "Request Date"; Date)
        {
            Caption = 'Request Date';
        }
        field(7; "Response Date"; DateTime)
        {
            Caption = 'Response Date';
        }
        field(8; RespondedBy; Text[30])
        {
            Caption = 'Responded By';
        }
        field(9; Category; Option)
        {
            Caption = 'Category';
            OptionMembers = " ",Technical,Administrative,Financial,Other;
            // Adjust these OptionMembers as needed for your use case
        }
        field(10; Department; Code[30])
        {
            Caption = 'Department';
        }
        field(11; Name; Text[250])
        {
            Caption = 'Name';
        }
        field(12; "Assigned Personel"; Code[20])
        {
            Caption = 'Assigned Personnel';
            TableRelation = Employee."No.";  // Assuming you have an Employee table
        }
        field(13; "Assigned Personel Name"; Text[150])
        {

        }
        field(14; "Expected Resolution Time"; Time)
        {
            Caption = 'Expected Resolution Time';
        }
        field(15; "Expected Resolution Date"; Date)
        {
            Caption = 'Expected Resolution Date';
        }
        field(17; "Assigned User ID"; Code[20])
        {
            Caption = 'Assigned User ID';
            TableRelation = "User Setup"."User ID";
            trigger OnValidate()
            begin
                "Assigned Personel Name" := '';
                "Assigned Personel" := '';
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", "Assigned User ID");
                IF UserSetup.FIND('-') THEN BEGIN
                    "Assigned Personel" := UserSetup."Staff No";
                    IF UserSetup."Staff No" <> '' THEN BEGIN
                        HRMEmployeeC.RESET;
                        HRMEmployeeC.SETRANGE("No.", UserSetup."Staff No");
                        IF HRMEmployeeC.FIND('-') THEN BEGIN
                            "Assigned Personel Name" := HRMEmployeeC."First Name" + ' ' + HRMEmployeeC."Middle Name" + ' ' + HRMEmployeeC."Last Name";
                        END;
                    END;
                END;

            end;
        }
        field(18; Comments; Text[250])
        {
            Caption = 'Comments';
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    var
        UserSetup: Record "User Setup";
        HRMEmployeeC: Record "HRM-Employee C";
}
