page 52178581 "Prequalification Application"
{
    PageType = List;
    SourceTable = "Prequalification Application";
    DeleteAllowed = false;
    Editable = false;
    CardPageId = "Preq Application Card";
    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Registration No. field.';
                }
                field("Prequalification Period"; Rec."Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prequalification Period field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone field.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Postal Code field.';
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact Person field.';
                }
                field("Contact Telephone"; Rec."Contact Telephone")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact Telephone field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field(Prequalified; Rec.Prequalified)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prequalified field.';
                }
                field("Date Prequalified"; Rec."Date Prequalified")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Prequalified field.';
                }
                field("Prequalified By"; Rec."Prequalified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prequalified By field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Prequalify")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = PostApplication;
                trigger OnAction()
                begin

                    if Confirm('Post Approved Categories ?', true) = false then Error('Cancelled');
                    Rec.Prequlification(Rec);



                end;
            }
        }
    }
}