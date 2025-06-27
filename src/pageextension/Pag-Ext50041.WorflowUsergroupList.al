pageextension 50041 "Worflow Usergroup List" extends "Workflow User Groups"
{
    layout
    {
        addafter(Description)
        {
            field("Department Code"; Rec."Department Code")
            {
                ApplicationArea = all;
            }
            field("Department Name";Rec."Department Name")
            {
                ApplicationArea = all;
            }
        }
    }
}
