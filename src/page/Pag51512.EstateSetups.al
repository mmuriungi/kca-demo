page 51512 "Estate Setups"
{
    Caption = 'Estate Setups';
    PageType = Card;
    SourceTable = "Estates Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Repair No."; Rec."Repair No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Repair No. field.';
                }
                field("Maintenance No."; Rec."Maintenance No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maintenance Request No."; Rec."Maintenance Request No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bill No."; Rec."Bill No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Project No."; Rec."Project No.")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Maintenance Schedule Subject")
            {
                field("MaintenanceScheduleSubject"; Rec."Maintenance Schedule Subject")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    MultiLine = true;
                    ShowCaption = false;
                }
            }
            /*  label(S)
             {
                 ApplicationArea = Basic, Suite;
                 ShowCaption = false;
             } */
            group("Maintenance Schedule Link")
            {
                field("MaintenanceLink"; Rec."Maintenance Schedule Link")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    MultiLine = true;
                    ShowCaption = false;
                }
            }
        }
    }
}
