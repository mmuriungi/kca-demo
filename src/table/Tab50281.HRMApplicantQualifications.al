table 50281 "HRM-Applicant Qualifications"
{
    Caption = 'HR Applicant Qualifications';
    DataCaptionFields = "Employee No.";
    //todo  DrillDownPageID = 39003960;
    //todo LookupPageID = 39003960;


    fields
    {
        field(1; "Application No"; Code[10])
        {
            Caption = 'Application No';
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
        }
        field(3; "Qualification Description"; Code[80])
        {
            Caption = 'Qualification Description';
        }
        field(4; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(5; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = " ",Internal,External,"Previous Position";
        }
        field(7; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(8; "Institution/Company"; Text[30])
        {
            Caption = 'Institution/Company';
        }
        field(9; Cost; Decimal)
        {
            Caption = 'Cost';
        }
        field(10; "Course Grade"; Text[30])
        {
            Caption = 'Course Grade';
        }
        field(11; "Employee Status"; Option)
        {
            Caption = 'Employee Status';
            OptionMembers = " ",Active,Inactive,Terminated,OnLeave; // Customize as needed
        }
        field(13; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(14; "Qualification Type"; Code[20])
        {
            Caption = 'Qualification Type';
        }
        field(15; "Qualification Code"; Text[100])
        {
            Caption = 'Qualification Code';
            trigger OnValidate()
            begin
                IF HRQualifications.GET("Qualification Type", "Qualification Code") THEN
                    "Qualification Description" := HRQualifications.Description;
                IF JobReq.GET(JobReq."Qualification Type", JobReq."Qualification Code") THEN
                    "Score ID" := JobReq."Desired Score";
            end;
        }
        field(16; "Score ID"; Decimal)
        {
            Caption = 'Score ID';
        }
        field(17; "Desired Score"; Decimal)
        {
            Caption = 'Desired Score';
        }
        field(18; "Attachment Path"; Text[250])
        {
            Caption = 'Attachment Path';
        }
        field(19; "File Name"; Text[250])
        {
            Caption = 'File Name';
        }
        field(20; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(21; "Member Since"; Code[10])
        {
            Caption = 'Member Since';
        }
        field(22; Title; Text[250])
        {
            Caption = 'Title';
        }
        field(23; ISBN; Code[50])
        {
            Caption = 'ISBN';
        }
        field(24; Publisher; Text[100])
        {
            Caption = 'Publisher';
        }
        field(25; "Year of Publication"; Code[10])
        {
            Caption = 'Year of Publication';
        }
        field(26; "Chapter Title"; Text[250])
        {
            Caption = 'Chapter Title';
        }
        field(27; "Page From"; Text[30])
        {
            Caption = 'Page From';
        }
        field(28; "Page To"; Text[30])
        {
            Caption = 'Page To';
        }
        field(29; "Seminar Type"; Text[30])
        {
            Caption = 'Seminar Type';
        }
        field(30; "Seminar Mode"; Text[30])
        {
            Caption = 'Seminar Mode';
        }
        field(31; "Year of Supervision"; Code[10])
        {
            Caption = 'Year of Supervision';
        }
        field(32; "Post Graduate Level"; Text[10])
        {
            Caption = 'Post Graduate Level';
        }
        field(33; "No of students"; Integer)
        {
            Caption = 'No of students';
        }
        field(34; Grant; Text[250])
        {
            Caption = 'Grant';
        }
        field(35; "Grant Year"; Code[10])
        {
            Caption = 'Grant Year';
        }
        field(36; "Grant Purpose"; Text[250])
        {
            Caption = 'Grant Purpose';
        }
        field(37; "Education Level"; Text[30])
        {
            Caption = 'Education Level';
        }
        field(38; "Journal Title"; Text[250])
        {
            Caption = 'Journal Title';
        }
    }

    keys
    {
        key(PK; "Application No", "Qualification Type", "Qualification Code", Description)
        {
            Clustered = true;
        }
    }

    var
        HRQualifications: Record "HRM-Qualifications";
        Applicant: Record "HRM-Job Applications (B)";
        Position: Code[20];
        JobReq: Record "HRM-Job Requirements";
}