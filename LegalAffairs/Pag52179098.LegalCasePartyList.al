page 52179098 "Legal Case Party List"
{
    PageType = List;
    SourceTable = "Legal Case Party";
    Caption = 'Legal Case Party List';
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
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
                field("Is University Party"; Rec."Is University Party")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if this is a university party.';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("New Party")
            {
                ApplicationArea = All;
                Caption = 'New Party';
                Image = New;
                ToolTip = 'Add a new party to the case.';
                
                trigger OnAction()
                var
                    LegalCaseParty: Record "Legal Case Party";
                begin
                    LegalCaseParty.Init();
                    if Rec."Case No." <> '' then
                        LegalCaseParty."Case No." := Rec."Case No.";
                    LegalCaseParty.Insert(true);
                    Page.Run(Page::"Legal Case Party Card", LegalCaseParty);
                end;
            }
        }
    }
}