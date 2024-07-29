table 55701 "Displinary Cases"
{
    fields
    {
        field(1; "No."; Code[30])
        {

        }
        field(2; "Employee No."; Code[30])
        {
            TableRelation = "HRM-Employee C"."No.";

            trigger OnValidate()
            var
                empl: Record "HRM-Employee C";
            begin
                empl.Reset();
                empl.SetRange("No.", Rec."Employee No.");
                if empl.Find('-') then begin
                    Rec."Employee Name" := empl."First Name" + ' ' + empl."Middle Name" + ' ' + empl."Last Name";
                    Rec."Job Title" := empl."Job Title";
                end;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {

        }
        field(4; "Job Title"; Text[100])
        {

        }
        field(5; "Type"; Option)
        {
            OptionMembers = Minor,Major;
            OptionCaption = 'Minor,Major';
        }
        field(6; "Offence Identified"; text[100])
        {
            TableRelation = "Displinary Offence Types".Offence;
        }
        field(7; "Offence Description"; Text[220])
        {


        }
        field(8; "Show Cause Letter"; Boolean)
        {

        }
        field(9; "Show Cause Response"; text[200])
        {

        }
        field(10; "Satisfactory"; Boolean)
        {

        }
        field(11; "Not Satisfactory"; Boolean)
        {

        }
        field(12; "End"; Boolean)
        {

        }
        field(13; "Case Status"; Option)
        {
            OptionCaption = 'Supervisor,Show Cause,Fowarded to DDHR,Forwaded to HRMO,Fowarded to DDHR_T,HRMOImplement,DDHR_Board_T,Suspension,DDHR_HRC,Investigation,No_Case,Case_Found';
            OptionMembers = Supervisor,"Show Cause","Fowarded to DDHR","Fowarded to HRMO","Fowarded to DDHR_T","HRMOImplement","DDHR_Board_T",Suspension,"DDHR_HRC",Investigation,No_Case,Case_Found;
        }
        field(14; "1st Committee Identified"; code[50])
        {
            TableRelation = "Displinary Committess"."Committe Code";
        }
        field(15; "JSAC/SSACS Committee"; Boolean)
        {

        }
        field(16; "HRC Committee"; Boolean)
        {

        }
        field(29; "2nd Committee Identified"; code[50])
        {
            TableRelation = "Displinary Committess"."Committe Code";
        }
        field(30; "3rd Committee Identified"; code[50])
        {
            TableRelation = "Displinary Committess"."Committe Code";
        }
        field(31; "4th Committee Identified"; code[50])
        {
            TableRelation = "Displinary Committess"."Committe Code";
        }
        field(32; "5th Committee Identified"; code[50])
        {
            TableRelation = "Displinary Committess"."Committe Code";
        }
        field(33; "6th Committee Identified"; code[50])
        {
            TableRelation = "Displinary Committess"."Committe Code";
        }

        field(17; "Full Board"; Boolean)
        {

        }
        field(18; "Suspend Staff"; Boolean)
        {

        }
        field(19; "Investigation"; Boolean)
        {

        }
        field(20; "Displinary Case"; Boolean)
        {

        }
        field(21; "Formal Hearing"; Boolean)
        {

        }
        field(22; "Formal Hearing Committee"; text[100])
        {

        }
        field(23; "Dismissal ?"; Boolean)
        {

        }
        field(24; "Appeal"; Boolean)
        {

        }
        field(25; "Appeal Panel"; text[100])
        {

        }

        field(26; "Dismissal"; Boolean)
        {

        }
        field(27; "Initiate Crearence"; Boolean)
        {

        }
        field(28; "Case Closed"; Boolean)
        {

        }
        field(34; "No. Series"; Code[30])
        {
            Editable = false;
        }
        field(35; "Date Reported"; Date)
        {

        }
        field(36; "Date Closed"; Date)
        {

        }
        field(37; "Case Status2"; Option)
        {
            OptionCaption = '  ,HRMOImplement,DDHR_Board_T';
            OptionMembers = "  ",HRMOImplement,"DDHR_Board_T";
        }
        field(38; "Summary Defense1"; text[250])
        {

        }
        field(39; "Summary Defense2"; text[250])
        {

        }

    }

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            NoSeriesMgt.InitSeries('Disp Proc', xRec."No. Series", 0D, "No.", "No. Series");
        end
    end;
}