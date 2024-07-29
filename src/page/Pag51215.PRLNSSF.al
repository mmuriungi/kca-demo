page 51215 "PRL-NSSF"
{
    PageType = Worksheet;
    SourceTable = "PRL-NSSF";
    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Tier Code"; Rec."Tier Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tier Code field.';
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lower Limit field.';
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Upper Limit field.';
                }
                field("Amount Type"; Rec."Amount Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Type field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Tier I Limit"; Rec."Tier I Limit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tier I Limit field.';
                }
            }
        }
    }
}