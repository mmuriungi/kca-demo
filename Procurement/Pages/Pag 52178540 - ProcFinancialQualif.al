page 52178540 "Proc-Financial Qualif"
{
    Caption = 'Financial Qualifications';
    PageType = ListPart;
    SourceTable = "Proc-Financial Qualif";
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
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budgeted Amount field.';
                }
            }
        }
    }
}