// Table: Incident Report
table 50171 "Incident Report"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Case No."; Code[20])
        {
        }
        field(2; "Accused Name"; Text[100])
        {
        }
        field(3; "Victim/Reporting Party"; Text[100])
        {
        }
        field(4; "Nature of Case"; Text[250])
        {
        }
        field(5; "Accused ID Number"; Code[20])
        {
        }
        field(6; "Accused Phone Number"; Text[20])
        {
        }
        field(7; "Accused Residence"; Text[100])
        {
        }
        field(8; "Category"; Option)
        {
            OptionMembers = Internal,Police;
        }
        field(9; "Accused Type"; Option)
        {
            OptionMembers = Student,Staff;
        }
        field(10; "Status"; Option)
        {
            OptionMembers = Open,Closed,Forwarded;
        }
        field(11; "Forwarded To"; Option)
        {
            OptionMembers = ,"Dean of Students",Registrar,VC;
        }
        field(12; "Date Reported"; Date)
        {
        }
        field(13; "Time Reported"; Time)
        {
        }
        field(14; "Date Closed"; Date)
        {
        }
        field(15; "Time Closed"; Time)
        {
        }
        field(16; "Incident Location"; Text[100])
        {
        }
        field(18; "No. Series"; Code[20])
        {
        }
        field(19; "OB No."; Code[20])
        {
            TableRelation = "Daily Occurrence Book"."OB No.";
        }
        field(20; "Case Summary Desctiption"; Text[300])
        {
        }
    }
    keys
    {
        key(PK; "Case No.", "OB No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        Setup.Get();
        setup.TestField("Incident Nos");
        Noseries.InitSeries(Setup."Incident Nos", xRec."No. Series", 0D, rec."Case No.", Rec."No. Series");
    end;

    var
        Setup: Record "Security Setup";
        Noseries: Codeunit NoSeriesManagement;
}
