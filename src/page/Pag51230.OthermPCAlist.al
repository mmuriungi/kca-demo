page 51230 "Other mPCA list"
{
    CardPageID = "Other massPCAs";
    PageType = List;
    SourceTable = prMassPCAHD;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Change Advice Serial No."; Rec."Change Advice Serial No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = All;
                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = All;
                }
                field("Other Allowances"; Rec."Other Allowances")
                {
                    ApplicationArea = All;
                }
                field("Allowance Name"; Rec."Allowance Name")
                {
                    ApplicationArea = All;
                }
                field("Transaction Code"; Rec."Transaction Code")
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

