page 52178543 "Proc-Preliminary Qualif.Quote"
{
    PageType = ListPart;
    SourceTable = "Proc-Preliminary Qualif.Quote";
    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field("Quote No."; Rec."Quote No.")
                {
                    Caption = 'Quote/Bid No.';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quote No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Scored; Rec.Scored)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Scored field.';
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = all;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff No field.';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff Name field.';
                }
                field("Requirement Met"; rec."Requirement Met")
                {

                }
                field("Requirement Not Met"; rec."Requirement Not Met")
                {

                }
            }
        }
    }
}