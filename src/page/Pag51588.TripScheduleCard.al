page 51588 "Trip Schedule Card"
{
    Caption = 'Trip Schedule Card';
    PageType = Card;
    SourceTable = "Trip Schedule";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Driver Code "; Rec."Driver Code ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver Code field.', Comment = '%';
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver Name field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination field.', Comment = '%';
                }
                field("No Of Days"; Rec."No Of Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No Of Days field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("Vehicle Reg No"; Rec."Vehicle Reg No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle Reg No field.', Comment = '%';
                }
            }
        }
    }
}
