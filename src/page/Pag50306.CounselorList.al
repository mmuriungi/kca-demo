page 50306 "Counselor List"
{
    ApplicationArea = All;
    Caption = 'Counselor List';
    PageType = List;
    SourceTable = "HRM-Employee C";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field.', Comment = '%';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field.', Comment = '%';
                }
                field("Other Names"; Rec."Other Names")
                {
                    ToolTip = 'Specifies the value of the Other Names field.', Comment = '%';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
            }
        }
    }
}
