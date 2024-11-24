page 52178565 "Proc-Fin.Tender Qualif.Quote"
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
                field("Tender Quoted Amount"; Rec."Tender Quoted Amount")
                {
                    Caption = 'Total Quoted';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender Quoted Amount field.';
                }

            }
        }
    }
}