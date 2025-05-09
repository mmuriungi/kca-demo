page 53100 "Medical Claims Batch List"
{
    ApplicationArea = All;
    Caption = 'Medical Claims Batch List';
    PageType = List;
    SourceTable = "Medical Claims Batch";
    UsageCategory = Lists;
    Editable = true;
    CardPageId = "Medical Claims Batch Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the batch number';
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
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor name';
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the batch';
                }
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
                    FieldRef[1] := recref.Field(MedClaims.FieldNo("Claim Date"));
                    FieldRef[2] := recref.Field(MedClaims.FieldNo("Claim Type"));
                    FieldRef[3] := recref.Field(MedClaims.FieldNo("Member No"));
                    FieldRef[4] := recref.Field(MedClaims.FieldNo("Member Names"));
                    FieldRef[5] := recref.Field(MedClaims.FieldNo("Scheme No"));
                    FieldRef[6] := recref.Field(MedClaims.FieldNo("Scheme Name"));
                    FieldRef[7] := recref.Field(MedClaims.FieldNo("Facility Attended"));
                    FieldRef[8] := recref.Field(MedClaims.FieldNo("Date of Service"));
                    FieldRef[9] := recref.Field(MedClaims.FieldNo("Claim Currency Code"));
                    FieldRef[10] := recref.Field(MedClaims.FieldNo("Claim Amount"));
                    FieldRef[11] := recref.Field(MedClaims.FieldNo("Comments"));
                    FieldRef[12] := recref.Field(MedClaims.FieldNo("Document Ref"));
                    FieldRef[13] := recref.Field(MedClaims.FieldNo("Dependants"));
                    FieldRef[14] := recref.Field(MedClaims.FieldNo("Patient Name"));
                    FieldRef[15] := recref.Field(MedClaims.FieldNo("Patient Type"));
                    FieldRef[16] := recref.Field(MedClaims.FieldNo("Scheme Currency Code"));
                    FieldRef[17] := recref.Field(MedClaims.FieldNo("Scheme Amount Charged"));
                    FileName := 'Medical Claims.xlsx';
                    csv.ExportExcelFile(FileName, recref, FieldRef, 17, ExcelBuffer, 'Medical Claims', 1);
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
                begin
                    recref[1].GetTable(MedClaims);
                    ArrSheetName[1] := 'Medical Claims';
                    fieldlist.Add(MedClaims.FieldNo("Claim Date"));
                    fieldlist.Add(MedClaims.FieldNo("Member No"));
                    fieldlist.Add(MedClaims.FieldNo("Member Names"));
                    fieldlist.Add(MedClaims.FieldNo("Scheme No"));
                    fieldlist.Add(MedClaims.FieldNo("Scheme Name"));
                    fieldlist.Add(MedClaims.FieldNo("Facility Attended"));
                    fieldlist.Add(MedClaims.FieldNo("Date of Service"));
                    fieldlist.Add(MedClaims.FieldNo("Claim Currency Code"));
                    fieldlist.Add(MedClaims.FieldNo("Claim Amount"));
                    fieldlist.Add(MedClaims.FieldNo("Comments"));
                    fieldlist.Add(MedClaims.FieldNo("Document Ref"));
                    fieldlist.Add(MedClaims.FieldNo("Dependants"));
                    fieldlist.Add(MedClaims.FieldNo("Patient Name"));
                    fieldlist.Add(MedClaims.FieldNo("Patient Type"));
                    fieldlist.Add(MedClaims.FieldNo("Scheme Currency Code"));
                    fieldlist.Add(MedClaims.FieldNo("Scheme Amount Charged"));
                    Fields.Add(1, fieldlist);
                    csv.importFromExcel(recref, ArrSheetName, 1, Fields, MedClaims."Claim No", MedClaims.FieldNo("Claim No"));
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

                trigger OnAction()
                var
                begin
                    if not Confirm('Do you want to generate an invoice for batch %1?', false, Rec."Batch No.") then
                        exit;
                end;
            }

            action(PostInvoice)
            {
                ApplicationArea = All;
                Caption = 'Post Invoice';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Post the purchase invoice for this batch';
                Enabled = Rec."Invoice Generated" and (Rec.Status = Rec.Status::Open);

                trigger OnAction()
                var
                begin
                    if not Confirm('Do you want to post invoice %1?', false, Rec."Invoice No.") then
                        exit;
                end;
            }

            action(ApproveBatch)
            {
                ApplicationArea = All;
                Caption = 'Approve Batch';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Approve this medical claims batch';
                Enabled = Rec.Status = Rec.Status::Open;

                trigger OnAction()
                begin
                    if Confirm('Do you want to approve batch %1?', false, Rec."Batch No.") then begin
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify();
                        Message('Batch %1 has been approved.', Rec."Batch No.");
                    end;
                end;
            }
        }
    }
}
