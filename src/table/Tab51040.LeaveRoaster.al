table 51040 "Leave Roaster"
{

    fields
    {
        field(1; "Leave Roaster No."; Code[250])
        {
        }
        field(2; "Staff No."; Code[20])
        {
            TableRelation = "HRM-Employee C"."No." WHERE("Employee Category" = FILTER('PERMANENT' | 'PERMANENT'));

            trigger OnValidate()
            var
                employec: Record "HRM-Employee C";
            begin
                StaffLedger.Reset;
                StaffLedger.SetRange(StaffLedger."Staff No.", "Staff No.");
                StaffLedger.SetRange(StaffLedger."Checked Out", false);
                if StaffLedger.Count > 0 then Error('Staff must be checked out first');

                // Pick the details from the Visitor Card
                if employec.Get("Staff No.") then begin
                    "Full Name" := employec."First Name" + ' ' + StaffCard."Middle Name" + ' ' + StaffCard."Last Name";

                    "Phone No." := employec."Cellular Phone Number";
                    Email := employec."Company E-Mail";
                    Category := employec."Employee Category";
                end;
            end;
        }
        field(3; "Full Name"; Text[150])
        {
        }
        field(18; "Leave Balance"; Decimal)
        {
            CalcFormula = Sum("HRM-Leave Ledger"."No. of Days" WHERE("Employee No" = FIELD("Staff No.")));
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(4; "Phone No."; Code[150])
        {
        }
        field(5; Email; Text[150])
        {

            trigger OnValidate()
            var
                atExists: Boolean;
                CountedXters: Integer;
            begin
                Clear(atExists);
                Clear(CountedXters);
                if Email <> '' then begin
                    repeat
                    begin
                        CountedXters := CountedXters + 1;
                        if (CopyStr(Email, CountedXters, 1)) = '@' then atExists := true;
                    end;
                    until ((CountedXters = StrLen(Email)) or atExists);

                    if atExists = false then Error('Provide a valid email address!');
                end;
            end;
        }
        field(6; Company; Text[150])
        {
        }
        field(7; "Office Station/Department"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('DEPARTMENTS'));
        }
        field(8; "Department Name"; Text[150])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Office Station/Department"),
                                                               "Dimension Code" = FILTER('DEPARTMENTS')));
            FieldClass = FlowField;
        }
        field(9; "Signed in by"; Code[50])
        {
        }
        field(10; "Transaction Date"; Date)
        {

            trigger OnValidate()
            begin
                "Payroll Month" := Date2DMY("Transaction Date", 2);
                "Payroll Year" := Date2DMY("Transaction Date", 3);
            end;
        }
        field(11; "Time In"; Time)
        {
        }
        field(12; "Time Out"; Time)
        {
        }
        field(13; "Signed Out By"; Code[50])
        {
        }
        field(14; "Checked Out"; Boolean)
        {
        }
        field(15; Comment; Text[250])
        {

            trigger OnValidate()
            begin
                "Comment By" := UserId;
            end;
        }
        field(16; "Comment By"; Text[100])
        {
        }
        field(17; Category; Code[20])
        {
            TableRelation = "HRM-Staff Categories"."Category Code";
        }
        field(19; "Payroll Month"; Integer)
        {
        }
        field(20; "Payroll Year"; Integer)
        {
        }
        field(21; "No Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "User"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Leave Roaster No.")
        {
        }
        key(Key2; "Staff No.", "Leave Roaster No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit 396;
    begin
        IF "Leave Roaster No." = '' THEN BEGIN
            NoSeriesMgt.InitSeries('LEAVEROAST', xRec."No Series", 0D, "Leave Roaster No.", "No Series");
        END;
        "User" := USERID;
        "Transaction Date" := Today;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenLedgerSet: Record "General Ledger Setup";
        StaffLedger: Record "Casuals Attendance Ledger";
        StaffCard: Record "HRM-Employee C";
}

