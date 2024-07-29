table 55702 "Displinary Committe InvstF"
{
    DrillDownPageId = "Displinary Committe InvstF";
    LookupPageId = "Displinary Committe InvstF";

    fields
    {
        field(1; "Case No"; Code[30])
        {

        }
        field(2; "Investigation Commitee"; code[50])
        {

        }
        field(3; "Charge"; code[100])
        {

        }
        field(4; "start Date"; Date)
        {

        }
        field(5; "Findings"; text[200])
        {

        }
        field(6; "Conclusion"; Option)
        {
            OptionCaption = '  ,Guilty, Not Guilty, Pending Determination';
            OptionMembers = "  ",Guilty,"Not Guilty","Pending Determination";
        }
        field(7; "Investigation Closed"; Boolean)
        {

        }
        field(8; "Officer Incharge"; text[100])
        {

        }
    }
}