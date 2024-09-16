page 52046 "Suppervisor Application"
{
    ApplicationArea = All;
    Caption = 'Suppervisor Application';
    PageType = Card;
    SourceTable = "Postgrad Supervisor Applic.";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Student No."; Rec."Student No.")
                {
                    ToolTip = 'Specifies the value of the Student No. field.', Comment = '%';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ToolTip = 'Specifies the value of the Student Name field.', Comment = '%';
                }
                field("Assigned Suppervisor Code"; Rec."Assigned Suppervisor Code")
                {
                    ToolTip = 'Specifies the value of the Assigned Suppervisor Code field.', Comment = '%';
                }
                field("Assigned Supervisor Name"; Rec."Assigned Supervisor Name")
                {
                    ToolTip = 'Specifies the value of the Assigned Supervisor Name field.', Comment = '%';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ToolTip = 'Specifies the value of the Date Approved field.', Comment = '%';
                }
            }
        }
    }
}
