page 52179099 "Legal Case Party Card"
{
    PageType = Card;
    SourceTable = "Legal Case Party";
    Caption = 'Legal Case Party Card';

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
                    ToolTip = 'Specifies the entry number.';
                    Editable = false;
                }
                field("Case No."; Rec."Case No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the case number.';
                }
                field("Party Type"; Rec."Party Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the party type.';
                }
                field("Party Name"; Rec."Party Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the party name.';
                }
                field("Party ID/Registration No."; Rec."Party ID/Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the party ID or registration number.';
                }
                field("Is University Party"; Rec."Is University Party")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if this is a university party.';
                }
            }
            
            group("Legal Representation")
            {
                Caption = 'Legal Representation';
                
                field("Legal Representative"; Rec."Legal Representative")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the legal representative.';
                }
                field("Law Firm"; Rec."Law Firm")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the law firm.';
                }
            }
            
            group("Contact Information")
            {
                Caption = 'Contact Information';
                
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the contact person.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the phone number.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the email address.';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the address.';
                    MultiLine = true;
                }
            }
            
            group("University Relations")
            {
                Caption = 'University Relations';
                Visible = Rec."Is University Party";
                
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee number if this is a university employee.';
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the student number if this is a university student.';
                }
            }
        }
    }
}