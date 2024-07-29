pageextension 50008 UsersetupPgExt extends "User Setup"
{
    layout
    {
        addbefore("Staff No")
        {
            field("Can Extend Surrender Period"; Rec."Can Extend Surrender Period")
            {
                ApplicationArea = all;
            }
            field(HOD; Rec.HOD)
            {
                ApplicationArea = all;
            }
        }
    }
}
