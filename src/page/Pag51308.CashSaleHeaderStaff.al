page 51308 "Cash Sale Header-Staff"
{
    Caption = 'Cash Sale Card (Staff)';

    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Request Approval,Order';
    SourceTable = "Sales Header";
    // SourceTableView = WHERE("Document Type" = FILTER(Order),
    //                         "Cash Sale Order" = FILTER(true),
    //                         Status = FILTER(Open));

    layout
    {
        area(content)
        {
            group(Card)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the sales document.';
                }
                field("Posting Description"; Rec."Posting Description")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the posting of the sales document will be recorded.';
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.';
                }
                field("Sales Location Category"; Rec."Sales Location Category")
                {
                    ToolTip = 'Specifies the value of the Sales Location Category field.';
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the name of the salesperson who is assigned to the customer.';
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date on which you created the sales document.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cash Sale Order"; Rec."Cash Sale Order")
                {
                    ToolTip = 'Specifies the value of the Cash Sale Order field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(Dets)
            {
                part("Cash Sale Subform-Staff"; "Cash Sale Subform-Staff")
                {
                    SubPageLink = "Document No." = field("No.");
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
                action(Posts)
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';
                    //    Visible = false;

                    trigger OnAction()
                    begin
                        Rec."Document Date" := TODAY;
                        Rec."Posting Date" := TODAY;
                        Rec.MODIFY;
                        Rec.CALCFIELDS(Amount);
                        IF Rec.Amount = 0 THEN ERROR('Nothing to be paid for!');
                        PAGE.RUN(Page::"Cash Sale Post", Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlVisibility;
        //CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnAfterGetRecord()
    begin
        //SETFILTER("Location Code",FINCashOfficeUserTemplate."Default Direct Sales Location");
        // SETFILTER("Created By",'%1',USERID);
        //    SETFILTER("Document Date", '=%1', TODAY);
        //   SETFILTER("Sales Location Category", '%1', "Sales Location Category"::Staff);
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        EXIT(Rec.FIND(Which) AND ShowHeader);
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    var
        NewStepCount: Integer;
    begin
        REPEAT
            NewStepCount := Rec.NEXT(Steps);
        UNTIL (NewStepCount = 0) OR ShowHeader;

        EXIT(NewStepCount);
    end;

    trigger OnInsertRecord(belowxRec: Boolean): Boolean
    begin
        FINCashOfficeUserTemplate.Reset();
        FINCashOfficeUserTemplate.SetRange(FINCashOfficeUserTemplate.UserID, UserId);
        if FINCashOfficeUserTemplate.Find('-') then;
        Rec."Cash Sale Order" := true;
        Rec."Location Code" := FINCashOfficeUserTemplate."Default Direct Sales Location";
        Rec."Sell-to Customer No." := FINCashOfficeUserTemplate."Default Direct Sale Customer";
        Rec.Validate("Sell-to Customer No.");
        Rec."Created By" := USERID;
        Rec."Sales Location Category" := Rec."Sales Location Category"::Staff;
    end;

    trigger OnOpenPage()
    var
        SalesSetup: Record "Sales & Receivables Setup";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        OfficeMgt: Codeunit "Office Management";
    begin
        // IF UserMgt.GetSalesFilter <> '' THEN BEGIN
        //   FILTERGROUP(2);
        //   SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
        //   FILTERGROUP(0);
        // END;
        FINCashOfficeUserTemplate.RESET;
        FINCashOfficeUserTemplate.SETRANGE(FINCashOfficeUserTemplate.UserID, USERID);
        IF NOT FINCashOfficeUserTemplate.FIND('-') THEN ERROR('Access denied');
        FINCashOfficeUserTemplate.TESTFIELD(FINCashOfficeUserTemplate."Default Direct Sales Location");
        //  SETFILTER("Location Code", FINCashOfficeUserTemplate."Default Direct Sales Location");
        //  SETFILTER("Created By", '%1', USERID);
        //  SETFILTER("Document Date", '=%1', TODAY);
        Rec.SETFILTER("Sales Location Category", '%1', Rec."Sales Location Category"::Staff);
        //  SETRANGE("Date Filter", 0D, WORKDATE - 1);

        JobQueueActive := SalesSetup.JobQueueActive;
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
        IsOfficeAddin := OfficeMgt.IsAvailable;

        Rec.CopySellToCustomerFilter;
    end;

    var
        ApplicationAreaSetup: Record "Application Area Setup";
        //  DocPrint: Codeunit "Document-Print";
        ///  ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Management";
        Usage: Option "Order Confirmation","Work Order","Pick Instruction";
        [InDataSet]
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CRMIntegrationEnabled: Boolean;
        IsOfficeAddin: Boolean;
        CanCancelApprovalForRecord: Boolean;
        SkipLinesWithoutVAT: Boolean;
        FINCashOfficeUserTemplate: Record "FIN-Cash Office User Template";

    procedure ShowPreview()
    var
    // SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        //  SalesPostYesNo.Preview(Rec);
    end;

    local procedure SetControlVisibility()
    var
    //  ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);

        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
    end;

    local procedure Post(PostingCodeunitID: Integer)
    var
    // LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
    begin
        // IF ApplicationAreaSetup.IsFoundationEnabled THEN
        //   LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);

        // SendToPosting(PostingCodeunitID);

        // CurrPage.UPDATE(FALSE);
    end;

    procedure SkipShowingLinesWithoutVAT()
    begin
        SkipLinesWithoutVAT := TRUE;
    end;

    local procedure ShowHeader(): Boolean
    var
    //  CashFlowManagement: Codeunit "Cash Flow Management";
    begin
        // IF SkipLinesWithoutVAT AND (CashFlowManagement.GetTaxAmountFromSalesOrder(Rec) = 0) THEN
        //   EXIT(FALSE);

        // EXIT(TRUE);
    end;
}

