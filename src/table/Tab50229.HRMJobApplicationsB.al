table 50229 "HRM-Job Applications (B)"
{
    Caption = 'HR Job Applications';
    fields
    {
        field(1; "Application No"; Code[10])
        {
            Caption = 'Application No';
        }
        field(2; "First Name"; Text[100])
        {
            Caption = 'First Name';
        }
        field(3; "Middle Name"; Text[50])
        {
            Caption = 'Middle Name';
        }
        field(4; "Last Name"; Text[50])
        {
            Caption = 'Last Name';

            trigger OnValidate()
            var
                Reason: Text[30];
            begin
            end;
        }
        field(5; Initials; Text[15])
        {
            Caption = 'Initials';
        }
        field(6; "P.W.D"; Text[250])
        {
        }
        field(7; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
        }
        field(8; "Postal Address"; Text[80])
        {
            Caption = 'Postal Address';
        }
        field(9; "Residential Address"; Text[80])
        {
            Caption = 'Residential Address';
        }
        field(10; City; Text[30])
        {
            Caption = 'City';
        }
        field(11; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            ValidateTableRelation = false;
        }
        field(12; County; Text[30])
        {
            Caption = 'County';
        }
        field(13; "Home Phone Number"; Text[30])
        {
            Caption = 'Home Phone Number';
        }
        field(14; "Cell Phone Number"; Text[30])
        {
            Caption = 'Cell Phone Number';
        }
        field(15; "Work Phone Number"; Text[30])
        {
            Caption = 'Work Phone Number';
        }
        field(16; "Ext."; Text[7])
        {
            Caption = 'Ext.';
        }
        field(17; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
        }
        field(19; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(20; "ID Number"; Text[30])
        {
            Caption = 'ID Number';
            trigger OnValidate()
            begin
                HRJobApp.RESET;
                HRJobApp.SETRANGE(HRJobApp."ID Number", "ID Number");
                IF HRJobApp.FIND('-') THEN BEGIN
                    ERROR('This ID Number has been used in a prior Job Application.');
                END;
            end;
        }
        field(21; Gender; Option)
        {
            Caption = 'Gender';
            OptionMembers = " ",Male,Female,Other;
        }
        field(22; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
        }
        field(23; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,Closed,Pending,Rejected,"Under Review","Not Successfull",Normal;
        }
        field(24; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            FieldClass = Normal;
        }
        field(25; "Fax Number"; Text[30])
        {
            Caption = 'Fax Number';
        }
        field(26; "Marital Status"; Option)
        {
            Caption = 'Marital Status';
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(27; "Ethnic Origin"; Option)
        {
            Caption = 'Ethnic Origin';
            OptionMembers = " ",Asian,Black,Caucasian,Hispanic,Other,African,Indian,White,Coloured;
        }
        field(28; "First Language (R/W/S)"; Code[10])
        {
            Caption = 'First Language (R/W/S)';
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = FILTER(Language));
        }
        field(29; "Driving Licence"; Code[10])
        {
            Caption = 'Driving Licence';
        }
        field(30; Disabled; Option)
        {
            Caption = 'Disabled';
            OptionMembers = " ",Yes,No;
        }
        field(31; "Health Assesment?"; Boolean)
        {
            Caption = 'Health Assesment?';
        }
        field(32; "Health Assesment Date"; Date)
        {
            Caption = 'Health Assesment Date';
        }
        field(33; "Date Of Birth"; Date)
        {
            Caption = 'Date Of Birth';
            trigger OnValidate()
            begin
                IF "Date Of Birth" >= TODAY THEN BEGIN
                    ERROR('Date of Birth cannot be after %1', TODAY);
                END;
            end;
        }
        field(34; Age; Text[80])
        {
            Caption = 'Age';
        }
        field(35; "Second Language (R/W/S)"; Code[10])
        {
            Caption = 'Second Language (R/W/S)';
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = FILTER(Language));
        }
        field(36; "Additional Language"; Code[10])
        {
            Caption = 'Additional Language';
            TableRelation = "HRM-Lookup Values".Code WHERE(Type = FILTER(Language));
        }
        field(37; "Primary Skills Category"; Option)
        {
            Caption = 'Primary Skills Category';
            OptionMembers = " ",Technical,Management,Communication,Other,Auditors,Consultants,Training,Certification,Administration,Marketing,"Business Development";
        }
        field(38; Level; Option)
        {
            Caption = 'Level';
            OptionMembers = " ",Entry,Intermediate,Expert,"Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7";
        }
        field(39; "Termination Category"; Option)
        {
            Caption = 'Termination Category';
            OptionMembers = " ",Voluntary,Involuntary,Retirement,Other,Resignation,"Non-Renewal Of Contract",Dismissal,Death;
        }
        field(40; "Postal Address2"; Text[30])
        {
            Caption = 'Postal Address2';
        }
        field(41; "Postal Address3"; Text[20])
        {
            Caption = 'Postal Address3';
        }
        field(42; "Residential Address2"; Text[30])
        {
            Caption = 'Residential Address2';
        }
        field(43; "Residential Address3"; Text[20])
        {
            Caption = 'Residential Address3';
        }
        field(44; "Post Code2"; Code[20])
        {
            Caption = 'Post Code2';
            TableRelation = "Post Code";
        }
        field(45; Citizenship; Code[10])
        {
            Caption = 'Citizenship';
            TableRelation = "Country/Region".Code;
            trigger OnValidate()
            begin
                Country.RESET;
                Country.SETRANGE(Country.Code, Citizenship);
                IF Country.FIND('-') THEN BEGIN
                    "Citizenship Details" := Country.Name;
                END;
            end;
        }
        field(46; "Disabling Details"; Text[50])
        {
            Caption = 'Disabling Details';
        }
        field(47; "Disability Grade"; Text[30])
        {
            Caption = 'Disability Grade';
        }
        field(48; "Passport Number"; Text[30])
        {
            Caption = 'Passport Number';
        }
        field(49; "2nd Skills Category"; Option)
        {
            Caption = '2nd Skills Category';
            OptionMembers = " ",Technical,Management,Communication,Other,Auditors,Consultants,Training,Certification,Administration,Marketing,"Business Development";
        }
        field(50; "3rd Skills Category"; Option)
        {
            Caption = '3rd Skills Category';
            OptionMembers = " ",Technical,Management,Communication,Other,Auditors,Consultants,Training,Certification,Administration,Marketing,"Business Development";
        }
        field(51; Region; Code[10])
        {
            Caption = 'Region';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(52; "First Language Read"; Boolean)
        {
            Caption = 'First Language Read';
        }
        field(53; "First Language Write"; Boolean)
        {
            Caption = 'First Language Write';
        }
        field(54; "First Language Speak"; Boolean)
        {
            Caption = 'First Language Speak';
        }
        field(55; "Second Language Read"; Boolean)
        {
            Caption = 'Second Language Read';
        }
        field(56; "Second Language Write"; Boolean)
        {
            Caption = 'Second Language Write';
        }
        field(57; "Second Language Speak"; Boolean)
        {
            Caption = 'Second Language Speak';
        }
        field(58; "PIN Number"; Code[20])
        {
            Caption = 'PIN Number';
        }
        field(59; "Job Applied For"; Text[30])
        {
            Caption = 'Job Applied For';
            Editable = false;
            trigger OnValidate()
            begin
                Jobs.RESET;
                Jobs.SETRANGE(Jobs."Job ID", "Job Applied For");
                IF Jobs.FIND('-') THEN
                    "Job Applied for Description" := Jobs."Job title";
            end;
        }
        field(60; "Employee Requisition No"; Code[20])
        {
            Caption = 'Employee Requisition No';
            TableRelation = "HRM-Employee Requisitions"."Requisition No." WHERE(Closed = CONST(false),
                                                                                 Status = CONST(Approved));
            trigger OnValidate()
            begin
                HREmpReq.Reset;
                HREmpReq.SetRange(HREmpReq."Requisition No.", "Employee Requisition No");
                if HREmpReq.Find('-') then
                    "Job Applied For" := HREmpReq."Job ID";
                "Job Applied for Description" := HREmpReq."Job title";
            end;
        }
        field(61; "Total Score"; Decimal)
        {
            Caption = 'Total Score';
            CalcFormula = Sum("HRM-Job Applic.- Appt. Res".Score WHERE("Applicant No" = FIELD("Application No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; Shortlist; Boolean)
        {
            Caption = 'Shortlist';
        }
        field(63; Qualified; Boolean)
        {
            Caption = 'Qualified';
            Editable = false;
        }
        field(64; Stage; Code[20])
        {
            Caption = 'Stage';
            FieldClass = FlowFilter;
        }
        field(65; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(66; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            TableRelation = "HRM-Employee C"."No.";
            trigger OnValidate()
            begin
                // Existing code for OnValidate trigger
            end;
        }
        field(67; "Applicant Type"; Option)
        {
            Caption = 'Applicant Type';
            Editable = false;
            OptionCaption = 'External,Internal';
            OptionMembers = External,Internal;
        }
        field(68; "Interview Invitation Sent"; Boolean)
        {
            Caption = 'Interview Invitation Sent';
            Editable = false;
        }
        field(69; "Date Applied"; Date)
        {
            Caption = 'Date Applied';
        }
        field(70; "Citizenship Details"; Text[60])
        {
            Caption = 'Citizenship Details';
        }
        field(71; "Date of Interview"; Date)
        {
            Caption = 'Date of Interview';
        }
        field(72; "From Time"; Time)
        {
            Caption = 'From Time';
        }
        field(73; "To Time"; Time)
        {
            Caption = 'To Time';
        }
        field(74; Venue; Text[30])
        {
            Caption = 'Venue';
        }
        field(75; "Interview Type"; Option)
        {
            Caption = 'Interview Type';
            OptionMembers = " ",Telephone,InPerson,Video,Writen,Practicals,Oral,"Oral&Written";
        }
        field(76; Select; Boolean)
        {
            Caption = 'Select';
        }
        field(77; "Job Applied for Description"; Text[100])
        {
            Caption = 'Job Applied for Description';
        }
        field(78; "Selection Count"; Integer)
        {
            Caption = 'Selection Count';
            CalcFormula = Count("HRM-Applicants Shortlist" WHERE("Job Application No" = FIELD("Application No")));
            FieldClass = FlowField;
        }
        field(79; "Marked For Interview(Stage1)"; Boolean)
        {
            Caption = 'Marked For Interview(Stage1)';
        }
        field(80; "Marked For Interview(Stage2)"; Boolean)
        {
            Caption = 'Marked For Interview(Stage2)';
        }
        field(81; "Qualified To Hire"; Boolean)
        {
            Caption = 'Qualified To Hire';
        }
        field(82; "Room No"; Text[30])
        {
            Caption = 'Room No';
        }
        field(83; Floor; Text[30])
        {
            Caption = 'Floor';
        }
        field(84; "Ethnic Group"; Text[50])
        {
            Caption = 'Ethnic Group';
        }
        field(85; Submitted; Boolean)
        {
            Caption = 'Submitted';
        }
        field(86; "CV Path"; Text[250])
        {
            Caption = 'CV Path';
        }
        field(87; "Cover Letter Path"; Text[250])
        {
            Caption = 'Cover Letter Path';
        }
        field(88; "Qualification Criterion"; Integer)
        {
            Caption = 'Qualification Criterion';
        }
        field(89; "Not Qualified (System)"; Boolean)
        {
            Caption = 'Not Qualified (System)';
        }
        field(90; "Passed Areas"; Integer)
        {
            Caption = 'Passed Areas';
        }
        field(91; "Failed Areas"; Integer)
        {
            Caption = 'Failed Areas';
        }
        field(92; "Notification Status"; Option)
        {
            Caption = 'Notification Status';
            OptionMembers = " ",Pending,Sent,Failed;
        }
        field(93; "Ready for Shortlisting"; Boolean)
        {
            Caption = 'Ready for Shortlisting';
        }
        field(94; "CV FileName"; Text[100])
        {
            Caption = 'CV FileName';
        }
        field(95; "Cover Letter FileName"; Text[100])
        {
            Caption = 'Cover Letter FileName';
        }
        field(96; Specialization; Text[250])
        {
            Caption = 'Specialization';
        }
        field(97; "Other Attachments Path"; Text[250])
        {
            Caption = 'Other Attachments Path';
        }
        field(98; "Other Attachments FileName"; Text[100])
        {
            Caption = 'Other Attachments FileName';
        }
        field(99; Religion; Code[20])
        {
            TableRelation = "ACA-Religions".Religion;
        }
        field(100; Denomination; Text[200])
        {
        }
        field(101; "Disability Code"; Code[20])
        {
            Caption = 'Disability Reg. No';
            DataClassification = ToBeClassified;
        }
        field(102; "Job Type"; Option)
        {
            OptionMembers = " ",Teaching,"Non-Teaching";
        }
        field(103; "Nature of Disability"; Option)
        {
            OptionMembers = " ","Sensory Impairement","Mental Impairment","Visual Impairment","Hearing Impairment","Learning Impairment","Physical Impairment",Other;
            Caption = 'Nature of Disability';
            DataClassification = ToBeClassified;
        }
        field(104; "Sifted"; Option)
        {
            Caption = 'Candidate Status';
            OptionMembers = Application,shortlisted,Sifted,Interview,Accepted,Rejected;
        }
        field(105; "Interview Status"; Option)
        {
            OptionMembers = Invited,Passed,Failed;
        }
        field(106; "Interview Marks"; Integer)
        {
            trigger OnValidate()
            begin
                if "Interview Marks" >= 100 then
                    Error('Value cannot be more than 100')
                else
                    Message('Kindly ensure you Upload the interview sheet for referencial purposes');
            end;
        }
        field(107; Notified; Boolean)
        {
        }
        field(108; "Job Ref No"; Text[100])
        {
        }
        field(109; "Interview date"; Date)
        {
        }
        field(110; "Interview Time"; Text[20])
        {
        }
        field(111; "Interview venue"; Code[50])
        {
        }
    }

    keys
    {
        key(PK; "Application No")
        {
            Clustered = true;
        }
    }

    var
        HREmpReq: Record "HRM-Employee Requisitions";
        Employee: Record "HRM-Employee C";
        HRSetup: Record "HRM-Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmpQualifications: Record "HRM-Employee Qualifications";
        AppQualifications: Record "HRM-Applicant Qualifications";
        AppRefferees: Record "HRM-Applicant Referees";
        AppHobbies: Record "HRM-Applicant Hobbies";
        HRJobApp: Record "HRM-Job Applications (B)";
        Country: Record "Country/Region";
        Jobs: Record "HRM-Jobs";

    trigger OnInsert()
    begin
        IF "Application No" = '' THEN BEGIN
            HRSetup.GET;
            HRSetup.TESTFIELD(HRSetup."Job Application Nos");
            NoSeriesMgt.InitSeries(HRSetup."Job Application Nos", xRec."No. Series", 0D, "Application No", "No. Series");
        END;

        "Date Applied" := TODAY;
    end;

    procedure FullName(): Text[200]
    begin
        if "Middle Name" = '' then
            exit("First Name" + ' ' + "Last Name")
        else
            exit("First Name" + ' ' + "Middle Name" + ' ' + "Last Name");
    end;
}

