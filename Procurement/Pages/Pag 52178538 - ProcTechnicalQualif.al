page 52178538 "Proc-Technical Qualif"
{
    Caption = 'Technical Qualifications';
    PageType = ListPart;
    SourceTable = "Proc-Technical Qualif";
    layout
    {
        area(Content)
        {
            repeater(general)
            {

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Can Exempt"; Rec."Can Exempt")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Can Exempt field.';
                }
                field("Maximum Score"; Rec."Maximum Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Score field.';
                }
                field("Satisfactory Score"; Rec."Satisfactory Score")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Satisfactory Score field.';
                }
            }
        }
    }
}