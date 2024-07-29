page 53042 "Cash Sale Post"

{
    Caption = 'Cash Sale Header';
    DeleteAllowed = false;
    ModifyAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order),
                            "Cash Sale Order" = FILTER(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
            }
            group(Control1000000014)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                    ToolTip = 'Specifies the number of the sales document. The field can be filled automatically or manually and can be set up to be invisible.';
                    Visible = false;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                group("Sell-to")
                {
                    Caption = 'Sell-to';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    QuickEntry = false;
                    ToolTip = 'Specifies the date on which the exchange rate applies to prices listed in a foreign currency on the sales order.';
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies when the sales invoice must be paid.';
                    Visible = false;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date that the customer has asked for the order to be delivered.';
                    Visible = false;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the date that you have promised to deliver the order, as a result of the Order Promising function.';
                    Visible = false;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ShowMandatory = ExternalDocNoMandatory;
                    ToolTip = 'Specifies the number that the customer uses in their own system to refer to this sales document.';
                    Visible = false;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the name of the salesperson who is assigned to the customer.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        SalespersonCodeOnAfterValidate;
                    end;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    AccessByPermission = TableData "Responsibility Center" = R;
                    Importance = Additional;
                    ToolTip = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.';
                    Visible = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    Importance = Promoted;
                    QuickEntry = false;
                    ToolTip = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.';
                    Visible = false;
                }
            }
            part(SalesLines; "Cash Sale Subform-Staff")
            {
                ApplicationArea = Basic, Suite;
                Editable = DynamicEditable;
                Enabled = Rec."Sell-to Customer No." <> '';
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
                Visible = false;
            }
            group(Cost)
            {
                Caption = 'Cost';
                Visible = true;
                field("Cash Amount"; Rec."Cash Amount")
                {
                    Caption = 'Cash Amount';

                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Document Amount");
                        if (Rec."Cash Amount" < Rec."Document Amount") then Error('Amount is less than Document Amount!');
                        Rec.Balance := Rec."Cash Amount" - Rec."Document Amount";
                        //Rec.Balance :=Balances;
                        CurrPage.Update;
                    end;
                }
                field(Balance; Rec.Balance)
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Paybill Amount"; Rec."Paybill Amount")
                {
                    Caption = 'Paybill Amount';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Amount Paid"; Rec."Amount Paid")
                {
                    Editable = false;
                    Enabled = false;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.Balance := Rec."Amount Paid" - Rec."Document Amount";
                        CurrPage.Update;
                    end;
                }
                field("Document Amount"; Rec."Document Amount")
                {
                    Editable = false;
                    Enabled = false;

                    trigger OnValidate()
                    begin
                        Rec.Balance := Rec."Amount Paid" - Rec."Document Amount";
                        CurrPage.Update;
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    Enabled = false;
                    ToolTip = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date you expect to ship items on the sales document.';
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Enabled = false;
                    Importance = Additional;
                    ToolTip = 'Specifies the date on which you created the sales document.';
                    Visible = false;
                }
            }
            group("Shipping and Billing")
            {
                Caption = 'Shipping and Billing';
                Visible = true;
                group(Control1000000022)
                {
                    ShowCaption = false;
                    group(Control1000000021)
                    {
                        ShowCaption = false;
                        field(ShippingOptions; ShipToOptions)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Ship-to';
                            ToolTip = 'Specifies the address that the products on the sales document are shipped to. Default (Sell-to Address): The same as the customer''s sell-to address. Alternate Ship-to Address: One of the customer''s alternate ship-to addresses. Custom Address: Any ship-to address that you specify in the fields below.';
                            Visible = false;

                            trigger OnValidate()
                            var
                                ShipToAddress: Record "Ship-to Address";
                                ShipToAddressList: Page "Ship-to Address List";
                            begin
                                case ShipToOptions of
                                    ShipToOptions::"Default (Sell-to Address)":
                                        begin
                                            Rec.Validate("Ship-to Code", '');
                                            Rec.CopySellToAddressToShipToAddress;
                                        end;
                                    ShipToOptions::"Alternate Shipping Address":
                                        begin
                                            ShipToAddress.SetRange("Customer No.", Rec."Sell-to Customer No.");
                                            ShipToAddressList.LookupMode := true;
                                            ShipToAddressList.SetTableView(ShipToAddress);

                                            if ShipToAddressList.RunModal = ACTION::LookupOK then begin
                                                ShipToAddressList.GetRecord(ShipToAddress);
                                                Rec.Validate("Ship-to Code", ShipToAddress.Code);
                                            end else
                                                ShipToOptions := ShipToOptions::"Custom Address";
                                        end;
                                    ShipToOptions::"Custom Address":
                                        Rec.Validate("Ship-to Code", '');
                                end;
                            end;
                        }
                    }
                    group("Shipment Method")
                    {
                        Caption = 'Shipment Method';
                        Visible = true;
                        field("Shipping No. Series"; Rec."Shipping No. Series")
                        {
                        }
                        field("Posting No. Series"; Rec."Posting No. Series")
                        {
                        }
                    }
                }
                group(Control1000000016)
                {
                    ShowCaption = false;
                    Visible = false;
                    field(BillToOptions; BillToOptions)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bill-to';
                        ToolTip = 'Specifies the customer that the sales invoice will be sent to. Default (Customer): The same as the customer on the sales invoice. Another Customer: Any customer that you specify in the fields below.';

                        trigger OnValidate()
                        begin
                            if BillToOptions = BillToOptions::"Default (Customer)" then
                                Rec.Validate("Bill-to Customer No.", Rec."Sell-to Customer No.");
                        end;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Postng)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    var
                        DepositHeader: Record "Deposit Header";
                        DepositLines: Record "Gen. Journal Line";
                        SalesShipmentHeader: Record "Sales Shipment Header";
                        SalesHeader: Record "Sales Header";
                        SalesLine: Record "Sales Line";
                        TotalLineAmount: Decimal;
                        LineNo: Integer;
                    begin
                        //Rec.Status:=Status::Released;
                        Clear(TotalLineAmount);
                        Rec.CalcFields("Document Amount");
                        //IF Rec."Amount Paid"<>Rec."Document Amount" THEN ERROR('Total Amount Paid should be equal to: '+FORMAT(Rec."Document Amount"));
                        //Rec.TESTFIELD(Rec."Bal. Account No.");

                        if Location.Get(Rec."Location Code") then begin
                        end;

                        if Confirm('Post?', true) = false then exit;

                        // Get Document Number Here
                        //Get Amount Paid and Change Too
                        // Create a Depisit Entry
                        SalesLine.Reset;
                        SalesLine.SetRange(SalesLine."Document No.", Rec."No.");
                        //salesline.SETFILTER(SalesLine.Amount,'=%1',0);
                        //IF salesline.FIND('-') THEN ERROR('All Line must have quantity');
                        if SalesLine.Find('-') then begin
                            repeat
                            begin
                                TotalLineAmount := TotalLineAmount + SalesLine.Amount;
                            end;
                            until SalesLine.Next = 0;

                            if TotalLineAmount > 0 then begin
                                if not FINCashOfficeUserTemplate.Get(UserId) then Error('Access to receipting denied!');
                                FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Cash Sale Bank");
                                FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Sales Inv. Nos.");
                                FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Cash Receipt No. Series");
                                FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Default Direct Sale Customer");
                                FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Sales External Doc. Nos");
                                FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Default Direct Sales Location");
                                FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Sales Item Category");
                                FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Cash Sale Deposit Nos.");
                                FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Petty Cash Template");
                                FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Petty Cash Batch");
                                Rec.CalcFields("Document Amount");
                                // Post Cash Amount


                                if Rec."Document Amount" > 0 then begin
                                    // Insert Lines
                                    DepositLines.Reset;
                                    DepositLines.SetRange(DepositLines."Journal Template Name", FINCashOfficeUserTemplate."Petty Cash Template");
                                    DepositLines.SetRange(DepositLines."Journal Batch Name", FINCashOfficeUserTemplate."Petty Cash Batch");
                                    if DepositLines.Find('-') then DepositLines.DeleteAll;
                                    LineNo := 10000;
                                    DepositLines.Init;
                                    DepositLines."Journal Template Name" := FINCashOfficeUserTemplate."Petty Cash Template";
                                    DepositLines."Journal Batch Name" := FINCashOfficeUserTemplate."Petty Cash Batch";
                                    DepositLines."Line No." := LineNo + 1000;
                                    DepositLines."Account Type" := DepositLines."Account Type"::Customer;
                                    DepositLines."Account No." := FINCashOfficeUserTemplate."Default Direct Sale Customer";
                                    DepositLines."Posting Date" := Rec."Posting Date";
                                    DepositLines."Document Type" := DepositLines."Document Type"::Payment;
                                    DepositLines."Document No." := NoSeriesMgt.GetNextNo(FINCashOfficeUserTemplate."Direct Cash Sale Deposit Nos.", Today, true);
                                    ;
                                    DepositLines.Description := 'POS Cash Sales Receipt No.';
                                    DepositLines."Bal. Account Type" := DepositLines."Bal. Account Type"::"Bank Account";
                                    //IF Location."Direct Cash Sale Bank"<>'' THEN BEGIN
                                    //DepositLines."Bal. Account No.":=Location."Direct Cash Sale Bank";
                                    //END ELSE BEGIN
                                    FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Cash Sale Bank");
                                    DepositLines."Bal. Account No." := FINCashOfficeUserTemplate."Direct Cash Sale Bank";
                                    //  END;
                                    DepositLines."Credit Amount" := Rec."Document Amount";//TotalLineAmount;
                                    DepositLines.Validate(DepositLines."Credit Amount");
                                    DepositLines."Applies-to ID" := DepositHeader."No.";
                                    DepositLines."Allow Application" := true;
                                    DepositLines."Document Date" := Today;
                                    DepositLines."External Document No." := DepositLines."Document No.";
                                    DepositLines."User ID" := UserId;
                                    DepositLines."Applied Automatically" := true;
                                    DepositLines."Shortcut Dimension 1 Code" := FINCashOfficeUserTemplate."Shortcut Dimension 1 Code";
                                    DepositLines."Shortcut Dimension 2 Code" := FINCashOfficeUserTemplate."Shortcut Dimension 2 Code";

                                    DepositLines.Insert(true);

                                    DepositHeader.Reset;
                                    if DepositHeader.Find('-') then DepositHeader.DeleteAll;
                                    DepositHeader.Init;
                                    DepositHeader."No." := DepositLines."Document No.";
                                    //IF Location."Direct Cash Sale Bank"<>'' THEN BEGIN
                                    //DepositHeader."Bank Account No.":=Location."Direct Cash Sale Bank";
                                    //END ELSE BEGIN
                                    DepositHeader."Bank Account No." := FINCashOfficeUserTemplate."Direct Cash Sale Bank";
                                    DepositHeader.Validate(DepositHeader."Bank Account No.");
                                    //END;
                                    DepositHeader."Posting Date" := Today;
                                    DepositHeader.Validate(DepositHeader."Posting Date");
                                    DepositHeader."Total Deposit Amount" := Rec."Document Amount";
                                    ;
                                    //DepositHeader."Total Deposit Amount"
                                    DepositHeader."Document Date" := Today;
                                    //DepositHeader."Bank Acc. Posting Group":=
                                    DepositHeader."No. Series" := FINCashOfficeUserTemplate."Direct Cash Sale Deposit Nos.";
                                    DepositHeader."Posting Description" := 'POS Cash Sales Receipt No.';
                                    DepositHeader."Journal Template Name" := FINCashOfficeUserTemplate."Petty Cash Template";
                                    DepositHeader."Journal Batch Name" := FINCashOfficeUserTemplate."Petty Cash Batch";
                                    DepositHeader."Direct Sale" := true;
                                    //DepositHeader.Comment:='Cash Sale '+DepositHeader."No.";
                                    DepositHeader.Insert(true);

                                    Rec."Deposit Slip No." := DepositHeader."No.";
                                    Rec."Deposit No." := DepositHeader."No.";
                                    Rec.Modify;

                                    //Post(CODEUNIT::"Sales-Post (Yes/No)",NavigateAfterPost::"Posted Document");
                                    //Post Deposit Into the Petty Cash Account
                                end;// End Cash Posting

                                //Post Paybill Amounts Here
                                if Rec."Paybill Amount" > 0 then begin
                                    // Insert Lines
                                    DepositLines.Reset;
                                    DepositLines.SetRange(DepositLines."Journal Template Name", FINCashOfficeUserTemplate."Petty Cash Template");
                                    DepositLines.SetRange(DepositLines."Journal Batch Name", FINCashOfficeUserTemplate."Petty Cash Batch");
                                    if DepositLines.Find('-') then DepositLines.DeleteAll;
                                    LineNo := 10000;
                                    DepositLines.Init;
                                    DepositLines."Journal Template Name" := FINCashOfficeUserTemplate."Petty Cash Template";
                                    DepositLines."Journal Batch Name" := FINCashOfficeUserTemplate."Petty Cash Batch";
                                    DepositLines."Line No." := LineNo + 1000;
                                    DepositLines."Account Type" := DepositLines."Account Type"::Customer;
                                    DepositLines."Account No." := FINCashOfficeUserTemplate."Default Direct Sale Customer";
                                    DepositLines."Posting Date" := Rec."Posting Date";
                                    DepositLines."Document Type" := DepositLines."Document Type"::Payment;
                                    DepositLines."Document No." := NoSeriesMgt.GetNextNo(FINCashOfficeUserTemplate."Direct Cash Sale Deposit Nos.", Today, true);
                                    ;
                                    DepositLines.Description := 'POS Cash Sales Receipt No.';
                                    DepositLines."Bal. Account Type" := DepositLines."Bal. Account Type"::"Bank Account";
                                    //IF Location."Direct  Cash Sale Paybill"<>'' THEN BEGIN
                                    //DepositLines."Bal. Account No.":=Location."Direct  Cash Sale Paybill";
                                    //END ELSE BEGIN
                                    FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct  Cash Sale Paybill");
                                    DepositLines."Bal. Account No." := FINCashOfficeUserTemplate."Direct  Cash Sale Paybill";
                                    //END;
                                    DepositLines."Credit Amount" := Rec."Paybill Amount";//TotalLineAmount;
                                    DepositLines.Validate(DepositLines."Credit Amount");
                                    DepositLines."Applies-to ID" := DepositHeader."No.";
                                    DepositLines."Allow Application" := true;
                                    DepositLines."Document Date" := Today;
                                    DepositLines."External Document No." := DepositLines."Document No.";
                                    DepositLines."User ID" := UserId;
                                    DepositLines."Applied Automatically" := true;
                                    DepositLines."Shortcut Dimension 1 Code" := FINCashOfficeUserTemplate."Shortcut Dimension 1 Code";
                                    DepositLines."Shortcut Dimension 2 Code" := FINCashOfficeUserTemplate."Shortcut Dimension 2 Code";

                                    DepositLines.Insert(true);

                                    DepositHeader.Reset;
                                    if DepositHeader.Find('-') then DepositHeader.DeleteAll;
                                    DepositHeader.Init;
                                    DepositHeader."No." := DepositLines."Document No.";
                                    //IF Location."Direct  Cash Sale Paybill"<>'' THEN BEGIN
                                    //DepositLines."Bal. Account No.":=Location."Direct  Cash Sale Paybill";
                                    // DepositHeader.VALIDATE(DepositHeader."Bank Account No.");
                                    //END ELSE BEGIN
                                    DepositHeader."Bank Account No." := FINCashOfficeUserTemplate."Direct  Cash Sale Paybill";
                                    DepositHeader.Validate(DepositHeader."Bank Account No.");
                                    //END;
                                    DepositHeader."Posting Date" := Today;
                                    DepositHeader.Validate(DepositHeader."Posting Date");
                                    DepositHeader."Total Deposit Amount" := Rec."Paybill Amount";
                                    ;
                                    //DepositHeader."Total Deposit Amount"
                                    DepositHeader."Document Date" := Today;
                                    //DepositHeader."Bank Acc. Posting Group":=
                                    DepositHeader."No. Series" := FINCashOfficeUserTemplate."Direct Cash Sale Deposit Nos.";
                                    DepositHeader."Posting Description" := 'POS Cash Sales Receipt No.';
                                    DepositHeader."Journal Template Name" := FINCashOfficeUserTemplate."Petty Cash Template";
                                    DepositHeader."Journal Batch Name" := FINCashOfficeUserTemplate."Petty Cash Batch";
                                    DepositHeader."Direct Sale" := true;
                                    //DepositHeader.Comment:='Cash Sale '+DepositHeader."No.";
                                    DepositHeader.Insert(true);

                                    Rec."Deposit Slip No." := DepositHeader."No.";
                                    Rec."Deposit No." := DepositHeader."No.";
                                    Rec.Modify;

                                    //Post(CODEUNIT::"Sales-Post (Yes/No)",NavigateAfterPost::"Posted Document");
                                    //Post Deposit Into the Petty Cash Account
                                end;

                                Post(CODEUNIT::"Sales-Post (Yes/No)", NavigateAfterPost::"Posted Document");
                                CODEUNIT.Run(CODEUNIT::"Deposit-Post (Yes/No)", DepositHeader);
                                //CODEUNIT.RUN(CODEUNIT::"Deposit-Post (Yes/No)",DepositHeader);
                                //Rec.Status:=Rec.Status::Released;
                                //Rec.MODIFY;
                                // Print Receipt
                                SalesShipmentHeader.Reset;
                                SalesShipmentHeader.SetRange(SalesShipmentHeader."Order No.", xRec."No.");
                                if SalesShipmentHeader.Find('-') then begin
                                    // Load and Print Receipt Here
                                    REPORT.Run(Report::"Direct Sales Receipt", true, true, SalesShipmentHeader);
                                end;
                            end;
                        end;
                    end;
                }
                action(PostAndNew)
                {
                    Caption = 'Post and New';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ShortCutKey = 'Shift+F9';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Sales-Post (Yes/No)", NavigateAfterPost::"New Document");
                    end;
                }
                action(PostAndSend)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and Send';
                    Ellipsis = true;
                    Image = PostMail;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    ToolTip = 'Finalize and prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Sales-Post and Send", NavigateAfterPost::Nowhere);
                    end;
                }
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';
                    Visible = false;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    ToolTip = 'Remove the scheduled processing of this record from the job queue.';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting;
                    end;
                }
                action(PreviewPosting)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';
                    Visible = false;

                    trigger OnAction()
                    begin
                        ShowPreview;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
    begin
        DynamicEditable := CurrPage.Editable;
        //CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CRMIsCoupledToRecord := CRMIntegrationEnabled and CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RecordId);
        //ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);

        UpdatePaymentService;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlVisibility;
        UpdateShipToBillToGroupVisibility;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        exit(Rec.ConfirmDeletion);
    end;

    trigger OnInit()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        SetExtDocNoMandatoryCondition;

        JobQueuesUsed := SalesReceivablesSetup."Post & Print with Job Queue" or SalesReceivablesSetup."Post with Job Queue";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if not FINCashOfficeUserTemplate.Get(UserId) then Error('Access to receipting denied!');
        FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Cash Sale Bank");
        FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Sales Inv. Nos.");
        FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Cash Receipt No. Series");
        FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Default Direct Sale Customer");
        FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Sales External Doc. Nos");
        FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Default Direct Sales Location");
        FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Sales Item Category");
        FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Cash Sale Deposit Nos.");

        //"Cash Sale Order":=TRUE;
        if Rec."No." = '' then begin
            Rec."No." := NoSeriesMgt.GetNextNo(FINCashOfficeUserTemplate."Cash Receipt No. Series", Today, true);
        end;
        Rec."Sell-to Customer No." := FINCashOfficeUserTemplate."Default Direct Sale Customer";
        Rec.Validate("Sell-to Customer No.");
        Rec."Order Date" := Today;
        Rec."Posting Date" := Today;
        Rec."Shipment Date" := Today;
        //"Bal. Account Type":="Bal. Account Type"::"Bank Account";
        //"Bal. Account No.":=FINCashOfficeUserTemplate."Direct Cash Sale Bank";
        //"Payment Type":="Payment Type"::Cash;
        //VALIDATE("Payment Type");

        Rec."Posting Description" := 'Sales ' + FINCashOfficeUserTemplate.UserID + ',' + FINCashOfficeUserTemplate."Default Direct Sales Location" + ',' + FINCashOfficeUserTemplate."Direct Sales Item Category";
        Rec."Due Date" := Today;
        Rec."Location Code" := FINCashOfficeUserTemplate."Default Direct Sales Location";
        Rec."Document Date" := Today;
        Rec."External Document No." := NoSeriesMgt.GetNextNo(FINCashOfficeUserTemplate."Direct Sales External Doc. Nos", Today, true);
        Rec."Requested Delivery Date" := Today;
        Rec."Shortcut Dimension 1 Code" := FINCashOfficeUserTemplate."Shortcut Dimension 1 Code";
        Rec."Shortcut Dimension 2 Code" := FINCashOfficeUserTemplate."Shortcut Dimension 2 Code";
        //"Payment Period":=FINCashOfficeUserTemplate."Shortcut Dimension 3 Code";
        if DocNoVisible then
            Rec.CheckCreditMaxBeforeInsert;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if not FINCashOfficeUserTemplate.Get(UserId) then Error('Access to receipting denied!');
        FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Cash Sale Bank");
        FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Sales Inv. Nos.");
        FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Cash Receipt No. Series");
        FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Default Direct Sale Customer");
        FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Sales External Doc. Nos");
        FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Default Direct Sales Location");
        FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Sales Item Category");
        FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Cash Sale Deposit Nos.");

        Rec."Cash Sale Order" := true;
        if Rec."No." = '' then begin
            Rec."No." := NoSeriesMgt.GetNextNo(FINCashOfficeUserTemplate."Cash Receipt No. Series", Today, true);
        end;
        Rec."Sell-to Customer No." := FINCashOfficeUserTemplate."Default Direct Sale Customer";
        Rec.Validate("Sell-to Customer No.");
        Rec."Order Date" := Today;
        Rec."Posting Date" := Today;
        Rec."Shipment Date" := Today;
        //"Bal. Account Type":="Bal. Account Type"::"Bank Account";
        //"Bal. Account No.":=FINCashOfficeUserTemplate."Direct Cash Sale Bank";

        //"Payment Type":="Payment Type"::Cash;
        //VALIDATE("Period Year");
        Rec."Posting Description" := CopyStr(('Cafe Cash ' + FINCashOfficeUserTemplate.UserID + ',' + FINCashOfficeUserTemplate."Default Direct Sales Location" + ',' + FINCashOfficeUserTemplate."Direct Sales Item Category"), 1, 70);
        Rec."Due Date" := Today;
        Rec."Location Code" := FINCashOfficeUserTemplate."Default Direct Sales Location";
        Rec."Document Date" := Today;
        Rec."External Document No." := NoSeriesMgt.GetNextNo(FINCashOfficeUserTemplate."Direct Sales External Doc. Nos", Today, true);
        Rec."Requested Delivery Date" := Today;
        //Status:=Status::Released;
        Rec."Responsibility Center" := UserMgt.GetSalesFilter;
        if (not DocNoVisible) and (Rec."No." = '') then
            Rec.SetSellToCustomerFromFilter;

        Rec.SetDefaultPaymentServices;
    end;

    trigger OnOpenPage()
    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        OfficeMgt: Codeunit "Office Management";
    begin
        if UserMgt.GetSalesFilter <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetSalesFilter);
            Rec.FilterGroup(0);
        end;

        Rec.SetRange("Date Filter", 0D, WorkDate - 1);

        SetDocNoVisible;

        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
        IsOfficeHost := OfficeMgt.IsPopOut;
        Rec.CalcFields(Amount, "Document Amount");
        Rec."Cash Amount" := Rec."Document Amount";

        if Rec."Quote No." <> '' then
            ShowQuoteNo := true;
        Clear(Rec.Balance);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if not DocumentIsPosted then
            exit(Rec.ConfirmCloseUnposted);
    end;

    var
        ApplicationAreaSetup: Record "Application Area Setup";
        CopySalesDoc: Report "Copy Sales Document";
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
        UserMgt: Codeunit "User Setup Management";
        ChangeExchangeRate: Page "Change Exchange Rate";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";
        NavigateAfterPost: Option "Posted Document","New Document",Nowhere;
        [InDataSet]
        JobQueueVisible: Boolean;
        Text001: Label 'Do you want to change %1 in all related records in the warehouse?';
        Text002: Label 'The update has been interrupted to respect the warning.';
        DynamicEditable: Boolean;
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        ExternalDocNoMandatory: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        ShowWorkflowStatus: Boolean;
        IsOfficeHost: Boolean;
        CanCancelApprovalForRecord: Boolean;
        JobQueuesUsed: Boolean;
        ShowQuoteNo: Boolean;
        DocumentIsPosted: Boolean;
        OpenPostedSalesOrderQst: Label 'The order has been posted and moved to the Posted Sales Invoices window.\\Do you want to open the posted invoice?';
        PaymentServiceVisible: Boolean;
        PaymentServiceEnabled: Boolean;
        ShipToOptions: Option "Default (Sell-to Address)","Alternate Shipping Address","Custom Address";
        BillToOptions: Option "Default (Customer)","Another Customer";
        EmptyShipToCodeErr: Label 'The Code field can only be empty if you select Custom Address in the Ship-to field.';
        FINCashOfficeUserTemplate: Record "FIN-Cash Office User Template";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BankNo: Code[20];
        Location: Record Location;

    local procedure Post(PostingCodeunitID: Integer; Navigate: Option)
    var
        SalesHeader: Record "Sales Header";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if ApplicationAreaSetup.IsFoundationEnabled then
            LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);

        Rec.SendToPosting(PostingCodeunitID);
        DocumentIsPosted := not SalesHeader.Get(Rec."Document Type", Rec."No.");

        if Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" then
            CurrPage.Close;
        CurrPage.Update(false);

        if PostingCodeunitID <> CODEUNIT::"Sales-Post (Yes/No)" then
            exit;

        case Navigate of
            // NavigateAfterPost::"Posted Document":
            //  IF InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) THEN
            //  ShowPostedConfirmationMessage;
            NavigateAfterPost::"New Document":
                if DocumentIsPosted then begin
                    //SalesHeader.INIT;
                    //SalesHeader.VALIDATE("Cash Sale Order",TRUE);
                    //SalesHeader.VALIDATE("Document Type",SalesHeader."Document Type"::Order);
                    //SalesHeader.INSERT(TRUE);
                    if not FINCashOfficeUserTemplate.Get(UserId) then Error('Access to receipting denied!');
                    FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Cash Sale Bank");
                    FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Sales Inv. Nos.");
                    FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Cash Receipt No. Series");
                    FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Default Direct Sale Customer");
                    FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Sales External Doc. Nos");
                    FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Default Direct Sales Location");
                    FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Sales Item Category");
                    FINCashOfficeUserTemplate.TestField(FINCashOfficeUserTemplate."Direct Cash Sale Deposit Nos.");
                    SalesHeader.Init;
                    SalesHeader."Cash Sale Order" := true;
                    //IF SalesHeader."No." = '' THEN BEGIN
                    SalesHeader."No." := NoSeriesMgt.GetNextNo(FINCashOfficeUserTemplate."Cash Receipt No. Series", Today, true);
                    //END;
                    //SalesHeader."Sell-to Customer No.":=FINCashOfficeUserTemplate."Default Direct Sale Customer";
                    //VALIDATE("Sell-to Customer No.");
                    SalesHeader."Order Date" := Today;
                    SalesHeader."Posting Date" := Today;
                    SalesHeader."Shipment Date" := Today;
                    SalesHeader."Posting Description" := 'Sales ' + FINCashOfficeUserTemplate.UserID + ',' + FINCashOfficeUserTemplate."Default Direct Sales Location" + ',' + FINCashOfficeUserTemplate."Direct Sales Item Category";
                    SalesHeader."Due Date" := Today;
                    Rec."Location Code" := FINCashOfficeUserTemplate."Default Direct Sales Location";
                    SalesHeader."Document Date" := Today;
                    SalesHeader."External Document No." := NoSeriesMgt.GetNextNo(FINCashOfficeUserTemplate."Direct Sales External Doc. Nos", Today, true);
                    SalesHeader."Requested Delivery Date" := Today;

                    SalesHeader."Responsibility Center" := UserMgt.GetSalesFilter;
                    SalesHeader.Insert;
                    PAGE.Run(PAGE::"Cash Sale Header-Staff", SalesHeader);
                end;
        end;
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(true);
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.Update;
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.Update;
    end;

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::Order, Rec."No.");
    end;

    local procedure SetExtDocNoMandatoryCondition()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        SalesReceivablesSetup.Get;
        ExternalDocNoMandatory := SalesReceivablesSetup."Ext. Doc. No. Mandatory"
    end;

    local procedure ShowPreview()
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Preview(Rec);
    end;

    local procedure SetControlVisibility()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        JobQueueVisible := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        SetExtDocNoMandatoryCondition;

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
    end;

    local procedure ShowPostedConfirmationMessage()
    var
        OrderSalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if not OrderSalesHeader.Get(Rec."Document Type", Rec."No.") then begin
            SalesInvoiceHeader.SetRange("No.", Rec."Last Posting No.");
            if SalesInvoiceHeader.FindFirst then
                if InstructionMgt.ShowConfirm(OpenPostedSalesOrderQst, InstructionMgt.ShowPostedConfirmationMessageCode) then
                    PAGE.Run(PAGE::"Posted Sales Invoice", SalesInvoiceHeader);
        end;
    end;

    local procedure UpdatePaymentService()
    var
        PaymentServiceSetup: Record "Payment Service Setup";
    begin
        PaymentServiceVisible := PaymentServiceSetup.IsPaymentServiceVisible;
        PaymentServiceEnabled := PaymentServiceSetup.CanChangePaymentService(Rec);
    end;

    local procedure UpdateShipToBillToGroupVisibility()
    begin
        case true of
            (Rec."Ship-to Code" = '') and Rec.ShipToAddressEqualsSellToAddress:
                ShipToOptions := ShipToOptions::"Default (Sell-to Address)";
            (Rec."Ship-to Code" = '') and (not Rec.ShipToAddressEqualsSellToAddress):
                ShipToOptions := ShipToOptions::"Custom Address";
            Rec."Ship-to Code" <> '':
                ShipToOptions := ShipToOptions::"Alternate Shipping Address";
        end;

        if Rec."Bill-to Customer No." = Rec."Sell-to Customer No." then
            BillToOptions := BillToOptions::"Default (Customer)"
        else
            BillToOptions := BillToOptions::"Another Customer";
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeStatisticsAction(var SalesHeader: Record "Sales Header"; var Handled: Boolean)
    begin
    end;
}




