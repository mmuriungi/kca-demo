page 54907 "HMS Pharmacy List"
{
    CardPageID = "HMS Pharmacy Header";
    PageType = List;
    SourceTable = "HMS-Pharmacy Header";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                Editable = false;
                field("Pharmacy No."; Rec."Pharmacy No.")
                {
                    ApplicationArea = All;
                }
                field("Pharmacy Date"; Rec."Pharmacy Date")
                {
                    ApplicationArea = All;
                }
                field("Pharmacy Time"; Rec."Pharmacy Time")
                {
                    ApplicationArea = All;
                }

                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Full Name field.';
                }

                field("Issued By"; Rec."Issued By")
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

