table 50060 "ACA-Supp. Results Status"
{
    Caption = 'ACA-Supp. Results Status';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Students Count"; Integer)
        {
            Caption = 'Students Count';
            DataClassification = CustomerContent;
        }
        field(4; "Programme Filter"; Code[100])
        {
            Caption = 'Programme Filter';
            DataClassification = CustomerContent;
        }
        field(5; "Stage Filter"; Code[100])
        {
            Caption = 'Stage Filter';
            DataClassification = CustomerContent;
        }
        field(6; "Semester Filter"; Code[100])
        {
            Caption = 'Semester Filter';
            DataClassification = CustomerContent;
        }
        field(7; "Status Msg1"; Text[100])
        {
            Caption = 'Status Msg1';
            DataClassification = CustomerContent;
        }
        field(8; "Status Msg2"; Text[150])
        {
            Caption = 'Status Msg2';
            DataClassification = CustomerContent;
        }
        field(9; "Status Msg3"; Text[150])
        {
            Caption = 'Status Msg3';
            DataClassification = CustomerContent;
        }
        field(10; "Status Msg4"; Text[200])
        {
            Caption = 'Status Msg4';
            DataClassification = CustomerContent;
        }
        field(11; "Status Msg5"; Text[200])
        {
            Caption = 'Status Msg5';
            DataClassification = CustomerContent;
        }
        field(12; "Order No"; Integer)
        {
            Caption = 'Order No';
            DataClassification = CustomerContent;
        }
        field(13; "Student Type Filter"; Option)
        {
            Caption = 'Student Type Filter';
            DataClassification = CustomerContent;
            OptionMembers = " ";
        }
        field(14; "Show Reg. Remarks"; Boolean)
        {
            Caption = 'Show Reg. Remarks';
            DataClassification = CustomerContent;
        }
        field(15; "Manual Status Processing"; Boolean)
        {
            Caption = 'Manual Status Processing';
            DataClassification = CustomerContent;
        }
        field(50000; "Semester"; Code[100])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(50001; "Prefix"; Code[20])
        {
            Caption = 'Prefix';
            DataClassification = CustomerContent;
        }
        field(50002; "Session Filter"; Code[20])
        {
            Caption = 'Session Filter';
            DataClassification = CustomerContent;
        }
        field(50003; "Campus Filter"; Code[20])
        {
            Caption = 'Campus Filter';
            DataClassification = CustomerContent;
        }
        field(50004; "Students Count Cumm"; Integer)
        {
            Caption = 'Students Count Cumm';
            DataClassification = CustomerContent;
        }
        field(50005; "Status Msg6"; Text[200])
        {
            Caption = 'Status Msg6';
            DataClassification = CustomerContent;
        }
        field(50006; "IncludeVariable 1"; Boolean)
        {
            Caption = 'IncludeVariable 1';
            DataClassification = CustomerContent;
        }
        field(50007; "IncludeVariable 2"; Boolean)
        {
            Caption = 'IncludeVariable 2';
            DataClassification = CustomerContent;
        }
        field(50008; "IncludeVariable 3"; Boolean)
        {
            Caption = 'IncludeVariable 3';
            DataClassification = CustomerContent;
        }
        field(50009; "IncludeVariable 4"; Boolean)
        {
            Caption = 'IncludeVariable 4';
            DataClassification = CustomerContent;
        }
        field(50010; "IncludeVariable 5"; Boolean)
        {
            Caption = 'IncludeVariable 5';
            DataClassification = CustomerContent;
        }
        field(50011; "IncludeVariable 6"; Boolean)
        {
            Caption = 'IncludeVariable 6';
            DataClassification = CustomerContent;
        }
        field(50012; "Minimum Units Failed"; Decimal)
        {
            Caption = 'Minimum Units Failed';
            DataClassification = CustomerContent;
        }
        field(50013; "Maximum Units Failed"; Decimal)
        {
            Caption = 'Maximum Units Failed';
            DataClassification = CustomerContent;
        }
        field(63020; "Status"; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionMembers = " ";
        }
        field(63021; "Summary Page Caption"; Text[250])
        {
            Caption = 'Summary Page Caption';
            DataClassification = CustomerContent;
        }
        field(63022; "Include Failed Units Headers"; Boolean)
        {
            Caption = 'Include Failed Units Headers';
            DataClassification = CustomerContent;
        }
        field(63023; "Fails Based on"; Option)
        {
            Caption = 'Fails Based on';
            DataClassification = CustomerContent;
            OptionMembers = " ";
        }
        field(63024; "Transcript Remarks"; Code[100])
        {
            Caption = 'Transcript Remarks';
            DataClassification = CustomerContent;
        }
        field(63025; "Final Year Comment"; Text[100])
        {
            Caption = 'Final Year Comment';
            DataClassification = CustomerContent;
        }
        field(63026; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(63027; "Min/Max Based on"; Option)
        {
            Caption = 'Min/Max Based on';
            DataClassification = CustomerContent;
            OptionMembers = " ";
        }
        field(63028; "Include Academic Year Caption"; Boolean)
        {
            Caption = 'Include Academic Year Caption';
            DataClassification = CustomerContent;
        }
        field(63029; "Academic Year Text"; Text[250])
        {
            Caption = 'Academic Year Text';
            DataClassification = CustomerContent;
        }
        field(63030; "Faculty Filter"; Code[20])
        {
            Caption = 'Faculty Filter';
            DataClassification = CustomerContent;
        }
        field(63031; "Year of Study Filter"; Code[20])
        {
            Caption = 'Year of Study Filter';
            DataClassification = CustomerContent;
        }
        field(63032; "Pass"; Boolean)
        {
            Caption = 'Pass';
            DataClassification = CustomerContent;
        }
        field(63033; "Supp. Rubric Caption"; Boolean)
        {
            Caption = 'Supp. Rubric Caption';
            DataClassification = CustomerContent;
        }
        field(63034; "Supp. Rubric Caption 2"; Boolean)
        {
            Caption = 'Supp. Rubric Caption 2';
            DataClassification = CustomerContent;
        }
        field(63035; "Supp. Rubric Caption 3"; Boolean)
        {
            Caption = 'Supp. Rubric Caption 3';
            DataClassification = CustomerContent;
        }
        field(63036; "Supp. Rubric Caption 4"; Boolean)
        {
            Caption = 'Supp. Rubric Caption 4';
            DataClassification = CustomerContent;
        }
        field(63037; "Supp. Rubric Caption 5"; Boolean)
        {
            Caption = 'Supp. Rubric Caption 5';
            DataClassification = CustomerContent;
        }
        field(63038; "Supp. Rubric Caption 6"; Boolean)
        {
            Caption = 'Supp. Rubric Caption 6';
            DataClassification = CustomerContent;
        }
        field(63039; "Special Programme Class"; Option)
        {
            Caption = 'Special Programme Class';
            DataClassification = CustomerContent;
            OptionMembers = " ";
        }
        field(63040; "Special Programme Scope"; Option)
        {
            Caption = 'Special Programme Scope';
            DataClassification = CustomerContent;
            OptionMembers = " ";
        }
        field(63041; "Include no. of Repeats"; Boolean)
        {
            Caption = 'Include no. of Repeats';
            DataClassification = CustomerContent;
        }
        field(63042; "Min. Unit Repeat Counts"; Decimal)
        {
            Caption = 'Min. Unit Repeat Counts';
            DataClassification = CustomerContent;
        }
        field(63043; "Max. Unit Repeat Counts"; Decimal)
        {
            Caption = 'Max. Unit Repeat Counts';
            DataClassification = CustomerContent;
        }
        field(63044; "Maximum Academic Repeat"; Decimal)
        {
            Caption = 'Maximum Academic Repeat';
            DataClassification = CustomerContent;
        }
        field(63045; "Lead Status"; Code[20])
        {
            Caption = 'Lead Status';
            DataClassification = CustomerContent;
        }
        field(63046; "Minimum Academic Repeats"; Decimal)
        {
            Caption = 'Minimum Academic Repeats';
            DataClassification = CustomerContent;
        }
        field(63047; "Minimum Core Fails"; Decimal)
        {
            Caption = 'Minimum Core Fails';
            DataClassification = CustomerContent;
        }
        field(63048; "Maximum Core Fails"; Decimal)
        {
            Caption = 'Maximum Core Fails';
            DataClassification = CustomerContent;
        }
        field(63049; "Minimum None-Core Fails"; Decimal)
        {
            Caption = 'Minimum None-Core Fails';
            DataClassification = CustomerContent;
        }
        field(63050; "Maximum None-Core Fails"; Decimal)
        {
            Caption = 'Maximum None-Core Fails';
            DataClassification = CustomerContent;
        }
        field(63051; "1st Year Grad. Comments"; Text[50])
        {
            Caption = '1st Year Grad. Comments';
            DataClassification = CustomerContent;
        }
        field(63052; "2nd Year Grad. Comments"; Text[50])
        {
            Caption = '2nd Year Grad. Comments';
            DataClassification = CustomerContent;
        }
        field(63053; "3rd Year Grad. Comments"; Text[50])
        {
            Caption = '3rd Year Grad. Comments';
            DataClassification = CustomerContent;
        }
        field(63054; "4th Year Grad. Comments"; Text[50])
        {
            Caption = '4th Year Grad. Comments';
            DataClassification = CustomerContent;
        }
        field(63055; "5th Year Grad. Comments"; Text[50])
        {
            Caption = '5th Year Grad. Comments';
            DataClassification = CustomerContent;
        }
        field(63056; "6th Year Grad. Comments"; Text[50])
        {
            Caption = '6th Year Grad. Comments';
            DataClassification = CustomerContent;
        }
        field(63057; "7th Year Grad. Comments"; Text[50])
        {
            Caption = '7th Year Grad. Comments';
            DataClassification = CustomerContent;
        }
        field(63058; "Finalists Grad. Comm. Degree"; Text[50])
        {
            Caption = 'Finalists Grad. Comm. Degree';
            DataClassification = CustomerContent;
        }
        field(63059; "Grad. Status Msg 1"; Text[50])
        {
            Caption = 'Grad. Status Msg 1';
            DataClassification = CustomerContent;
        }
        field(63060; "Grad. Status Msg 2"; Text[50])
        {
            Caption = 'Grad. Status Msg 2';
            DataClassification = CustomerContent;
        }
        field(63061; "Grad. Status Msg 3"; Text[50])
        {
            Caption = 'Grad. Status Msg 3';
            DataClassification = CustomerContent;
        }
        field(63062; "Grad. Status Msg 4"; Text[50])
        {
            Caption = 'Grad. Status Msg 4';
            DataClassification = CustomerContent;
        }
        field(63063; "Grad. Status Msg 5"; Text[50])
        {
            Caption = 'Grad. Status Msg 5';
            DataClassification = CustomerContent;
        }
        field(63064; "Grad. Status Msg 6"; Text[50])
        {
            Caption = 'Grad. Status Msg 6';
            DataClassification = CustomerContent;
        }
        field(63065; "Finalists Grad. Comm. Dip"; Text[50])
        {
            Caption = 'Finalists Grad. Comm. Dip';
            DataClassification = CustomerContent;
        }
        field(63066; "Finalists Grad. Comm. Cert."; Text[50])
        {
            Caption = 'Finalists Grad. Comm. Cert.';
            DataClassification = CustomerContent;
        }
        field(63067; "Supp. Status Msg1"; Text[100])
        {
            Caption = 'Supp. Status Msg1';
            DataClassification = CustomerContent;
        }
        field(63068; "Supp. Status Msg2"; Text[150])
        {
            Caption = 'Supp. Status Msg2';
            DataClassification = CustomerContent;
        }
        field(63069; "Supp. Status Msg3"; Text[100])
        {
            Caption = 'Supp. Status Msg3';
            DataClassification = CustomerContent;
        }
        field(63070; "Supp. Status Msg4"; Text[200])
        {
            Caption = 'Supp. Status Msg4';
            DataClassification = CustomerContent;
        }
        field(63071; "Supp. Status Msg5"; Text[200])
        {
            Caption = 'Supp. Status Msg5';
            DataClassification = CustomerContent;
        }
        field(63072; "Include CF% Fail"; Boolean)
        {
            Caption = 'Include CF% Fail';
            DataClassification = CustomerContent;
        }
        field(63073; "Supp. Status Msg6"; Text[200])
        {
            Caption = 'Supp. Status Msg6';
            DataClassification = CustomerContent;
        }
        field(63074; "Skip Supp Generation"; Boolean)
        {
            Caption = 'Skip Supp Generation';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
} 