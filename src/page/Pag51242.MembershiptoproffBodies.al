page 51242 "Membership to proff Bodies"
{
    Caption = 'Membership to proff Bodies';
    PageType = List;
    SourceTable = "Membership to proff Bodies";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Job Application No"; Rec."Job Application No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Application No field.', Comment = '%';
                }
                field("Name of the body"; Rec."Name of the body")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name of the body field.', Comment = '%';
                }
                field("Period of Membership"; Rec."Period of Membership")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period of Membership field.', Comment = '%';
                }
            }
        }
    }
}
