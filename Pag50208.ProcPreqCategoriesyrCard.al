page 52057 "Proc-Preq. Categories/yr Card"
{
    //DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Proc-Preq. Categories/Year";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Preq. Year"; Rec."Preq. Year")
                {
                    ApplicationArea = All;
                }
                field("Preq. Category"; Rec."Preq. Category")
                {
                    ApplicationArea = All;
                }
                field("Prequalified Suppliers"; Rec."Prequalified Suppliers")
                {
                    Editable = false;
                    ApplicationArea = All;
                }

            }
            part(ls; "Proc-Preq. Suppliers/Category")
            {
                //Preq. Year" = FIELD("Preq. Year"),
                //                 "Preq. Category" = FIELD("Preq. Category"
                SubPageLink = "Preq. Year" = FIELD("Preq. Year"), "Preq. Category" = FIELD("Preq. Category");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(rep)
            {
                action("Prequalification Report")
                {
                    Image = "Action";
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        preqYC.RESET;
                        preqYC.SETRANGE("Preq. Year", Rec."Preq. Year");
                        preqYC.SETRANGE("Preq. Category", Rec."Preq. Category");
                        REPORT.RUN(REPORT::"Proc-Prequalification Summary", TRUE, FALSE, preqYC);
                    end;
                }
            }
        }
    }

    var
        preqYC: Record "Proc-Preq. Categories/Year";
}

