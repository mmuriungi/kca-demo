page 54246 "FLT-Transport Places"
{
    PageType = Listpart;
    SourceTable = "FLT-Transport Places";
    Caption = 'FLT-Transport Places';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Place; Rec.Place)
                {
                    ApplicationArea = All;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

