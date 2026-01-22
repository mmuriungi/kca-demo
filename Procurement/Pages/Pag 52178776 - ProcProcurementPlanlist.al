page 52178776 "Proc-Procurement Plan list"
{
    CardPageID = "PROC-Procurement Plan Header";
    PageType = List;
    SourceTable = "PROC-Procurement Plan Header";
    editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Budget Name"; Rec."Budget Name")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budgeted Amount field.';
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Active field.';
                }

            }
        }
    }

    actions
    {
    }
}

