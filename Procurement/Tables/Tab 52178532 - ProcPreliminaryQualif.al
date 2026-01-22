table 52178532 "Proc-Preliminary Qualif"
{
    DrillDownPageId = "Proc-Preliminary Qualif";
    LookupPageId = "Proc-Preliminary Qualif";
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'S/No';
        }
        field(2; "No."; Code[30])
        {

        }
        field(3; "Description"; Text[500])
        {

        }
        field(4; "Can Exempted"; Boolean)
        {

        }
        field(5; "Expected Score"; Option)
        {
            OptionMembers = "","Requirement Met","Requirement Not Met";
            OptionCaption = ' ,No,Yes';
        }
        field(6; Mandatory; Boolean)
        {

        }
    }

    keys
    {
        key(pk; "Entry No.", "No.")
        {

        }
    }
    trigger OnInsert()
    begin
        Mandatory := true;
    end;
}