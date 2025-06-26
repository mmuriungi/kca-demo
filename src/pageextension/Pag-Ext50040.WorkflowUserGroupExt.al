pageextension 50040 "Workflow UserGroup Ext" extends "Workflow User Group"
{
    layout
    {
        addafter(Description)
        {
            group(Department)
            {
                Caption = 'Department';
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
