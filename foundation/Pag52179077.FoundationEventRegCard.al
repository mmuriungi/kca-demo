page 52179077 "Foundation Event Reg. Card"
{
    PageType = Card;
    SourceTable = "Foundation Event Registration";
    Caption = 'Foundation Event Registration Card';
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Registration No."; Rec."Registration No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Event No."; Rec."Event No.")
                {
                    ApplicationArea = All;
                }
                field("Event Name"; Rec."Event Name")
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
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = All;
                }
                field("Attendance Status"; Rec."Attendance Status")
                {
                    ApplicationArea = All;
                }
            }
            
            group(TicketInfo)
            {
                Caption = 'Ticket Information';
                
                field("Ticket Type"; Rec."Ticket Type")
                {
                    ApplicationArea = All;
                }
                field("Registration Fee"; Rec."Registration Fee")
                {
                    ApplicationArea = All;
                }
                field("Payment Status"; Rec."Payment Status")
                {
                    ApplicationArea = All;
                }
                field("Guest Count"; Rec."Guest Count")
                {
                    ApplicationArea = All;
                }
            }
            
            group(ContactInfo)
            {
                Caption = 'Contact Information';
                
                field("Email"; Rec."Email")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Dietary Requirements"; Rec."Dietary Requirements")
                {
                    ApplicationArea = All;
                }
                field("Special Needs"; Rec."Special Needs")
                {
                    ApplicationArea = All;
                }
            }
            
            group(Administration)
            {
                Caption = 'Administration';
                
                field("Notes"; Rec."Notes")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Table Assignment"; Rec."Table Assignment")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}