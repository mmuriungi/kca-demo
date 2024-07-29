page 54943 "HMS-Setup Diagnosis List"
{
    PageType = List;
    SourceTable = "HMS-Setup Diagnosis";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                Editable = false;
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("New Diagnosis")
            {
                Caption = 'New Diagnosis';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "HMS-Setup Diagnosis Card";
                ApplicationArea = All;
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

