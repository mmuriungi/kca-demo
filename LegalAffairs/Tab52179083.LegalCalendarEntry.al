table 52179083 "Legal Calendar Entry"
{
    Caption = 'Legal Calendar Entry';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Event Type"; Option)
        {
            Caption = 'Event Type';
            OptionMembers = " ","Court Date","Filing Deadline","Contract Renewal","Meeting","Review Date","Payment Due","Compliance Deadline","Appeal Deadline","Discovery Deadline","Statute of Limitations";
            OptionCaption = ' ,Court Date,Filing Deadline,Contract Renewal,Meeting,Review Date,Payment Due,Compliance Deadline,Appeal Deadline,Discovery Deadline,Statute of Limitations';
            DataClassification = ToBeClassified;
        }
        field(3; "Event Date"; Date)
        {
            Caption = 'Event Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Event Time"; Time)
        {
            Caption = 'Event Time';
            DataClassification = ToBeClassified;
        }
        field(5; "Event Description"; Text[250])
        {
            Caption = 'Event Description';
            DataClassification = ToBeClassified;
        }
        field(6; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            DataClassification = ToBeClassified;
            TableRelation = "Legal Case"."Case No.";
        }
        field(7; "Contract No."; Code[50])
        {
            Caption = 'Contract No.';
            DataClassification = ToBeClassified;
            TableRelation = "Project Header"."No.";
        }
        field(8; Location; Text[100])
        {
            Caption = 'Location';
            DataClassification = ToBeClassified;
        }
        field(9; "Responsible Person"; Code[20])
        {
            Caption = 'Responsible Person';
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee C"."No.";
        }
        field(10; "Reminder Date"; Date)
        {
            Caption = 'Reminder Date';
            DataClassification = ToBeClassified;
        }
        field(11; "Reminder Sent"; Boolean)
        {
            Caption = 'Reminder Sent';
            DataClassification = ToBeClassified;
        }
        field(12; Priority; Option)
        {
            Caption = 'Priority';
            OptionMembers = " ",Low,Medium,High,Critical;
            OptionCaption = ' ,Low,Medium,High,Critical';
            DataClassification = ToBeClassified;
        }
        field(13; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Scheduled,Completed,Cancelled,Postponed,Overdue;
            OptionCaption = 'Scheduled,Completed,Cancelled,Postponed,Overdue';
            DataClassification = ToBeClassified;
        }
        field(14; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Date Created"; DateTime)
        {
            Caption = 'Date Created';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(17; "All Day Event"; Boolean)
        {
            Caption = 'All Day Event';
            DataClassification = ToBeClassified;
        }
        field(18; "Recurring Event"; Boolean)
        {
            Caption = 'Recurring Event';
            DataClassification = ToBeClassified;
        }
        field(19; "Recurrence Pattern"; Option)
        {
            Caption = 'Recurrence Pattern';
            OptionMembers = " ",Daily,Weekly,Monthly,Yearly;
            OptionCaption = ' ,Daily,Weekly,Monthly,Yearly';
            DataClassification = ToBeClassified;
        }
        field(20; Notes; Text[250])
        {
            Caption = 'Notes';
            DataClassification = ToBeClassified;
        }
        field(21; "Outlook Synced"; Boolean)
        {
            Caption = 'Outlook Synced';
            DataClassification = ToBeClassified;
        }
        field(22; "Google Calendar Synced"; Boolean)
        {
            Caption = 'Google Calendar Synced';
            DataClassification = ToBeClassified;
        }
        field(23; "Compliance Task No."; Code[20])
        {
            Caption = 'Compliance Task No.';
            DataClassification = ToBeClassified;
            TableRelation = "Legal Compliance Task"."Task No.";
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(SK1; "Event Date", "Event Time")
        {
        }
        key(SK2; "Case No.", "Event Type")
        {
        }
        key(SK3; "Contract No.", "Event Type")
        {
        }
        key(SK4; "Responsible Person", "Event Date")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Date Created" := CurrentDateTime;
        
        if "Event Date" <> 0D then
            CalculateReminderDate();
    end;

    trigger OnModify()
    begin
        if "Event Date" <> xRec."Event Date" then
            CalculateReminderDate();
    end;

    local procedure CalculateReminderDate()
    var
        LegalSetup: Record "Legal Affairs Setup";
    begin
        LegalSetup.Get();
        case "Event Type" of
            "Event Type"::"Court Date":
                "Reminder Date" := CalcDate('-' + Format(LegalSetup."Court Date Reminder Days") + 'D', "Event Date");
            "Event Type"::"Filing Deadline", "Event Type"::"Compliance Deadline", "Event Type"::"Appeal Deadline":
                "Reminder Date" := CalcDate('-' + Format(LegalSetup."Deadline Alert Days") + 'D', "Event Date");
            "Event Type"::"Contract Renewal":
                "Reminder Date" := CalcDate('-' + Format(LegalSetup."Contract Expiry Alert Days") + 'D', "Event Date");
            else
                "Reminder Date" := CalcDate('-7D', "Event Date");
        end;
    end;
}