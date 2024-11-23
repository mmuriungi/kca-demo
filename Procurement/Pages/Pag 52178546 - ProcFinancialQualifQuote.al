page 52178546 "Proc-Financial Qualif.Quote"
{
    PageType = ListPart;
    SourceTable = "Proc-Financial Qualif.Quote";

    layout
    {
        area(Content)
        {
            repeater(general)
            {
                Editable = false;

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budgeted Amount field.';
                }
                field("Quoted Amount"; Rec."Quoted Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quoted Amount field.';
                }
                field("Lowest Quoted Price"; Rec."Lowest Quoted Price")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lowest Quoted Price field.';
                }
                field("Maximum Marks"; Rec."Maximum Marks")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Marks field.';
                }
                field(Score; Rec.Score)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Score field.';
                }
            }
        }
    }
}