page 54908 "HMS-Pharmacy Posted"
{
    CardPageID = "HMS Posted Pharmacy Header";
    PageType = List;
    SourceTable = "HMS-Pharmacy Header";
    SourceTableView = WHERE(Status = CONST(Completed));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Pharmacy No."; Rec."Pharmacy No.")
                {
                    ApplicationArea = All;
                }
                field("Pharmacy Date"; Rec."Pharmacy Date")
                {
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }

                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Full Name field.';
                }

            }
        }
    }

    actions
    {
    }
}

