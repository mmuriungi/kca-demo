page 54864 "HMS Laboratory List"
{
    CardPageID = "HMS-Laboratory Form Test";
    PageType = List;
    SourceTable = "HMS-Laboratory Form Header";


    layout
    {
        area(content)
        {
            repeater(rep)
            {
                Editable = false;

                field("Laboratory No."; Rec."Laboratory No.")
                {
                    ApplicationArea = All;
                }
                field("Link Type"; Rec."Link Type")
                {
                    ApplicationArea = All;
                }
                field("Link No."; Rec."Link No.")
                {
                    ApplicationArea = All;
                }
                field("Laboratory Date"; Rec."Laboratory Date")
                {
                    ApplicationArea = All;
                }
                field("Laboratory Time"; Rec."Laboratory Time")
                {
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                    ApplicationArea = All;
                }
                field("Scheduled Time"; Rec."Scheduled Time")
                {
                    ApplicationArea = All;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
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

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

