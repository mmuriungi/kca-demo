/// <summary>
/// Page Staff training and development (ID 50031).
/// </summary>
page 51332 "Staff training and development"
{
    Caption = 'Staff training and development';
    PageType = Listpart;
    SourceTable = Appraisal;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Perfomance Gap"; Rec."Perfomance Gap")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Perfomance Gap field.';
                }
                field("Required Training"; Rec."Required Training")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Required Training field.';
                }
                field(Timeline; Rec.Timeline)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Timeline field.';
                }
            }
        }
    }
}
