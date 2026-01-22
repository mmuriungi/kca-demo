page 52179076 "Foundation Communication Card"
{
    PageType = Card;
    SourceTable = "Foundation Communication";
    Caption = 'Foundation Communication Card';
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Communication Date"; Rec."Communication Date")
                {
                    ApplicationArea = All;
                }
                field("Communication Time"; Rec."Communication Time")
                {
                    ApplicationArea = All;
                }
                field("Donor No."; Rec."Donor No.")
                {
                    ApplicationArea = All;
                }
                field("Donor Name"; Rec."Donor Name")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Details)
            {
                Caption = 'Communication Details';
                
                field("Communication Type"; Rec."Communication Type")
                {
                    ApplicationArea = All;
                }
                field("Subject"; Rec."Subject")
                {
                    ApplicationArea = All;
                }
                field(MessageContent; Rec."Content")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Caption = 'Message Content';
                }
                field("Method"; Rec."Method")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Direction"; Rec."Direction")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Contact)
            {
                Caption = 'Contact Information';
                
                field("Contact Email"; Rec."Contact Email")
                {
                    ApplicationArea = All;
                }
                field("Contact Phone"; Rec."Contact Phone")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Response)
            {
                Caption = 'Response Tracking';
                
                field("Response Required"; Rec."Response Required")
                {
                    ApplicationArea = All;
                }
                field("Response Received"; Rec."Response Received")
                {
                    ApplicationArea = All;
                }
                field("Follow Up Date"; Rec."Follow Up Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}