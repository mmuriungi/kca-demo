page 52178605 "Proc-Prequalification Years"
{
    PageType = List;
    Editable = false;
    DeleteAllowed = false;
    CardPageId = "Proc-Preq Year.Card";
    SourceTable = "Proc-Prequalification Years";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Preq. Year"; Rec."Preq. Year")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Preq. Categories"; Rec."Preq. Categories")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Preq. Dates List"; Rec."Preq. Dates List")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
            }

        }
    }

    actions
    {
    }
}

