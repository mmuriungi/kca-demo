page 52178582 "Preq Application Card"
{
    PageType = Document;
    SourceTable = "Prequalification Application";
    DeleteAllowed = false;
    PromotedActionCategories = 'New,Prequlify, Attach';
    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = edt;
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

            group("Applied Categories")
            {
                //Editable = edt;
                part(cat; "Preq Application categories")
                {
                    ApplicationArea = All;
                    SubPageLink = "VAT Registration" = field("VAT Registration No."), Period = field(Period);
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("Submits")
            {
                action("Submit Application")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = SuggestNumber;

                    trigger OnAction()
                    begin
                        if Confirm('Submit Application ?', true) = false then Error('cancelled');
                        rec.Status := Rec.Status::Submitted;
                        rec.Modify();
                        CurrPage.Close();
                    end;

                }
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

                        CurrPage.Close();

                    end;
                }
                action("Attached Documents")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        RecRef: RecordRef;
                        DocumentAttachment: Page "Document Attachment Details";
                    begin

                        RecRef.GETTABLE(Rec);
                        DocumentAttachment.OpenForRecRef(RecRef);
                        DocumentAttachment.RUN();
                    end;
                }

            }
            group(Attachments)
            {
                action(DocAttach)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;

                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal();
                    end;
                }
            }
        }
    }

    var
        edt: Boolean;

    trigger OnOpenPage()
    begin
        Editability();
    end;

    procedure Editability()
    begin
        edt := true;
        if rec.Status = Rec.Status::Submitted then
            edt := false;

    end;
}