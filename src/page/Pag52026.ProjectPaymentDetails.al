page 52026 "Project Payment Details"
{
    PageType = ListPart;
    SourceTable = "Project Payment Lines";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Payment Date"; Rec."Payment Date")
                {
                    Editable = true;
                }
                field("Payment Amount"; Rec."Payment Amount")
                {
                    ApplicationArea = All;

                }
                field("Invoice Generated"; Rec."Invoice Generated")
                {
                    ApplicationArea = All;

                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;

                }


            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("Generate Invoice")
            {
                ApplicationArea = All;
                Image = "Invoicing-Payment";
                trigger OnAction();
                var
                    InvoiceNo: Code[25];
                    LineNo: Integer;
                begin
                    if not Rec."Invoice Generated" then
                        if not Confirm('Do You wish to create a purchase invoice for the selected payment') then
                            exit else begin
                            PurchSetup.Get();
                            PurchSetup.TestField(PurchSetup."Invoice Nos.");
                            InvoiceNo := CUNoseriesMgmt.GetNextNo(PurchSetup."Invoice Nos.", 0D, true);
                            pheader.Reset();
                            pheader.SetRange(pheader."No.", Rec."Header No");
                            if pheader.FindFirst() then begin
                                ObjPurchaseHeader.Init;
                                ObjPurchaseHeader."No." := InvoiceNo;
                                ObjPurchaseHeader."Document Type" := ObjPurchaseHeader."Document Type"::Invoice;
                                ObjPurchaseHeader."Buy-from Vendor No." := pheader."Vendor No";
                                ObjPurchaseHeader.Validate("Buy-from Vendor No.");
                                ObjPurchaseHeader."Document Date" := WorkDate();
                                ObjPurchaseHeader."Posting Date" := WorkDate();
                                ObjPurchaseHeader."Due Date" := Rec."Payment Date";
                                ObjPurchaseHeader."User ID" := UserId;
                                ObjPurchaseHeader."Expected Receipt Date" := Rec."Payment Date";
                                ObjPurchaseHeader.Status := ObjPurchaseHeader.Status::Open;
                                ObjPurchaseHeader.Insert(true);

                                ObjPurchaseLines.Reset();
                                if ObjPurchaseLines.find('+') then
                                    LineNo := ObjPurchaseLines."Line No." + 1
                                else
                                    LineNo := 1;

                                ObjPurchaseLines.Init;
                                ObjPurchaseLines."Line No." := LineNo;
                                ObjPurchaseLines."Document No." := InvoiceNo;
                                ObjPurchaseLines."Document Type" := ObjPurchaseLines."Document Type"::Invoice;
                                ObjPurchaseLines."Expense Code" := pheader."Expense Code";
                                ObjPurchaseLines.validate(ObjPurchaseLines."Expense Code");
                                ObjPurchaseLines.Amount := Rec."Payment Amount";
                                ObjPurchaseLines.Quantity := 1;
                                ObjPurchaseLines."Qty. Assigned" := 1;
                                ObjPurchaseLines."Direct Unit Cost" := Rec."Payment Amount";
                                ObjPurchaseLines.validate(ObjPurchaseLines."Direct Unit Cost");
                                ObjPurchaseLines."Unit Cost" := Rec."Payment Amount";
                                ObjPurchaseLines.Validate(ObjPurchaseLines."Unit Cost");
                                ObjPurchaseLines.validate(ObjPurchaseLines.Amount);
                                objpurchaselines.validate(ObjPurchaseLines.Quantity);
                                ObjPurchaseLines.Insert(true);

                                Rec."Invoice Generated" := true;
                                Rec."Invoice No." := InvoiceNo;
                                Rec.Modify();


                                if not Confirm('Invoice Generate successfully! Do you want to view the invoice?') then
                                    exit else
                                    ObjPurchaseHeader.Reset();
                                ObjPurchaseHeader.SetRange(ObjPurchaseHeader."No.", Rec."Invoice No.");
                                if ObjPurchaseHeader.FindFirst() then
                                    Page.Run(Page::"Purchase Invoice", ObjPurchaseHeader);


                            end;

                        end;
                end;
            }
            action("View Invoice")
            {
                ApplicationArea = All;
                Image = Invoice;
                Visible = Rec."Invoice Generated";
                trigger OnAction()
                begin
                    ObjPurchaseHeader.Reset();
                    ObjPurchaseHeader.SetRange(ObjPurchaseHeader."No.", Rec."Invoice No.");
                    if ObjPurchaseHeader.FindFirst() then
                        Page.Run(Page::"Purchase Invoice", ObjPurchaseHeader);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin

    end;

    trigger OnInsertRecord(BelowXRec: Boolean): Boolean
    var
        myInt: Integer;
    begin

    end;

    trigger OnNewRecord(BelowXRec: Boolean)
    var
        myInt: Integer;
    begin

    end;

    var
        FieldsEditable: Boolean;
        Usersetup: Record "User Setup";
        pheader: Record "Project Header";
        ObjPurchaseHeader: record "Purchase Header";
        CUNoseriesMgmt: codeunit NoSeriesManagement;
        PurchSetup: Record "Purchases & Payables Setup";
        ObjPurchaseLines: record "Purchase Line";
        ExpenseCodes: record "Expense Code";

}