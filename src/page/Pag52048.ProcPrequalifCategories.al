page 52048 "Proc-Prequalif. Categories"
{
    PageType = ListPart;
    SourceTable = "Proc-Prequalif. Categories";
    DeleteAllowed = false;
    CardPageId = "Proc-Prequalif.YC";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Preq Year"; Rec."Preq Year")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Preq Year field.';
                }
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Procurement methods"; Rec."Procurement methods")
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

