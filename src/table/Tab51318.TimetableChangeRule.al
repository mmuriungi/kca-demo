table 51388 "Timetable Change Rule"
{
    Caption = 'Timetable Change Rule';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Timetable Document No."; Code[20])
        {
            Caption = 'Timetable Document No.';
            TableRelation = "Timetable Header"."Document No.";
        }
        field(3; "Rule Type"; Option)
        {
            Caption = 'Rule Type';
            OptionMembers = "Lecturer Change","Room Change","Time Change","Unit Cancellation","Stream Reassignment";
            OptionCaption = 'Lecturer Change,Room Change,Time Change,Unit Cancellation,Stream Reassignment';
        }
        field(4; "Apply To"; Option)
        {
            Caption = 'Apply To';
            OptionMembers = "Specific Entry","All Matching Criteria";
            OptionCaption = 'Specific Entry,All Matching Criteria';
        }
        field(5; "Active"; Boolean)
        {
            Caption = 'Active';
        }
        field(6; "Description"; Text[100])
        {
            Caption = 'Description';
        }

        // Criteria fields for matching
        field(10; "Filter Programme"; Code[20])
        {
            Caption = 'Filter Programme';
            TableRelation = "ACA-Programme";
        }
        field(11; "Filter Stage"; Code[20])
        {
            Caption = 'Filter Stage';
            TableRelation = "ACA-Programme Stages";
        }
        field(12; "Filter Unit"; Code[20])
        {
            Caption = 'Filter Unit';
        }
        field(13; "Filter Stream"; Code[100])
        {
            Caption = 'Filter Stream';
        }
        field(14; "Filter Lecturer"; Code[20])
        {
            Caption = 'Filter Lecturer';
            TableRelation = "HRM-Employee C";
        }
        field(15; "Filter Room"; Code[20])
        {
            Caption = 'Filter Room';
            TableRelation = "ACA-Lecturer Halls Setup";
        }
        field(16; "Filter Day"; Option)
        {
            Caption = 'Filter Day';
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
            OptionCaption = ' ,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday';
        }
        field(17; "Filter Time Slot"; Code[20])
        {
            Caption = 'Filter Time Slot';
            TableRelation = "Time Slot";
        }
        field(18; "Filter Date From"; Date)
        {
            Caption = 'Filter Date From';
        }
        field(19; "Filter Date To"; Date)
        {
            Caption = 'Filter Date To';
        }

        // Action fields - what to change to
        field(30; "New Lecturer"; Code[20])
        {
            Caption = 'New Lecturer';
            TableRelation = "HRM-Employee C";
        }
        field(31; "New Room"; Code[20])
        {
            Caption = 'New Room';
            TableRelation = "ACA-Lecturer Halls Setup";
        }
        field(32; "New Day"; Option)
        {
            Caption = 'New Day';
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
            OptionCaption = ' ,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday';
        }
        field(33; "New Time Slot"; Code[20])
        {
            Caption = 'New Time Slot';
            TableRelation = "Time Slot";
        }
        field(34; "New Stream"; Code[100])
        {
            Caption = 'New Stream';
        }
        field(35; "Cancel Unit"; Boolean)
        {
            Caption = 'Cancel Unit';
        }

        // Additional options
        field(40; "Change Reason"; Text[250])
        {
            Caption = 'Change Reason';
        }
        field(41; "Priority"; Integer)
        {
            Caption = 'Priority';
            InitValue = 100;
        }
        field(42; "Applied"; Boolean)
        {
            Caption = 'Applied';
            Editable = false;
        }
        field(43; "Applied Date"; Date)
        {
            Caption = 'Applied Date';
            Editable = false;
        }
        field(44; "Applied By"; Code[50])
        {
            Caption = 'Applied By';
            Editable = false;
        }
        field(45; "Entries Affected"; Integer)
        {
            Caption = 'Entries Affected';
            Editable = false;
        }
        field(46; "Preview Mode"; Boolean)
        {
            Caption = 'Preview Mode';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Timetable Document No.", Priority, "Rule Type")
        {
        }
        key(Key3; "Rule Type", Active, Applied)
        {
        }
    }

    trigger OnInsert()
    begin
        // TestField("Timetable Document No.");
        // TestField("Rule Type");
        // TestField("Change Reason");
    end;

    trigger OnModify()
    begin
        if Applied then
            Error('Cannot modify an already applied rule. Please create a new rule.');
    end;

    trigger OnDelete()
    begin
        if Applied then
            Error('Cannot delete an applied rule.');
    end;
}