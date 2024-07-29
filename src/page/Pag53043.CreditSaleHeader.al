page 53043 "Credit Sale Header"
{
    Caption = 'Credit Sale Header';
    DeleteAllowed = true;
    ModifyAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER('Order'),
                            "Cash Sale Order" = FILTER('true'),
                            Status = FILTER('Open'),
                            "Credit Sale" = FILTER('true'));

    layout
    {
        area(content)
        {
            group(General1)
            {
                Caption = 'General';
            }
            group(General)
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
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer';
                    Editable = false;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the name of the customer who will receive the products and be billed by default.';

                    trigger OnValidate()
                    begin
                        IF Rec.GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." THEN
                            IF Rec."Sell-to Customer No." <> xRec."Sell-to Customer No." THEN
                                Rec.SETRANGE("Sell-to Customer No.");

                        IF ApplicationAreaSetup.IsFoundationEnabled THEN
                            SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);

                        CurrPage.UPDATE;
                    end;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                // field("Payment Period";"Payment Period")
                // {
                // }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.';
                }
                group("Sell-to")
                {
                    Caption = 'Sell-to';
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

                    // trigger OnValidate()
                    // begin
                    //     SalespersonCodeOnAfterValidate;
                    // end;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    AccessByPermission = TableData 5714 = R;
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
            // part(SalesLines;"Credit Sale Subform")
            // {
            //     ApplicationArea = Basic,Suite;
            //     Editable = DynamicEditable;
            //     Enabled = "Sell-to Customer No." <> '';
            //     SubPageLink = "Document No."=FIELD("No.");
            //     UpdatePropagation = Both;
            // }
            group(Cost)
            {
                Caption = 'Cost';
                Visible = true;
                field("Document Amount"; Rec."Document Amount")
                {
                    Editable = false;
                    Enabled = false;

                    trigger OnValidate()
                    begin
                        Rec.Balance := Rec."Amount Paid" - Rec."Document Amount";
                        CurrPage.UPDATE;
                    end;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the date on which you created the sales document.';
                    Visible = true;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the posting of the sales document will be recorded.';
                    Visible = true;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    QuickEntry = false;
                    ToolTip = 'Specifies the date on which the exchange rate applies to prices listed in a foreign currency on the sales order.';
                    Visible = true;
                }
            }
            group("Shipping and Billing")
            {
                Caption = 'Shipping and Billing';
                Visible = false;
                group(we)
                {
                    group(eqwr)
                    {
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
                                CASE ShipToOptions OF
                                    ShipToOptions::"Default (Sell-to Address)":
                                        BEGIN
                                            Rec.VALIDATE("Ship-to Code", '');
                                            Rec.CopySellToAddressToShipToAddress;
                                        END;
                                    ShipToOptions::"Alternate Shipping Address":
                                        BEGIN
                                            ShipToAddress.SETRANGE("Customer No.", Rec."Sell-to Customer No.");
                                            ShipToAddressList.LOOKUPMODE := TRUE;
                                            ShipToAddressList.SETTABLEVIEW(ShipToAddress);

                                            IF ShipToAddressList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                                ShipToAddressList.GETRECORD(ShipToAddress);
                                                Rec.VALIDATE("Ship-to Code", ShipToAddress.Code);
                                            END ELSE
                                                ShipToOptions := ShipToOptions::"Custom Address";
                                        END;
                                    ShipToOptions::"Custom Address":
                                        Rec.VALIDATE("Ship-to Code", '');
                                END;
                            end;
                        }
                    }
                    group("Shipment Method")
                    {
                        Caption = 'Shipment Method';
                        Visible = false;
                        field("Shipping No. Series"; Rec."Shipping No. Series")
                        {
                        }
                        field("Posting No. Series"; Rec."Posting No. Series")
                        {
                        }
                    }
                }
                group(weter)
                {
                    Visible = false;
                    field(BillToOptions; BillToOptions)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bill-to';
                        ToolTip = 'Specifies the customer that the sales invoice will be sent to. Default (Customer): The same as the customer on the sales invoice. Another Customer: Any customer that you specify in the fields below.';

                        trigger OnValidate()
                        begin
                            IF BillToOptions = BillToOptions::"Default (Customer)" THEN
                                Rec.VALIDATE("Bill-to Customer No.", Rec."Sell-to Customer No.");
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
                action(Postings)
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
                        // Depos//itLines: Record "81";
                        SalesShipmentHeader: Record "Sales Shipment Header";
                        SalesHeader: Record "sales Header";
                        SalesLine: Record "Sales Line";
                        TotalLineAmount: Decimal;
                        LineNo: Integer;
                    begin
                        CLEAR(TotalLineAmount);
                        Rec.CALCFIELDS("Document Amount");
                        //IF Rec."Amount Paid"<Rec."Document Amount" THEN ERROR('Amount Paid is less');
                        //Rec.TESTFIELD(Rec."Bal. Account No.");

                        IF CONFIRM('Post?', TRUE) = FALSE THEN EXIT;

                        // Get Document Number Here
                        //Get Amount Paid and Change Too
                        // Create a Depisit Entry
                        SalesLine.RESET;
                        SalesLine.SETRANGE(SalesLine."Document No.", Rec."No.");
                        //salesline.SETFILTER(SalesLine.Amount,'=%1',0);
                        //IF salesline.FIND('-') THEN ERROR('All Line must have quantity');
                        IF SalesLine.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                TotalLineAmount := TotalLineAmount + SalesLine.Amount;
                            END;
                            UNTIL SalesLine.NEXT = 0;

                            IF TotalLineAmount > 0 THEN BEGIN
                                IF NOT FINCashOfficeUserTemplate.GET(USERID) THEN ERROR('Access to receipting denied!');
                                FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Cash Sale Bank");
                                FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Sales Inv. Nos.");
                                FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Cash Receipt No. Series");
                                FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Default Direct Sale Customer");
                                FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Sales External Doc. Nos");
                                FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Default Direct Sales Location");
                                FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Sales Item Category");
                                FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Cash Sale Deposit Nos.");
                                FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Petty Cash Template");
                                FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Petty Cash Batch");

                                // DirectCreditSalesBuffDet.RESET;
                                // DirectCreditSalesBuffDet.SETRANGE("User ID",USERID);
                                // IF DirectCreditSalesBuffDet.FIND('-') THEN BEGIN
                                //       DirectCreditSalesBuffDet."Cost Center Code":=Rec."Shortcut Dimension 1 Code";
                                //     DirectCreditSalesBuffDet.Department:=Rec."Shortcut Dimension 2 Code";
                                //     DirectCreditSalesBuffDet."Location Code":=Rec."Location Code";
                                //     DirectCreditSalesBuffDet.MODIFY;
                                //   END ELSE BEGIN
                                //     DirectCreditSalesBuffDet.INIT;
                                //     DirectCreditSalesBuffDet."User ID":=USERID;
                                //     DirectCreditSalesBuffDet."Cost Center Code":=Rec."Shortcut Dimension 1 Code";
                                //     DirectCreditSalesBuffDet.Department:=Rec."Shortcut Dimension 2 Code";
                                //     DirectCreditSalesBuffDet."Location Code":=Rec."Location Code";
                                //     DirectCreditSalesBuffDet.INSERT;
                                //     END;
                                Post(CODEUNIT::"Sales-Post (Yes/No)", NavigateAfterPost::"New Document");


                                // Print Receipt
                                SalesShipmentHeader.RESET;
                                SalesShipmentHeader.SETRANGE(SalesShipmentHeader."Order No.", xRec."No.");
                                IF SalesShipmentHeader.FIND('-') THEN BEGIN
                                    // Load and Print Receipt Here
                                    REPORT.RUN(65010, FALSE, TRUE, SalesShipmentHeader);
                                END;
                            END;
                        END;
                    end;
                }
                action(PostAndNew)
                {
                    Caption = 'Post and New';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ShortCutKey = 'F10';
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
                        //  ShowPreview;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        CRMCouplingManagement: Codeunit "CRM Integration Management";
    begin
        DynamicEditable := CurrPage.EDITABLE;
        //CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        //  CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
        //ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);

        UpdatePaymentService;
    end;

    // trigger OnAfterGetRecord()
    // begin
    //     SetControlVisibility;
    //     UpdateShipToBillToGroupVisibility;
    // end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(Rec.ConfirmDeletion);
    end;

    trigger OnInit()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        //  SetExtDocNoMandatoryCondition;

        JobQueuesUsed := SalesReceivablesSetup."Post & Print with Job Queue" OR SalesReceivablesSetup."Post with Job Queue";
    end;

    // trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    // begin
    //     IF NOT FINCashOfficeUserTemplate.GET(USERID) THEN ERROR('Access to receipting denied!');
    //     FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Cash Sale Bank");
    //     FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Sales Inv. Nos.");
    //     FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Cash Receipt No. Series");
    //     FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Default Direct Sale Customer");
    //     FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Sales External Doc. Nos");
    //     FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Default Direct Sales Location");
    //     FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Sales Item Category");
    //     FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Cash Sale Deposit Nos.");

    //     "Cash Sale Order":=TRUE;
    //       IF "No." = '' THEN BEGIN
    //       "No." :=NoSeriesMgt.GetNextNo(FINCashOfficeUserTemplate."Cash Receipt No. Series",TODAY,TRUE);
    //     END;
    //     //"Sell-to Customer No.":=FINCashOfficeUserTemplate."Default Direct Sale Customer";
    //     //VALIDATE("Sell-to Customer No.");
    //         DirectCreditSalesBuffDet.RESET;
    //         DirectCreditSalesBuffDet.SETRANGE("User ID",USERID);
    //         IF DirectCreditSalesBuffDet.FIND('-') THEN BEGIN
    //           END;
    //     "Credit Sale":=TRUE;
    //     "Order Date":=TODAY;
    //     "Posting Date":=TODAY;
    //     "Shipment Date":=TODAY;
    //     //"Bal. Account Type":="Bal. Account Type"::"Bank Account";
    //     //"Bal. Account No.":=FINCashOfficeUserTemplate."Direct Cash Sale Bank";
    //     "Posting Description":='Credit Sale '+FINCashOfficeUserTemplate.UserID+','+FINCashOfficeUserTemplate."Default Direct Sales Location"+','+FINCashOfficeUserTemplate."Direct Sales Item Category";
    //     "Due Date":=TODAY;
    //     IF DirectCreditSalesBuffDet."Location Code"<>'' THEN
    //     "Location Code":=DirectCreditSalesBuffDet."Location Code"
    //     ELSE
    //     "Location Code":=FINCashOfficeUserTemplate."Default Direct Sales Location";
    //     "Document Date":=TODAY;
    //     "External Document No.":=NoSeriesMgt.GetNextNo(FINCashOfficeUserTemplate."Direct Sales External Doc. Nos",TODAY,TRUE);
    //     "Requested Delivery Date":=TODAY;
    //     IF DirectCreditSalesBuffDet."Cost Center Code"<>'' THEN
    //       "Shortcut Dimension 1 Code":=DirectCreditSalesBuffDet."Cost Center Code"
    //     ELSE
    //     "Shortcut Dimension 1 Code":=FINCashOfficeUserTemplate."Shortcut Dimension 1 Code";
    //     IF DirectCreditSalesBuffDet.Department<>'' THEN
    //       "Shortcut Dimension 2 Code":=DirectCreditSalesBuffDet.Department
    //     ELSE
    //     "Shortcut Dimension 2 Code":=FINCashOfficeUserTemplate."Shortcut Dimension 2 Code";
    //     //"Payment Period":=FINCashOfficeUserTemplate."Shortcut Dimension 3 Code";

    //     "Responsibility Center" := UserMgt.GetSalesFilter;
    //     IF DocNoVisible THEN
    //       CheckCreditMaxBeforeInsert;
    // end;

    // trigger OnNewRecord(BelowxRec: Boolean)
    // begin
    //     IF NOT FINCashOfficeUserTemplate.GET(USERID) THEN ERROR('Access to receipting denied!');
    //     FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Cash Sale Bank");
    //     FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Sales Inv. Nos.");
    //     FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Cash Receipt No. Series");
    //     FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Default Direct Sale Customer");
    //     FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Sales External Doc. Nos");
    //     FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Default Direct Sales Location");
    //     FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Sales Item Category");
    //     FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Cash Sale Deposit Nos.");

    //     "Cash Sale Order":=TRUE;
    //       IF "No." = '' THEN BEGIN
    //       "No." :=NoSeriesMgt.GetNextNo(FINCashOfficeUserTemplate."Cash Receipt No. Series",TODAY,TRUE);
    //     END;
    //         DirectCreditSalesBuffDet.RESET;
    //         DirectCreditSalesBuffDet.SETRANGE("User ID",USERID);
    //         IF DirectCreditSalesBuffDet.FIND('-') THEN BEGIN
    //           END;
    //     //"Sell-to Customer No.":=FINCashOfficeUserTemplate."Default Direct Sale Customer";
    //     //VALIDATE("Sell-to Customer No.");
    //     "Credit Sale":=TRUE;
    //     "Order Date":=TODAY;
    //     "Posting Date":=TODAY;
    //     "Shipment Date":=TODAY;
    //     //"Bal. Account Type":="Bal. Account Type"::"Bank Account";
    //     //"Bal. Account No.":=FINCashOfficeUserTemplate."Direct Cash Sale Bank";
    //     "Posting Description":='Credit Sale '+FINCashOfficeUserTemplate.UserID+','+FINCashOfficeUserTemplate."Default Direct Sales Location"+','+FINCashOfficeUserTemplate."Direct Sales Item Category";
    //     "Due Date":=TODAY;
    //     // IF DirectCreditSalesBuffDet."Location Code"<>'' THEN
    //     // "Location Code":=DirectCreditSalesBuffDet."Location Code"
    //     // ELSE
    //     // "Location Code":=FINCashOfficeUserTemplate."Default Direct Sales Location";
    //     "Document Date":=TODAY;
    //     "External Document No.":=NoSeriesMgt.GetNextNo(FINCashOfficeUserTemplate."Direct Sales External Doc. Nos",TODAY,TRUE);
    //     "Requested Delivery Date":=TODAY;
    //     // IF DirectCreditSalesBuffDet."Cost Center Code"<>'' THEN
    //     //   "Shortcut Dimension 1 Code":=DirectCreditSalesBuffDet."Cost Center Code"
    //     // ELSE
    //     // "Shortcut Dimension 1 Code":=FINCashOfficeUserTemplate."Shortcut Dimension 1 Code";
    //     IF DirectCreditSalesBuffDet.Department<>'' THEN
    //       "Shortcut Dimension 2 Code":=DirectCreditSalesBuffDet.Department
    //     ELSE
    //     "Shortcut Dimension 2 Code":=FINCashOfficeUserTemplate."Shortcut Dimension 2 Code";
    //     //"Payment Period":=FINCashOfficeUserTemplate."Shortcut Dimension 3 Code";

    //     "Responsibility Center" := UserMgt.GetSalesFilter;
    //     IF (NOT DocNoVisible) AND ("No." = '') THEN
    //       SetSellToCustomerFromFilter;

    //     SetDefaultPaymentServices;
    // end;

    // trigger OnOpenPage()
    // var
    //     CRMIntegrationManagement: Codeunit "5330";
    //     OfficeMgt: Codeunit "1630";
    // begin
    //     IF UserMgt.GetSalesFilter <> '' THEN BEGIN
    //       FILTERGROUP(2);
    //       SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
    //       FILTERGROUP(0);
    //     END;

    //     SETRANGE("Date Filter",0D,WORKDATE - 1);

    //     SetDocNoVisible;

    //     CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    //     IsOfficeHost := OfficeMgt.IsAvailable;

    //     IF "Quote No." <> '' THEN
    //       ShowQuoteNo := TRUE;
    // end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF NOT DocumentIsPosted THEN
            EXIT(Rec.ConfirmCloseUnposted);
    end;

    var
        ApplicationAreaSetup: Record "Application Area Setup";
        CopySalesDoc: Report "Copy Sales Document";
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        ArchiveManagement: Codeunit "ArchiveManagement";
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
    //DirectCreditSalesBuffDet: Record "Direct Credit Sales Buff. Det.";

    local procedure Post(PostingCodeunitID: Integer; Navigate: Option)
    var
        SalesHeader: Record "Sales Header";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        IF ApplicationAreaSetup.IsFoundationEnabled THEN
            LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);

        Rec.SendToPosting(PostingCodeunitID);
        DocumentIsPosted := NOT SalesHeader.GET(Rec."Document Type", Rec."No.");

        IF Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);

        IF PostingCodeunitID <> CODEUNIT::"Sales-Post (Yes/No)" THEN
            EXIT;

        CASE Navigate OF
            // NavigateAfterPost::"Posted Document":
            //  IF InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) THEN
            //  ShowPostedConfirmationMessage;
            NavigateAfterPost::"New Document":
                IF DocumentIsPosted THEN BEGIN
                    //SalesHeader.INIT;
                    //SalesHeader.VALIDATE("Cash Sale Order",TRUE);
                    //SalesHeader.VALIDATE("Document Type",SalesHeader."Document Type"::Order);
                    //SalesHeader.INSERT(TRUE);
                    IF NOT FINCashOfficeUserTemplate.GET(USERID) THEN ERROR('Access to receipting denied!');
                    FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Cash Sale Bank");
                    FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Sales Inv. Nos.");
                    FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Cash Receipt No. Series");
                    FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Default Direct Sale Customer");
                    FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Sales External Doc. Nos");
                    FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Default Direct Sales Location");
                    FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Sales Item Category");
                    FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Cash Sale Deposit Nos.");
                    // DirectCreditSalesBuffDet.RESET;
                    // DirectCreditSalesBuffDet.SETRANGE("User ID",USERID);
                    // IF DirectCreditSalesBuffDet.FIND('-') THEN BEGIN
                    //   END;
                    SalesHeader.INIT;
                    SalesHeader."Cash Sale Order" := TRUE;
                    // IF "No." = '' THEN BEGIN
                    SalesHeader."No." := NoSeriesMgt.GetNextNo(FINCashOfficeUserTemplate."Cash Receipt No. Series", TODAY, TRUE);
                    //END;
                    //"Sell-to Customer No.":=FINCashOfficeUserTemplate."Default Direct Sale Customer";
                    //VALIDATE("Sell-to Customer No.");
                    SalesHeader."Credit Sale" := TRUE;
                    SalesHeader."Order Date" := TODAY;
                    SalesHeader."Posting Date" := TODAY;
                    SalesHeader."Shipment Date" := TODAY;
                    //"Bal. Account Type":="Bal. Account Type"::"Bank Account";
                    //"Bal. Account No.":=FINCashOfficeUserTemplate."Direct Cash Sale Bank";
                    SalesHeader."Posting Description" := COPYSTR('Credit Sale ' + FINCashOfficeUserTemplate.UserID + ',' + FINCashOfficeUserTemplate."Default Direct Sales Location" + ',' + FINCashOfficeUserTemplate."Direct Sales Item Category", 1, 50);
                    SalesHeader."Due Date" := TODAY;
                    // IF DirectCreditSalesBuffDet."Location Code"<>'' THEN
                    // "Location Code":=DirectCreditSalesBuffDet."Location Code"
                    // ELSE
                    // "Location Code":=FINCashOfficeUserTemplate."Default Direct Sales Location";
                    // "Document Date":=TODAY;
                    // "External Document No.":=NoSeriesMgt.GetNextNo(FINCashOfficeUserTemplate."Direct Sales External Doc. Nos",TODAY,TRUE);
                    // "Requested Delivery Date":=TODAY;
                    // IF DirectCreditSalesBuffDet."Cost Center Code"<>'' THEN
                    //   "Shortcut Dimension 1 Code":=DirectCreditSalesBuffDet."Cost Center Code"
                    // ELSE
                    // "Shortcut Dimension 1 Code":=FINCashOfficeUserTemplate."Shortcut Dimension 1 Code";
                    // IF DirectCreditSalesBuffDet.Department<>'' THEN
                    //   "Shortcut Dimension 2 Code":=DirectCreditSalesBuffDet.Department
                    // ELSE
                    // "Shortcut Dimension 2 Code":=FINCashOfficeUserTemplate."Shortcut Dimension 2 Code";
                    //"Payment Period":=FINCashOfficeUserTemplate."Shortcut Dimension 3 Code";

                    SalesHeader."Responsibility Center" := UserMgt.GetSalesFilter;
                    //IF (NOT DocNoVisible) AND ("No." = '') THEN
                    //  SetSellToCustomerFromFilter;
                    //SetDefaultPaymentServices;
                    PAGE.RUN(PAGE::"Credit Sale Header", SalesHeader);
                END;
        END;
    end;

    // local procedure ApproveCalcInvDisc()
    // begin
    //     CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
    // end;

    // local procedure SalespersonCodeOnAfterValidate()
    // begin
    //     CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    // end;

    // local procedure ShortcutDimension1CodeOnAfterV()
    // begin
    //     CurrPage.UPDATE;
    // end;

    // local procedure ShortcutDimension2CodeOnAfterV()
    // begin
    //     CurrPage.UPDATE;
    // end;

    // local procedure Prepayment37OnAfterValidate()
    // begin
    //     CurrPage.UPDATE;
    // end;

    // local procedure SetDocNoVisible()
    // var
    //     DocumentNoVisibility: Codeunit "1400";
    //     DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    // begin
    //     DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::Order,"No.");
    // end;

    // local procedure SetExtDocNoMandatoryCondition()
    // var
    //     SalesReceivablesSetup: Record "311";
    // begin
    //     SalesReceivablesSetup.GET;
    //     ExternalDocNoMandatory := SalesReceivablesSetup."Ext. Doc. No. Mandatory"
    // end;

    // local procedure ShowPreview()
    // var
    //     SalesPostYesNo: Codeunit "81";
    // begin
    //     SalesPostYesNo.Preview(Rec);
    // end;

    // local procedure SetControlVisibility()
    // var
    //     ApprovalsMgmt: Codeunit "1535";
    // begin
    //     JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
    //     HasIncomingDocument := "Incoming Document Entry No." <> 0;
    //     SetExtDocNoMandatoryCondition;

    //     OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
    //     OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
    //     CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
    // end;

    local procedure ShowPostedConfirmationMessage()
    var
        OrderSalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        IF NOT OrderSalesHeader.GET(Rec."Document Type", Rec."No.") THEN BEGIN
            SalesInvoiceHeader.SETRANGE("No.", Rec."Last Posting No.");
            IF SalesInvoiceHeader.FINDFIRST THEN
                IF InstructionMgt.ShowConfirm(OpenPostedSalesOrderQst, InstructionMgt.ShowPostedConfirmationMessageCode) THEN
                    PAGE.RUN(PAGE::"Posted Sales Invoice", SalesInvoiceHeader);
        END;
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
        CASE TRUE OF
            (Rec."Ship-to Code" = '') AND Rec.ShipToAddressEqualsSellToAddress:
                ShipToOptions := ShipToOptions::"Default (Sell-to Address)";
            (Rec."Ship-to Code" = '') AND (NOT Rec.ShipToAddressEqualsSellToAddress):
                ShipToOptions := ShipToOptions::"Custom Address";
            Rec."Ship-to Code" <> '':
                ShipToOptions := ShipToOptions::"Alternate Shipping Address";
        END;

        IF Rec."Bill-to Customer No." = Rec."Sell-to Customer No." THEN
            BillToOptions := BillToOptions::"Default (Customer)"
        ELSE
            BillToOptions := BillToOptions::"Another Customer";
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeStatisticsAction(var SalesHeader: Record "Sales Header"; var Handled: Boolean)
    begin
    end;
}

