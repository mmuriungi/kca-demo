page 52063 "PostGraduate Setup"
{
    ApplicationArea = All;
    Caption = 'PostGraduate Setup';
    PageType = Card;
    SourceTable = "PostGraduate Setup";

    layout
    {
        area(Content)
        {
            field("Min. Supervisor Applic Fees"; Rec."Min. Supervisor Applic Fees")
            {
                ToolTip = 'Specifies the value of the Min. Supervisor Applic Fees field.', Comment = '%';
            }
            field("Check Student "; Rec."Check Student ")
            {
                ToolTip = 'Specifies the value of the Check Student field.', Comment = '%';
            }
            field("Submission Nos"; Rec."Submission Nos")
            {
                ToolTip = 'Specifies the value of the Submission Nos field.', Comment = '%';
            }
            field("Supervisor Assignment Nos."; Rec."Supervisor Assignment Nos.")
            {
                ToolTip = 'Specifies the value of the Supervisor Assignment Nos. field.', Comment = '%';
            }

        }
    }
}
