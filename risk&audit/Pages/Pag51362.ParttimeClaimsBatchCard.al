page 52098 "Parttime Claims Batch Card"
{
    Caption = 'Parttime Claims Batch Card';
    PageType = Card;
    SourceTable = "Parttime Claims Batch";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the batch.';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the batch.';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the semester for the claims batch.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount of the batch.';
                    Editable = false;
                }
                field("Claims Count"; Rec."Claims Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of claims in the batch.';
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the batch.';
                    Editable = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the batch was created.';
                    Editable = false;
                }
                field("Pv Generated"; Rec."Pv Generated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether a PV has been generated for this batch.';
                    Editable = false;
                }
            }
            part(ParttimeClaims; "Parttime Claims Batch Subform")
            {
                ApplicationArea = All;
                Caption = 'Parttime Claims';
                SubPageLink = "Batch No." = field("No.");
                UpdatePropagation = Both;
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = true;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SelectClaims)
            {
                ApplicationArea = All;
                Caption = 'Select Claims';
                Image = SelectEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Select parttime claims for this batch based on semester.';

                trigger OnAction()
                var
                    ParttimeClaimHeader: Record "Parttime Claim Header";
                    ClaimList: Page "Parttime Claim List";
                    ClaimFilter: Text;
                    BatchClaimLines: Record "Parttime Claim Header";
                begin
                    if Rec.Semester = '' then
                        Error('Please specify the Semester before selecting claims.');
                    ParttimeClaimHeader.Reset();
                    ParttimeClaimHeader.SetRange(semester, Rec.Semester);
                    ParttimeClaimHeader.SetRange(Status, ParttimeClaimHeader.Status::Approved);
                    ParttimeClaimHeader.SetRange(Posted, false);
                    ClaimList.SetTableView(ParttimeClaimHeader);
                    ClaimList.LookupMode(true);
                    if ClaimList.RunModal() = Action::LookupOK then begin
                        ClaimFilter := ClaimList.GetSelectionFilter();
                        BatchClaimLines.Reset();
                        BatchClaimLines.SetRange("No.", ClaimFilter);
                        if BatchClaimLines.FindSet() then begin
                            repeat
                                BatchClaimLines.CalcFields("Payment Amount");
                                Rec."Total Amount" += BatchClaimLines."Payment Amount";
                                BatchClaimLines."Batch No." := Rec."No.";
                                BatchClaimLines.Modify();
                            until BatchClaimLines.Next() = 0;
                        end;
                    end;
                end;
            }

            action(GeneratePV)
            {
                ApplicationArea = All;
                Caption = 'Generate PV';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Generate payment voucher for this batch.';

                trigger OnAction()
                var
                    PartTimerMgt: Codeunit "PartTimer Management";
                begin
                    if Confirm('Do you want to generate a payment voucher for this batch?') then begin
                        PartTimerMgt.CreateBatchPaymentVoucher(Rec."No.");
                    end;
                end;
            }
            
            action(GenerateInvoices)
            {
                ApplicationArea = All;
                Caption = 'Generate Purchase Invoices';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Generate purchase invoices for all vendors in this batch.';

                trigger OnAction()
                var
                    PartTimerMgt: Codeunit "PartTimer Management";
                begin
                    if Confirm('Do you want to generate purchase invoices for this batch? This will create a separate invoice for each part-timer vendor.') then begin
                        PartTimerMgt.CreateBatchPurchaseInvoices(Rec."No.");
                    end;
                end;
            }
            
            action(ViewBatchInvoices)
            {
                ApplicationArea = All;
                Caption = 'View Batch Invoices';
                Image = ViewDocumentLine;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'View all purchase invoices created for this batch.';

                trigger OnAction()
                var
                    PartTimeInvoiceBatch: Record "PartTime Invoice Batch";
                begin
                    PartTimeInvoiceBatch.Reset();
                    PartTimeInvoiceBatch.SetRange("Batch No.", Rec."No.");
                    if PartTimeInvoiceBatch.FindFirst() then
                        Page.RunModal(Page::"PartTime Invoice Batch List", PartTimeInvoiceBatch)
                    else
                        Message('No invoices have been generated for this batch yet.');
                end;
            }
        }
    }

}
