page 53101 "Medical Claims Batch Card"
{
    ApplicationArea = All;
    Caption = 'Medical Claims Batch Card';
    PageType = Card;
    SourceTable = "Medical Claims Batch";

   

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the batch number';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the batch';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor number';
                    ShowMandatory = true;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor name';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Global Dimension 1 Code';
                    ShowMandatory = true;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Global Dimension 2 Code';
                    ShowMandatory = true;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shortcut Dimension 3 Code';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the responsibility center code';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the batch was created';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the batch';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount of claims in this batch';
                }
                field("No. of Claims"; Rec."No. of Claims")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of claims in this batch';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the batch';
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the invoice number';
                }
                field("Posted Invoice No."; Rec."Posted Invoice No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posted invoice number';
                }
            }
            part(MedicalClaims; "Medical Claims Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Batch No." = field("Batch No.");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(ViewClaims)
            {
                ApplicationArea = All;
                Caption = 'View Claims';
                Image = ViewDocumentLine;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'View the medical claims in this batch';

                trigger OnAction()
                var
                    MedicalClaim: Record "HRM-Medical Claims";
                begin
                    MedicalClaim.SetRange("Batch No.", Rec."Batch No.");
                    Page.RunModal(Page::"Medical Claims List", MedicalClaim);
                end;
            }

            action(ViewInvoice)
            {
                ApplicationArea = All;
                Caption = 'View Invoice';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'View the purchase invoice';
                Enabled = Rec."Invoice Generated";

                trigger OnAction()
                var
                    PurchInvHeader: Record "Purchase Header";
                begin
                    PurchInvHeader.SetRange("Document Type", PurchInvHeader."Document Type"::Invoice);
                    PurchInvHeader.SetRange("No.", Rec."Invoice No.");
                    if PurchInvHeader.FindFirst() then
                        Page.RunModal(Page::"Purchase Invoice", PurchInvHeader);
                end;
            }

            action(ViewPostedInvoice)
            {
                ApplicationArea = All;
                Caption = 'View Posted Invoice';
                Image = PostedOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'View the posted purchase invoice';
                Enabled = Rec.Status = Rec.Status::Posted;

                trigger OnAction()
                var
                    PurchInvHeader: Record "Purch. Inv. Header";
                begin
                    PurchInvHeader.SetRange("No.", Rec."Posted Invoice No.");
                    if PurchInvHeader.FindFirst() then
                        Page.RunModal(Page::"Posted Purchase Invoice", PurchInvHeader);
                end;
            }
        }

        area(Processing)
        {
            action("Export Excel")
            {
                Caption = 'Export Batches';
                Image = ExportToExcel;
                trigger OnAction()
                var
                    csv: Codeunit "Csv Handler";
                    recref: RecordRef;
                    FieldRef: array[20] of FieldRef;
                    FileName: Text[250];
                    ExcelBuffer: Record "Excel Buffer" temporary;
                    FieldRefLength: Integer;
                    MedClaims: Record "HRM-Medical Claims";
                begin
                    MedClaims.Reset();
                    MedClaims.SetRange("Batch No.", Rec."Batch No.");
                    recref.GetTable(MedClaims);
                    FieldRef[1] := recref.Field(MedClaims.FieldNo("Date of Service"));
                    FieldRef[2] := recref.Field(MedClaims.FieldNo("Member No"));
                    FieldRef[3] := recref.Field(MedClaims.FieldNo("Member Names"));
                    FieldRef[4] := recref.Field(MedClaims.FieldNo("Claim Amount"));
                    FieldRef[5] := recref.Field(MedClaims.FieldNo("Patient Type"));
                    FieldRef[6] := recref.Field(MedClaims.FieldNo("Dependants"));
                    FieldRef[7] := recref.Field(MedClaims.FieldNo("Claim Type"));
                    FieldRef[8] := recref.Field(MedClaims.FieldNo("Document Ref"));
                    FileName := 'Medical Claims.xlsx';
                    csv.ExportExcelFile(FileName, recref, FieldRef, 8, ExcelBuffer, 'Medical Claims', 1);
                    csv.downloadFromExelBuffer(ExcelBuffer, FileName);
                end;

            }
            action("Import Excel")
            {
                Caption = 'Import Batches';
                Image = ImportExcel;
                trigger OnAction()
                var
                    csv: Codeunit "Csv Handler";
                    recref: array[20] of RecordRef;
                    FieldRef: array[20] of FieldRef;
                    FileName: Text[250];
                    ExcelBuffer: Record "Excel Buffer" temporary;
                    Fields: Dictionary of [Integer, List of [Integer]];
                    ArrSheetName: array[20] of Text;
                    fieldlist: List of [Integer];
                    FieldRefLength: Integer;
                    MedClaims: Record "HRM-Medical Claims";
                    GeneralLedgerSetup: Record "General Ledger Setup";
                    DefaultValues: Dictionary of [Integer, Text];
                begin
                    recref[1].GetTable(MedClaims);
                    ArrSheetName[1] := 'Medical Claims';

                    // Add only the fields that will be imported from Excel
                    fieldlist.Add(MedClaims.FieldNo("Date of Service"));
                    fieldlist.Add(MedClaims.FieldNo("Member No"));
                    fieldlist.Add(MedClaims.FieldNo("Member Names"));
                    fieldlist.Add(MedClaims.FieldNo("Claim Amount"));
                    fieldlist.Add(MedClaims.FieldNo("Patient Type"));
                    fieldlist.Add(MedClaims.FieldNo("Dependants"));
                    fieldlist.Add(MedClaims.FieldNo("Claim Type"));
                    fieldlist.Add(MedClaims.FieldNo("Document Ref"));
                    Fields.Add(1, fieldlist);

                    // Set up default values for fields not in Excel
                    GeneralLedgerSetup.Get();
                    DefaultValues.Add(MedClaims.FieldNo("Batch No."), Rec."Batch No.");
                    DefaultValues.Add(MedClaims.FieldNo("Claim Date"), Format(Today));
                    DefaultValues.Add(MedClaims.FieldNo("Claim Currency Code"), GeneralLedgerSetup."LCY Code");

                    csv.ImportFromExcelWithDefaults(recref, ArrSheetName, 1, Fields, '', 0, DefaultValues);
                end;

            }

            action(GenerateInvoice)
            {
                ApplicationArea = All;
                Caption = 'Generate Invoice';
                Image = NewPurchaseInvoice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Generate a purchase invoice for this batch';
                Enabled = (Rec.Status = Rec.Status::Open) and (not Rec."Invoice Generated") and (Rec."Vendor No." <> '');
                Visible = IsFinanceUser;

                trigger OnAction()
                var
                    ClaimsHandler: Codeunit "Claims Handler";
                begin
                    if not Confirm('Do you want to generate an invoice for batch %1?', false, Rec."Batch No.") then
                        exit;
                    ClaimsHandler.CreatePurchaseInvoiceFromBatch(Rec);
                end;
            }

            // action(PostInvoice)
            // {
            //     ApplicationArea = All;
            //     Caption = 'Post Invoice';
            //     Image = PostOrder;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     ToolTip = 'Post the purchase invoice for this batch';
            //     Enabled = Rec."Invoice Generated" and (Rec.Status = Rec.Status::Open);
            //     Visible = IsFinanceUser;

            //     trigger OnAction()
            //     var
            //         ClaimsHandler: Codeunit "Claims Handler";
            //     begin
            //         if not Confirm('Do you want to post invoice %1?', false, Rec."Invoice No.") then
            //             exit;
            //         ClaimsHandler.PostPurchaseInvoiceFromBatch(Rec);
            //     end;
            // }

            action(SendApprovalRequest)
            {
                ApplicationArea = All;
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Send this medical claims batch for approval';
                Enabled = Rec.Status = Rec.Status::Open;

                trigger OnAction()
                var
                    ApprovalRequest: Codeunit "Approval Workflows V1";
                    Variant: Variant;
                begin
                    Variant := Rec;
                    ApprovalRequest.OnSendDocForApproval(Variant);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = All;
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Cancel the approval request for this medical claims batch';
                Enabled = Rec.Status = Rec.Status::Open;

                trigger OnAction()
                var
                    ApprovalRequest: Codeunit "Approval Workflows V1";
                    Variant: Variant;
                begin
                    Variant := Rec;
                    ApprovalRequest.OnCancelDocApprovalRequest(Variant);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        IsFinanceUser := false;
        if UserSetup.Get(UserId) then
            IsFinanceUser := UserSetup."Finance User";
    end;
     var
        IsFinanceUser: Boolean;
}
