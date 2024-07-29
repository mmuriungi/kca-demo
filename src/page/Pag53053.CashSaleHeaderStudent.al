page 53053 "Cash Sale Header-Student"
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
                    Visible = true;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    Enabled = false;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    Enabled = false;
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
                field("Sales Location Category"; Rec."Sales Location Category")
                {
                    Editable = true;
                    Enabled = true;
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
            }
            group(Cost)
            {
                Caption = 'Cost';
                Visible = false;
                field("Amount Paid"; Rec."Amount Paid")
                {
                    Editable = false;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.Balance := Rec."Amount Paid" - Rec."Document Amount";
                        CurrPage.UPDATE;
                    end;
                }
                field("Cash Amount"; Rec."Cash Amount")
                {
                    Caption = 'Cash Amount';
                    Enabled = false;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Paybill Amount"; Rec."Paybill Amount")
                {
                    Caption = 'Paybill Amount';

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
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
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date you expect to ship items on the sales document.';
                    Visible = true;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the date on which you created the sales document.';
                    Visible = true;
                }
            }
            group("Shipping and Billing")
            {
                Caption = 'Shipping and Billing';
                Visible = false;
                group(rwet)
                {
                    group(rey)
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
                group(wet)
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
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    var
                        // DepositHeader: Record "10140";
                        // DepositLines: Record "81";
                        SalesShipmentHeader: Record "Sales Shipment Header";
                        SalesHeader: Record "Sales Header";
                        SalesLine: Record "Sales Line";
                        TotalLineAmount: Decimal;
                        LineNo: Integer;
                    begin
                        Rec.CALCFIELDS(Amount);
                        IF Rec.Amount = 0 THEN ERROR('Nothing to be paid for!');
                        PAGE.RUN(Page::"Cash Sale Post", Rec);
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
        DynamicEditable := CurrPage.EDITABLE;
        //CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RECORDID);
        //ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);

        UpdatePaymentService;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlVisibility;
        UpdateShipToBillToGroupVisibility;

        //SETFILTER("Created By",USERID);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(Rec.ConfirmDeletion);
    end;

    trigger OnInit()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        SetExtDocNoMandatoryCondition;

        JobQueuesUsed := SalesReceivablesSetup."Post & Print with Job Queue" OR SalesReceivablesSetup."Post with Job Queue";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF NOT FINCashOfficeUserTemplate.GET(USERID) THEN ERROR('Access to receipting denied!');
        FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Cash Sale Bank");
        FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Sales Inv. Nos.");
        FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Cash Receipt No. Series");
        FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Default Direct Sale Customer");
        FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Sales External Doc. Nos");
        FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Default Direct Sales Location");
        FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Sales Item Category");
        FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Cash Sale Deposit Nos.");

        //"Cash Sale Order":=TRUE;
        IF Rec."No." = '' THEN BEGIN
            Rec."No." := NoSeriesMgt.GetNextNo(FINCashOfficeUserTemplate."Cash Receipt No. Series", TODAY, TRUE);
        END;
        Rec."Sell-to Customer No." := FINCashOfficeUserTemplate."Default Direct Sale Customer";
        Rec.VALIDATE("Sell-to Customer No.");
        Rec."Order Date" := TODAY;
        Rec."Posting Date" := TODAY;
        Rec."Shipment Date" := TODAY;
        //"Bal. Account Type":="Bal. Account Type"::"Bank Account";
        //"Bal. Account No.":=FINCashOfficeUserTemplate."Direct Cash Sale Bank";
        //"Payment Type":="Payment Type"::Cash;
        //VALIDATE("Payment Type");

        Rec."Posting Description" := COPYSTR(('Cafe Sales ' + FINCashOfficeUserTemplate.UserID + ',' + FINCashOfficeUserTemplate."Default Direct Sales Location" + ',' + FINCashOfficeUserTemplate."Direct Sales Item Category"), 1, 50);
        Rec."Due Date" := TODAY;
        Rec."Location Code" := 'MSTUD';
        Rec."Document Date" := TODAY;
        Rec."External Document No." := NoSeriesMgt.GetNextNo(FINCashOfficeUserTemplate."Direct Sales External Doc. Nos", TODAY, TRUE);
        Rec."Sales Location Category" := Rec."Sales Location Category"::Students;
        Rec."Created By" := USERID;
        Rec."Requested Delivery Date" := TODAY;
        Rec."Shortcut Dimension 1 Code" := FINCashOfficeUserTemplate."Shortcut Dimension 1 Code";
        Rec."Shortcut Dimension 2 Code" := FINCashOfficeUserTemplate."Shortcut Dimension 2 Code";
        //"Payment Period":=FINCashOfficeUserTemplate."Shortcut Dimension 3 Code";
        IF DocNoVisible THEN
            Rec.CheckCreditMaxBeforeInsert;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IF NOT FINCashOfficeUserTemplate.GET(USERID) THEN ERROR('Access to receipting denied!');
        FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Cash Sale Bank");
        FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Sales Inv. Nos.");
        FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Cash Receipt No. Series");
        FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Default Direct Sale Customer");
        FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Sales External Doc. Nos");
        FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Default Direct Sales Location");
        FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Sales Item Category");
        FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Direct Cash Sale Deposit Nos.");

        Rec."Cash Sale Order" := TRUE;
        IF Rec."No." = '' THEN BEGIN
            Rec."No." := NoSeriesMgt.GetNextNo(FINCashOfficeUserTemplate."Cash Receipt No. Series", TODAY, TRUE);
        END;
        Rec."Sell-to Customer No." := FINCashOfficeUserTemplate."Default Direct Sale Customer";
        Rec.VALIDATE("Sell-to Customer No.");
        Rec."Order Date" := TODAY;
        Rec."Posting Date" := TODAY;
        Rec."Shipment Date" := TODAY;
        //"Bal. Account Type":="Bal. Account Type"::"Bank Account";
        //"Bal. Account No.":=FINCashOfficeUserTemplate."Direct Cash Sale Bank";

        //"Payment Type":="Payment Type"::Cash;
        //VALIDATE("Period Year");
        Rec."Posting Description" := COPYSTR(('Cafe Cash ' + FINCashOfficeUserTemplate.UserID + ',' + FINCashOfficeUserTemplate."Default Direct Sales Location" + ',' + FINCashOfficeUserTemplate."Direct Sales Item Category"), 1, 70);
        Rec."Due Date" := TODAY;
        Rec."Location Code" := 'MSTUD';
        Rec."Document Date" := TODAY;
        Rec."External Document No." := NoSeriesMgt.GetNextNo(FINCashOfficeUserTemplate."Direct Sales External Doc. Nos", TODAY, TRUE);
        Rec."Created By" := USERID;
        Rec."Sales Location Category" := Rec."Sales Location Category"::Students;
        Rec."Requested Delivery Date" := TODAY;
        //Status:=Status::Released;
        Rec."Responsibility Center" := UserMgt.GetSalesFilter;
        IF (NOT DocNoVisible) AND (Rec."No." = '') THEN
            Rec.SetSellToCustomerFromFilter;

        Rec.SetDefaultPaymentServices;
    end;

    trigger OnOpenPage()
    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        OfficeMgt: Codeunit "Office Management";
    begin
        IF UserMgt.GetSalesFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter);
            Rec.FILTERGROUP(0);
        END;

        Rec.SETRANGE("Date Filter", 0D, WORKDATE - 1);

        SetDocNoVisible;

        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
        IsOfficeHost := OfficeMgt.IsAvailable;

        IF Rec."Quote No." <> '' THEN
            ShowQuoteNo := TRUE;

        //SETFILTER("Created By",USERID);
    end;

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
        BankNo: Code[20];
        Location: Record "Location";

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
                    SalesHeader.INIT;
                    SalesHeader."Cash Sale Order" := TRUE;
                    //IF SalesHeader."No." = '' THEN BEGIN
                    SalesHeader."No." := NoSeriesMgt.GetNextNo(FINCashOfficeUserTemplate."Cash Receipt No. Series", TODAY, TRUE);
                    //END;
                    //SalesHeader."Sell-to Customer No.":=FINCashOfficeUserTemplate."Default Direct Sale Customer";
                    //VALIDATE("Sell-to Customer No.");
                    SalesHeader."Order Date" := TODAY;
                    SalesHeader."Posting Date" := TODAY;
                    SalesHeader."Shipment Date" := TODAY;
                    SalesHeader."Posting Description" := 'Sales ' + FINCashOfficeUserTemplate.UserID + ',' + FINCashOfficeUserTemplate."Default Direct Sales Location" + ',' + FINCashOfficeUserTemplate."Direct Sales Item Category";
                    SalesHeader."Due Date" := TODAY;
                    Rec."Location Code" := FINCashOfficeUserTemplate."Default Direct Sales Location";
                    SalesHeader."Document Date" := TODAY;
                    SalesHeader."External Document No." := NoSeriesMgt.GetNextNo(FINCashOfficeUserTemplate."Direct Sales External Doc. Nos", TODAY, TRUE);
                    SalesHeader."Requested Delivery Date" := TODAY;

                    SalesHeader."Responsibility Center" := UserMgt.GetSalesFilter;
                    SalesHeader.INSERT;
                    PAGE.RUN(PAGE::"Cash Sale Header-Staff", SalesHeader);
                END;
        END;
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit "DocumentNoVisibility";
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::Order, Rec."No.");
    end;

    local procedure SetExtDocNoMandatoryCondition()
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        SalesReceivablesSetup.GET;
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

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
    end;

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

