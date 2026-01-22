page 52141 "ACA-Batch Hostel Booking LST"
{
    ApplicationArea = All;
    Caption = 'ACA-Batch Hostel Booking LST';
    PageType = List;
    SourceTable = "ACA-Batch Room Alloc. Header";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Specifies the value of the Academic Year field.', Comment = '%';
                }
                field("Hostel Block"; Rec."Hostel Block")
                {
                    ToolTip = 'Specifies the value of the Hostel Block field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ToolTip = 'Specifies the value of the Date Created field.', Comment = '%';
                }
                field("Number of Allocation"; Rec."Number of Allocation")
                {
                    ToolTip = 'Specifies the value of the Number of Allocation field.', Comment = '%';
                }
                field("Notification type"; Rec."Notification type")
                {
                    ToolTip = 'Specifies the value of the Notification type field.', Comment = '%';
                }
                field("Time Created"; Rec."Time Created")
                {
                    ToolTip = 'Specifies the value of the Time Created field.', Comment = '%';
                }
                field("Total Allocations in Year"; Rec."Total Allocations in Year")
                {
                    ToolTip = 'Specifies the value of the Total Allocations in Year field.', Comment = '%';
                }
            }
        }
    }
}
