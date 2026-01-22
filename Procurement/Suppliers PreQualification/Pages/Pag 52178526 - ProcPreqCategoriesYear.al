page 52178526 "Proc-Preq. Categories/Year"
{
    CardPageID = "Proc-Preq. Categories/yr Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Proc-Preq. Categories/Year";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Preq. Year"; Rec."Preq. Year")
                {
                    Editable = true;
                    Enabled = true;
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

