page 50806 "ACA-Admn Number Setup"
{
    PageType = List;
    SourceTable = "ACA-Adm. Number Setup";

    layout
    {
        area(content)
        {
            repeater(__)
            {
                field(Degree; Rec.Degree)
                {
                    ApplicationArea = All;
                }
                field("Degree Name"; Rec."Degree Name")
                {
                    ApplicationArea = All;
                }
                field("Programme Prefix"; Rec."Programme Prefix")
                {
                    ApplicationArea = All;
                }
                field("JAB Prefix"; Rec."JAB Prefix")
                {
                    ApplicationArea = All;
                }
                field("SSP Prefix"; Rec."SSP Prefix")
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("Reporting Date"; Rec."Reporting Date")
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

