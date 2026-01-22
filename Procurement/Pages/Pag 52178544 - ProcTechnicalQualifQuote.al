page 52178544 "Proc-Technical Qualif.Quote"
{
    PageType = ListPart;
    SourceTable = "Proc-Technical Qualif.Quote";
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
                field("Maximum Score"; Rec."Maximum Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Score field.';
                }
                field(Scored; Rec.Scored)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Scored field.';
                }
                field("Staff No"; Rec."Staff No")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff No field.';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff Name field.';
                }
                field("Evaluation Commitee Count"; Rec."Evaluation Commitee Count")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Evaluation Commitee Count field.';
                }

                field("Average Score"; Rec."Average Score")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Average Score field.';
                }
            }
        }
    }
}