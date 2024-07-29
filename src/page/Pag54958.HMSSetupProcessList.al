page 54958 "HMS-Setup Process List"
{
    PageType = List;
    SourceTable = "PROC-Store Requistion Header";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Request date"; Rec."Request date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

