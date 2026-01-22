page 51420 "FLT-Fuel Pymnt Batch"
{
    PageType = Card;
    SourceTable = "FLT-Fuel Payment Batch";
    Caption = 'FLT-Fuel Pymnt Batch';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Batch No"; Rec."Batch No")
                {
                    ApplicationArea = All;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                }
                field("Created by"; Rec."Created by")
                {
                    ApplicationArea = All;
                }
                field("Vendor No"; Rec."Vendor No")
                {
                    ApplicationArea = All;
                }
                field("Date Closed"; Rec."Date Closed")
                {
                    ApplicationArea = All;
                    visible = false;
                }
                field("Closed By"; Rec."Closed By")
                {
                    ApplicationArea = All;
                    visible = false;
                }
                field("Total Payable"; Rec."Total Payable")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = All;
                }
                field(DTo; Rec.DTo)
                {
                    ApplicationArea = All;
                }
                field(Invoiced; Rec.Invoiced)
                {
                    ApplicationArea = All;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Invoiced By"; Rec."Invoiced By")
                {
                    ApplicationArea = All;
                }
            }
            part(Line; "FLT-Fuel Lines")
            {
                Caption = 'Lines';
                Editable = true;
                SubPageLink = "Payment Batch No" = FIELD("Batch No");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Post Payment")
            {
                ApplicationArea = All;
            }
            action("Send to Finance")
            {
                ApplicationArea = All;
                Caption = 'Send to Finance';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                enabled = not Rec.Closed and not Rec.Invoiced;

                trigger OnAction()
                var
                    PurchHeader: Record "Purchase Header";
                    PurchLine: Record "Purchase Line";
                    FuelBatchLines: Record "FLT-Fuel Pynts Batch Lines";
                    FuelReq: Record "FLT-Fuel & Maintenance Req.";
                    FleetSetup: Record "FLT-Fleet Mgt Setup";
                    LineNo: Integer;
                    TotalAmount: Decimal;
                    NoSeriesMgt: Codeunit NoSeriesManagement;
                    PurchSetup: Record "Purchases & Payables Setup";
                begin
                    // Validate batch is ready
                    Rec.TestField("Vendor No");
                    Rec.TestField(From);
                    Rec.TestField(DTo);
                    if Rec.Invoiced then
                        Error('This batch has already been invoiced.');
                    if Rec.Closed then
                        Error('This batch is closed and cannot be sent to finance.');

                    // Check if there are lines in the batch
                    FuelBatchLines.Reset();
                    FuelBatchLines.SetRange("Payment Batch No", Rec."Batch No");
                    if not FuelBatchLines.FindFirst() then
                        Error('There are no fuel requisitions in this batch.');

                    // Calculate total amount
                    FuelBatchLines.CalcSums("Value of Fuel");
                    TotalAmount := FuelBatchLines."Value of Fuel";

                    if TotalAmount = 0 then
                        Error('Total amount cannot be zero.');

                    // Create Purchase Invoice Header
                    PurchHeader.Init();
                    PurchHeader."Document Type" := PurchHeader."Document Type"::Invoice;

                    // Get invoice number from number series
                    PurchSetup.Get();
                    if PurchSetup."Invoice Nos." <> '' then
                        PurchHeader."No." := NoSeriesMgt.GetNextNo(PurchSetup."Invoice Nos.", WorkDate(), true)
                    else
                        PurchHeader."No." := '';



                    // Set vendor and other header information
                    PurchHeader.Validate("Buy-from Vendor No.", Rec."Vendor No");
                    PurchHeader."Posting Date" := WorkDate();
                    PurchHeader."Document Date" := WorkDate();
                    PurchHeader."Batch No." := Rec."Batch No";
                    PurchHeader."Due Date" := CalcDate('<1M>', WorkDate());
                    PurchHeader."Posting Description" := 'Fuel Payment Batch ' + Rec."Batch No";
                    PurchHeader.Insert(true);

                    // Create Purchase Invoice Lines
                    LineNo := 10000;
                    FuelBatchLines.Reset();
                    FuelBatchLines.SetRange("Payment Batch No", Rec."Batch No");
                    if FuelBatchLines.FindSet() then begin
                        repeat
                            PurchLine.Init();
                            PurchLine."Document Type" := PurchHeader."Document Type";
                            PurchLine."Document No." := PurchHeader."No.";
                            PurchLine."Line No." := LineNo;
                            PurchLine.Type := PurchLine.Type::"G/L Account";

                            // Get the fuel expense G/L Account from Fleet Management Setup
                            FleetSetup.Get();
                            FleetSetup.TestField("Fuel Expense Account");
                            PurchLine.Validate("No.", FleetSetup."Fuel Expense Account");
                            PurchLine.Description := StrSubstNo('Fuel for %1 - Req. %2', FuelBatchLines."Vehicle Reg No", FuelBatchLines."Requisition No");
                            PurchLine.Validate(Quantity, 1);
                            PurchLine.Validate("Direct Unit Cost", FuelBatchLines."Value of Fuel");
                            PurchLine.Insert(true);

                            // Update the batch line with invoice information
                            FuelBatchLines.Invoiced := true;
                            FuelBatchLines."Invoice No." := PurchHeader."No.";
                            FuelBatchLines."Invoiced By" := UserId;
                            FuelBatchLines.Modify();

                            // Update the original fuel requisition
                            if FuelReq.Get(FuelBatchLines."Requisition No") then begin
                                FuelReq."Vendor Invoice No" := PurchHeader."No.";
                                FuelReq.Modify();
                            end;

                            LineNo += 10000;
                        until FuelBatchLines.Next() = 0;
                    end;

                    // Update the batch header
                    Rec.Invoiced := true;
                    Rec."Invoice No." := PurchHeader."No.";
                    Rec."Invoiced By" := UserId;
                    Rec.Modify();

                    Message('Purchase Invoice %1 has been created successfully for %2 fuel requisition(s) with a total amount of %3.',
                            PurchHeader."No.", FuelBatchLines.Count, TotalAmount);

                    // Open the created invoice
                    PAGE.Run(PAGE::"Purchase Invoice", PurchHeader);
                end;
            }
        }
    }
}

