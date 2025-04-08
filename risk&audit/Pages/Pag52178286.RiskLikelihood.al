page 52178286 "Risk Likelihood"
{
    PageType = List;
    SourceTable = "Risk Likelihood";
    SourceTableView = SORTING("Likelihood Score") ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Likelihood Score"; "Likelihood Score")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Probability Start Range"; "Probability Start Range")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Probability Start >= (%)';
                }
                field(Probability; Probability)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Probability End <= (%)';
                }
                field("Frequency (General)"; "Frequency (General)")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Frequency (Timeframe)"; "Frequency (Timeframe)")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }
}

